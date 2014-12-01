%global        with_python3 1

# sitelib for noarch packages, sitearch for others (remove the unneeded one)
%{!?python_sitelib: %global python_sitelib %(%{__python} -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")}

%if 0%{?with_python3}
%{!?python3_sitelib: %global python3_sitelib %(%{__python3} -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")}
%endif

Name:           python-colorlog
Version:        2.4.0
Release:        1%{?dist}
Summary:        A colored formatter for the python logging module

License:        MIT License
URL:            https://pypi.python.org/pypi/colorlog
Source0:        https://pypi.python.org/packages/source/c/colorlog/colorlog-%{version}.tar.gz

BuildArch:      noarch
BuildRequires:  python-devel
BuildRequires:  python-setuptools
%if 0%{?with_python3}
BuildRequires:  python3-devel
BuildRequires:  python3-setuptools
%endif

%description

%if 0%{?with_python3}
%package -n    python3-colorlog
Summary:       A colored formatter for the python3 logging module

%description -n python3-colorlog
%endif # if with_python3

%prep
%setup -q -n colorlog-%{version}


%build


%install
rm -rf $RPM_BUILD_ROOT
%if 0%{?with_python3}
%{__python3} setup.py install --root %{buildroot}
%endif # with_python3
%{__python} setup.py install --root %{buildroot}

 
%files
%doc
%{python_sitelib}/*

%files -n python3-colorlog
%doc
%{python3_sitelib}/*

%changelog
* Wed Aug 27 2014 Bart Vanbrabant
- Initial package of colorlog 2.4.0

