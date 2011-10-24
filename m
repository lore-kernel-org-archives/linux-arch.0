From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] gpio: fix build error in include/asm-generic/gpio.h
Date: Tue, 25 Oct 2011 00:04:02 +0200
Message-ID: <CACxGe6sFrJh+Y5CJVMTPiWH3m=j+J_YUzLP=MiaBbsvDkeA_Jg@mail.gmail.com>
References: <CAO_0yfOa7B4tB1nJg8c_5a612KjNmPh_aMvS=wHhfU_maAvZAg@mail.gmail.com>
 <201110211339.59280.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63945 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756072Ab1JXWEX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2011 18:04:23 -0400
In-Reply-To: <201110211339.59280.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hamo <hamo.by@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 21, 2011 at 1:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 21 October 2011, Hamo wrote:
>> Should call the platform-specific __gpio_{get,set}_value
>> instead of generic gpio_{get,set}_value
>>
>> Signed-off-by: Yang Bai <hamo.by@gmail.com>
>> ---
>> =A0include/asm-generic/gpio.h | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Grant, can you put that into the gpio tree?

I can.

Hamo, next time make sure you cc: the relevant subsystem maintainer
(in this case, me) when submitting patches.  You can find the
maintainer by using ./scripts/get_maintainer.pl, or by looking at the
MAINTAINERS file.  It is more work for me when I don't receive the
patch directly in my inbox.

g.

>
>> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
>> index d494001..6acff5d 100644
>> --- a/include/asm-generic/gpio.h
>> +++ b/include/asm-generic/gpio.h
>> @@ -220,13 +220,13 @@ static inline int gpio_cansleep(unsigned gpio)
>> =A0static inline int gpio_get_value_cansleep(unsigned gpio)
>> =A0{
>> =A0 =A0 =A0 might_sleep();
>> - =A0 =A0 return gpio_get_value(gpio);
>> + =A0 =A0 return __gpio_get_value(gpio);
>> =A0}
>>
>> =A0static inline void gpio_set_value_cansleep(unsigned gpio, int val=
ue)
>> =A0{
>> =A0 =A0 =A0 might_sleep();
>> - =A0 =A0 gpio_set_value(gpio, value);
>> + =A0 =A0 __gpio_set_value(gpio, value);
>> =A0}
>>
>> =A0#endif /* !CONFIG_GPIOLIB */
>> --
>> 1.7.1
>>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
