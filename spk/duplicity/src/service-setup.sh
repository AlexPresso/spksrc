
### service-setup.sh

PYTHON_DIR="/var/packages/python310/target/bin"
VIRTUALENV="${PYTHON_DIR}/python3 -m venv"
PATH="${SYNOPKG_PKGDEST}/env/bin:${SYNOPKG_PKGDEST}/bin:${PYTHON_DIR}:${PATH}"

service_postinst ()
{
    # Create a Python virtualenv
    ${VIRTUALENV} --system-site-packages ${SYNOPKG_PKGDEST}/env

    # Install the wheels
    ${SYNOPKG_PKGDEST}/env/bin/pip install --no-deps --no-input --upgrade --no-index --find-links ${SYNOPKG_PKGDEST}/share/wheelhouse ${SYNOPKG_PKGDEST}/share/wheelhouse/*.whl

    # create link in bin folder
    ln -sf ${SYNOPKG_PKGDEST}/env/bin/duplicity ${SYNOPKG_PKGDEST}/bin/duplicity
}

