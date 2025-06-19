// signup.js

document.addEventListener("DOMContentLoaded", function () {
    const passwordInput = document.getElementById("password");
    const confirmInput = document.getElementById("confirmPassword");
    const strengthDisplay = document.getElementById("passwordStrength");
    const signupForm = document.getElementById("signupForm");

    function checkPasswordStrength(password) {
        const strongPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,}$/;
        const mediumPattern = /^(?=.*[a-zA-Z])(?=.*\d).{6,}$/;

        if (strongPattern.test(password)) {
            strengthDisplay.textContent = "Strong password";
            strengthDisplay.className = "password-strength strength-strong";
        } else if (mediumPattern.test(password)) {
            strengthDisplay.textContent = "Medium strength";
            strengthDisplay.className = "password-strength strength-medium";
        } else {
            strengthDisplay.textContent = "Weak password";
            strengthDisplay.className = "password-strength strength-weak";
        }
    }

    passwordInput.addEventListener("input", () => {
        checkPasswordStrength(passwordInput.value);
    });

    signupForm.addEventListener("submit", function (e) {
        const password = passwordInput.value;
        const confirm = confirmInput.value;

        if (password !== confirm) {
            e.preventDefault();
            alert("Passwords do not match!");
            confirmInput.focus();
        }
    });
});
