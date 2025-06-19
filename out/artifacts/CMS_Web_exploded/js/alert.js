// alerts.js

document.addEventListener('DOMContentLoaded', function () {
    const urlParams = new URLSearchParams(window.location.search);
    const msg = urlParams.get('msg');

    if (!msg) return;

    switch (msg) {
        case 'submit-success':
            Swal.fire({
                icon: 'success',
                title: 'Complaint Submitted',
                text: 'Your complaint has been successfully submitted!',
                showConfirmButton: false,
                timer: 2000
            });
            break;

        case 'update-success':
            Swal.fire({
                icon: 'success',
                title: 'Complaint Updated',
                text: 'Your complaint has been successfully updated!',
                showConfirmButton: false,
                timer: 2000
            });
            break;

        case 'delete-success':
            Swal.fire({
                icon: 'success',
                title: 'Complaint Deleted',
                text: 'Your complaint has been successfully deleted!',
                showConfirmButton: false,
                timer: 2000
            });
            break;
    }
});
