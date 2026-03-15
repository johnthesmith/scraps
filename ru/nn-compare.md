# Перечень топовых фрэмворков
| Фреймворк | Детерминированный режим  |
|:--        |:--                       |
| PyTorch   | Нет                      |
| vLLM      | Нет                      |
| SGLang    | Да                       |



# Использование маркой фрэймворка

|  Марка/Фреймворк> | PyTorch   | vLLM  | SGLang    | Пропр |
| :--               | :--       | :--   | :--       | :--   |
| OpenAI            | ?         | Да    | ?         | Да    |
| Gemini            | Нет       | Нет   | Нет       | Да    |
| Anthropic         | ?         | Нет   | ?         | Да    |
| Meta LLaMA        | Да        | Да    | Да        | Да    |
| DeepSeek          | Да        | Да    | Да        | Нет   |
| Qwen              | Да        | Да    | Да        | Нет   |
| GigaChat          | ?         | ?     | ?         | Да    |



# Детерминированность на основе фэймворка

| Марка / Фреймворк | PyTorch   | vLLM  | SGLang    | Пропр | Итого |
|:------------------|:------    |:----- |:-----     |:----- |:--    |
| OpenAI            | ?         | Нет   | ?         | ?     | ?     |
| Gemini            | Нет       | Нет   | Нет       | ?     | ?     |
| Anthropic         | ?         | Нет   | ?         | ?     | ?     |
| Meta LLaMA        | Нет       | Нет   | Да        | ?     | Да    |
| DeepSeek          | Нет       | Нет   | Да        | ?     | Да    |
| Qwen              | Нет       | Нет   | Да        | ?     | Да    |
| GigaChat          | ?         | ?     | ?         | ?     | ?     |



# Пример 

1. Установка флага `--enable-deterministic-inference` переводит `SGLang` см 
[документацию](https://docs.sglang.io/advanced_features/deterministic_inference.html).
