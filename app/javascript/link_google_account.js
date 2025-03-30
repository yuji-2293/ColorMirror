document.addEventListener("turbo:load", () => {

    const googleLink = document.getElementById("link-google-account");
    if (googleLink) {
        googleLink.addEventListener("click", async () => {
            const actionType = googleLink.dataset.actionType;
            const form = document.createElement("form");
            form.method = "POST";
            form.action = `/users/auth/google_oauth2?type=${actionType}`;
            form.target = "popup"; // ポップアップウィンドウで開く

            // CSRFトークンが必要な場合
            const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
            const csrfInput = document.createElement("input");
            csrfInput.type = "hidden";
            csrfInput.name = "authenticity_token";
            csrfInput.value = csrfToken;
            form.appendChild(csrfInput);

            document.body.appendChild(form);

            // ポップアップウィンドウで送信
            const width = 500;
            const height  = 600;
            const left = window.screenX;
            const top = window.screenY;

            window.open("", "popup",`"width=${width}, height=${height}", top=${top}, left=${left}`);

            form.submit();
            // 送信後フォームを削除（クリーンアップ）
            document.body.removeChild(form);
         })
    };
});
