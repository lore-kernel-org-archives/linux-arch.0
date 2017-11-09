From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 29/31] MAINTAINERS: Add nds32
Date: Thu, 9 Nov 2017 17:46:45 +0800
Message-ID: <CAEbi=3eSpeOCwpd=6_hcLx1wsWfAjQAPV-hdZ0R-gsznnnVziw@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <16035efb78f70411998755693339471032743377.1510118606.git.green.hu@gmail.com>
 <CAL_JsqLe847Dhta2vkbaUqRdfaQnsPCncR2bZZNP-_kzvm25wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLe847Dhta2vkbaUqRdfaQnsPCncR2bZZNP-_kzvm25wg@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Greentime <greentime@andestech.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, netdev <netdev@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

2017-11-08 21:31 GMT+08:00 Rob Herring <robh+dt@kernel.org>:
> On Tue, Nov 7, 2017 at 11:55 PM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>> ---
>>  MAINTAINERS |    9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2f4e462..bce1181 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -857,6 +857,15 @@ X: drivers/iio/*/adjd*
>>  F:     drivers/staging/iio/*/ad*
>>  F:     drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>>
>> +ANDES ARCHITECTURE
>> +M:     Greentime Hu <green.hu@gmail.com>
>> +M:     Vincent Chen <deanbo422@gmail.com>
>> +T:     git https://github.com/andestech/linux.git
>> +S:     Supported
>> +F:     arch/nds32
>
> DT binding files?

Thanks.
I should add
F:    Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
F:    Documentation/devicetree/bindings/nds32/cpus.txt

I will fix it in the next version patch.

>
>> +K:     nds32
>> +N:     nds32
>> +
>>  ANDROID CONFIG FRAGMENTS
>>  M:     Rob Herring <robh@kernel.org>
>>  S:     Supported
>> --
>> 1.7.9.5
>>
