from setuptools import setup, find_packages

setup (
    name                    = "todobackend",
    version                 = "0.1.0",
    description             = "Todobackend Django REST service",
    packages                = find_packages(),
    include_package_data    = True,
    scripts                 = ["manage.py"],
    install_requires         = ["Django==1.11.29",
                                "django-cors-headers==3.0.2",
                                "djangorestframework==3.9.4",
                                "mysqlclient==1.4.6",
                                "uwsgi>=2.0"],
    extras_require           = {
                                "test": [
                                    "colorama==0.4.6",
                                    "coverage==5.5",
                                    "django-nose==1.4.7",
                                    "nose==1.3.7",
                                    "pinocchio==0.4.3"
                                ]      
                             }
)