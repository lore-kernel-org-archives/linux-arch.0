Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.142]:47457 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbeIESX2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Sep 2018 14:23:28 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id E960320F15
        for <linux-arch@vger.kernel.org>; Wed,  5 Sep 2018 15:53:06 +0200 (CEST)
Subject: Re: [PATCH v3 2/2] tty/serial: atmel: add ISO7816 support
References: <20180807130049.5957-1-ludovic.desroches@microchip.com>
 <20180807130049.5957-3-ludovic.desroches@microchip.com>
 <d66c4318-1d31-5c4e-3952-6b69a010b028@sorico.fr>
 <20180809113035.kftvdalca7zsf4ly@M43218.corp.atmel.com>
 <20180905124341.5n4gadgd5luza7fd@M43218.corp.atmel.com>
From: Richard Genoud <richard.genoud@gmail.com>
Message-ID: <211528d5-81b6-46f2-4191-66023d928ae3@sorico.fr>
Date: Wed, 5 Sep 2018 15:53:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180905124341.5n4gadgd5luza7fd@M43218.corp.atmel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alexandre.belloni@bootlin.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, jslaby@suse.com, Nicolas Ferre <nicolas.ferre@microchip.com>
Message-ID: <20180905135302.sjqLDMqpnflKuMXbUAH63HjJZJERez24x6_dM9fMnIE@z>

[added Nicolas back in the thread, he was removed somehow]

Hi Ludovic !

On 05/09/2018 14:43, Ludovic Desroches wrote:
> Hi Richard,
> 
> On Thu, Aug 09, 2018 at 01:30:35PM +0200, Ludovic Desroches wrote:
>> Hi Richard,
>>
>> On Thu, Aug 09, 2018 at 10:47:17AM +0200, Richard Genoud wrote:
>>> Hi !
>>>
>>> On 07/08/2018 15:00, Ludovic Desroches wrote:
>>>> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>>
>>>> When mode is set in atmel_config_iso7816() we backup last RS232 mode
>>>> for coming back to this mode if requested.
>>>> Also allow setup of T=0 and T=1 parameter and basic support in set_termios
>>>> function as well.
>>>>
>>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>> [ludovic.desroches@microchip.com: rebase, add check on fidi ratio, checkpatch fixes]
>>>> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
>>>> ---
>>>>  drivers/tty/serial/atmel_serial.c | 211 +++++++++++++++++++++++++++++++++++---
>>>>  drivers/tty/serial/atmel_serial.h |   6 +-
>>>>  2 files changed, 201 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
>>>> index 8e4428725848..4a7ec44b0ace 100644
>>>> --- a/drivers/tty/serial/atmel_serial.c
>>>> +++ b/drivers/tty/serial/atmel_serial.c
>>
>> [...]
>>
>>>>  #if defined(CONFIG_OF)
>>>> +static struct atmel_uart_pdata at91rm9200_pdata = {
>>>> +	.fidi_min = 1,
>>>> +	.fidi_max = 2047,
>>>> +};
>>>> +
>>>> +static struct atmel_uart_pdata at91sam9260_pdata = {
>>>> +	.fidi_min = 1,
>>>> +	.fidi_max = 2047,
>>>> +};
>>>> +
>>>> +static struct atmel_uart_pdata sama5d3_pdata = {
>>>> +	.fidi_min = 3,
>>>> +	.fidi_max = 65535,
>>> Are you sure this is for sama5d3 ?
>>> From the datasheets I have, 65535 is for sama5d4/sama5d2
>>
>> I checked it and I missed it. What a pity... In fact, it's a bit more
>> tricky since the min value for d3 is 3 and no longer 1.
>>
>>> And also, you'll have to s/atmel,at91sam9260-usart/atmel,sama5d2-usart/g
>>> in sama5d{2,4}.dtsi
>>>
>>
>> Yes, I planed to send it later but I can add those patches within this
>> set of patches. 
>>
>>> But I wonder if it could be detected via ATMEL_US_VERSION instead ?
>>>
>>
>> I have not checked, I tend to prefer the compatible string for this kind
>> of thing. But as we already use the version number, I can investigate
>> this solution if it's the one you prefer.
>>
> 
> ping about this question still in suspend in order to prepare a new version.
Well, if we use the compatible string for this, we will have to add :
- atmel,sama5d2-usart
- atmel,sama5d3-usart
- (maybe others ?)
to the already existing :
- atmel,at91sam9260-usart
- atmel,at91rm9200-usart
just for setting different limits on the fidi register.
IMHO, it seems a bit overkill. Moreover, the ATMEL_US_VERSION has
already been read, so...
But if you think adding compatible strings is a better/cleaner solution, just convince me ! :)
