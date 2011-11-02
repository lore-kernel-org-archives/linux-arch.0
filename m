From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH] gpio: fix build error in include/asm-generic/gpio.h
Date: Wed, 2 Nov 2011 16:16:41 -0400
Message-ID: <CAMjpGUe_g9b3b+3nfi-h2k4-9WqFh1HwQ9aes6H5oUnKWRUAgQ@mail.gmail.com>
References: <CAO_0yfOa7B4tB1nJg8c_5a612KjNmPh_aMvS=wHhfU_maAvZAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57791 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab1KBURE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2011 16:17:04 -0400
In-Reply-To: <CAO_0yfOa7B4tB1nJg8c_5a612KjNmPh_aMvS=wHhfU_maAvZAg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hamo <hamo.by@gmail.com>
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

On Thu, Oct 20, 2011 at 21:38, Hamo wrote:
> Should call the platform-specific __gpio_{get,set}_value
> instead of generic gpio_{get,set}_value
>
> --- a/include/asm-generic/gpio.h
> +++ b/include/asm-generic/gpio.h
>
> =C2=A0static inline int gpio_get_value_cansleep(unsigned gpio)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0might_sleep();
> - =C2=A0 =C2=A0 =C2=A0 return gpio_get_value(gpio);
> + =C2=A0 =C2=A0 =C2=A0 return __gpio_get_value(gpio);
> =C2=A0}
>
> =C2=A0static inline void gpio_set_value_cansleep(unsigned gpio, int v=
alue)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0might_sleep();
> - =C2=A0 =C2=A0 =C2=A0 gpio_set_value(gpio, value);
> + =C2=A0 =C2=A0 =C2=A0 __gpio_set_value(gpio, value);
> =C2=A0}

your change log says very little, and this change looks incorrect to
me.  __gpio_xxx type funcs exist in the GPIOLIB case, not in the
!GPIOLIB case.  your patch is changing the !GPIOLIB case.  so i don't
see how this could work: you're now calling funcs which are not
guaranteed to exist.

i notice this because i'm seeing build failures for somethings that
are using asm-generic/gpio.h, but not GPIOLIB.

so could you explain why exactly you need this and why you think this
is the right route to go ?
-mike
