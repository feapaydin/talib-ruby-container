A Ruby on Rails docker container with TaLib library setup and a basic endpoint for technical analysis.

## Deployment

Build the docker image using the command

`docker build . -t talib`

Run the container with

`docker run -p 3000:3000 talib`

Or you can deploy the image to the Heroku directly. See [Building Docker Images with heroku.yml](https://devcenter.heroku.com/articles/build-docker-images-heroku-yml)


## Usage

This is a Ruby on Rails application with an endpoint to run technical analysis using TaLib functions.
You can check out the list of available functions at [TaLib function list page.](https://ta-lib.org/function.html) \[1\]

### The Endpoint

After you start the server, you can use the following endpoint to perform technical analyses.

`POST http://localhost:3000/calculation/:function_name`

The **:function_name** variable defines which technical analysis will be performed. You can use values like macd, rsi, ma, apo etc.

```
POST http://localhost:3000/calculation/macd
POST http://localhost:3000/calculation/rsi
POST http://localhost:3000/calculation/ma
...
```

Check out the [sample postman collection file](talib_ruby.postman_collection.json) for examples.

___
##### \[TR\]

# Endpoint

**İstek Yolu:** /calculation/:function_name

[Örnek Postman Dosyası](talib_ruby.postman_collection.json)

## Fonksiyon Listesi

URL'nin en sonunda yer alan kısım (macd, rsi, apo...) gibi istenen fonksiyon için dinamiktir.

Tüm fonksiyonların listesi:  
[https://ta-lib.org/function.html](https://ta-lib.org/function.html) \[1\]

## Parametreler

Her metodun aldığı parametreler farklıdır. Örneğin momentum metodları için hangi metodun hangi parametreyi alacağına aşağıdan bakılabilir:  
[https://mrjbq7.github.io/ta-lib/func_groups/momentum_indicators.html](https://mrjbq7.github.io/ta-lib/func_groups/momentum_indicators.html) \[2\]

Tüm fonksiyonların parametreleri için:  
[https://mrjbq7.github.io/ta-lib/doc_index.html](https://mrjbq7.github.io/ta-lib/doc_index.html) \[3\]

Buradaki fonksiyonların *high, low, close, volume* gibi veriyi ifade eden parametreleri dokümanda yazan sırayla **data_list** içerisine array olarak gönderilmelidir. Geriye kalan veriler **option_list** içerisinde yine aynı sırayla gönderilebilir.

### MACD Örnek

Örneğin MACD için dokümanda belirtilen parametreler  
`MACD(close, fastperiod=12, slowperiod=26, signalperiod=9)`  
şeklindedir.  
Burada yazan *close* günlük kapanış datasıdır ve data_list içerisinde array olarak gönderilir.  
Geriye kalan *fastperiod, slowperiod, signalperiod* verileri sırasıyla **option_list** içerisinde 12,26,9 olarak gönderilir.

### MFI Örnek

MFI için ise durum farklıdır.  
`MFI(high, low, close, volume, timeperiod=14)`  
Aynı anda *high, low, close, volume* verileri alır. Bunların üçü de aynı sırayla **data_list** içinde array olarak gönderilmelidir. En sonda yer alan *timeperiod* ise **option_list** içerisinde arrayın tek elemanı olarak gönderilmelidir.

## Response

Bazı metodlar birden çok output yaratır. Örneğin RSI fonksiyonu tek bir array olarak yanıt dönerken MACD üç ayrı array yanıtı döner. Bu yanıtlar çağırılan fonksiyona göre kaç tane olursa olsun gelen cevapta payload arrayı içerisinde yer alır.

MACD için:

*   payload\[0\] = macd dizisi
*   payload\[1\] = macd_signal dizisi
*   payload\[2\] = macd_hist dizisi
    

Hangi foksiyonun kaç değer döndürdüğü yukarıdaki **referans\[2\]** ve **referans\[3\]** de mevcuttur.

## Yararlı Kaynaklar

[https://ta-lib.org/d_api/d_api.html](https://ta-lib.org/d_api/d_api.html)  
TaLib metodlarının dinamik yapısını anlamak için **3.1. Direct Call to a TA Function** kısmına göz atın.

*Furkan Enes, Aralık 2021*