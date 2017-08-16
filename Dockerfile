# tripleo-reports-centos7
# Here you can use whatever base image is relevant for your application.
FROM centos:centos7

# Here you can specify the maintainer for the image that you're building
MAINTAINER Alex Schultz <aschultz@redhat.com>

# Export an environment variable that provides information about the application version.
# Replace this with the version for your application.
ENV TRIPLEO_REPORTS_VERSION=0.0.1

# Set the labels that are used for OpenShift to describe the builder image.
LABEL io.k8s.description="TripleO Reports WebApp" \
    io.k8s.display-name="TripleO Reports 0.0.1" \
    io.openshift.expose-services="8080:http" \
    io.openshift.tags="builder,webserver,tripleo" \
    # this label tells s2i where to find its mandatory scripts
    # (run, assemble, save-artifacts)
    io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"

# Install the pip and clean the yum cache
RUN yum install -y epel-release && \
    yum install -y python-pip && \
    yum clean all

# Copy the S2I scripts to /usr/libexec/s2i since we set the label that way
COPY ./s2i/bin/ /usr/libexec/s2i

RUN useradd -r -u 1001 reports
RUN mkdir /tripleo-reports
COPY requirements.txt /tripleo-reports/
RUN chown -R 1001 /tripleo-reports
RUN pip install -r /tripleo-reports/requirements.txt
RUN pip freeze > /tripleo-reports/installed-requirements.txt

USER 1001

# Set the default port for applications built using this image
EXPOSE 8080

# Modify the usage script in your application dir to inform the user how to run
# this image.
CMD ["/usr/libexec/s2i/usage"]
