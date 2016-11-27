(function(){
    
    var modal = document.getElementsByClassName("open-modal");

    //получение всех кнопок "open-modal" Todo запретить открытие в новых вкладках
    [].slice.call(modal).forEach(function(el) {
        var href = el.getAttribute("href"),
            modalWindow = document.querySelector(href),
            modalWindowContent = modalWindow.firstElementChild,
            close = modalWindow.querySelector(".modal-content__close-btn"),
            html = document.getElementsByTagName("html")[0];

        /* Клики на кнопку войти "open-modal" */
        el.addEventListener("click", function(e) {
            e.preventDefault();
            if (!modalWindow.classList.contains("modal__active")) {
                modalWindow.classList.add("modal__active");
                modalWindowContent.classList.add("modal__content__active");
                html.classList.add("modal-lock");
            }
        });

        /* Клики на внешнюю область модального окна */
        modalWindow.addEventListener("click", function(e) {
            e.preventDefault();
            if (e.target.id === href.substr(1)) {
                if (modalWindow.classList.contains("modal__active")) {
                    modalWindow.classList.remove("modal__active");
                    modalWindowContent.classList.remove("modal__content__active");
                    html.classList.remove("modal-lock");
                }
            }
        });

        /* Клики на кнопку закрыть */
        close.addEventListener("click", function(e) {
            e.preventDefault();
            if (modalWindow.classList.contains("modal__active")) {
                modalWindow.classList.remove("modal__active");
                modalWindowContent.classList.remove("modal__content__active");
                html.classList.remove("modal-lock");
            }
        });

    });

})();
