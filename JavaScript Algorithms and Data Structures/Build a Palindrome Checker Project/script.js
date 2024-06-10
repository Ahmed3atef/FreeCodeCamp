const in_text = document.getElementById('text-input');
const chk_btn = document.getElementById('check-btn')

const checkPalindrome = () => {
            const inputText = in_text.value;
            const normalizedText = inputText.toLowerCase().replace(/[^a-z0-9]/g, '');
            const reversedText = normalizedText.split('').reverse().join('');
            const result = normalizedText === reversedText ? `${inputText} is a palindrome` : `${inputText} is not a palindrome`;
            document.getElementById('result').innerText = result;
        }

const validateInput = () => {
    const inputText = in_text.value;
    switch (inputText){
        case '':
            alert("Please input a value")
            break
        default:
            checkPalindrome();
    }
}

chk_btn.addEventListener('click',validateInput)

