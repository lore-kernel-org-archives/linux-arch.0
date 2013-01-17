From: Greg Ungerer <gerg@uclinux.org>
Subject: Re: [PATCH 0/4] gpio: introduce descriptor-based interface
Date: Thu, 17 Jan 2013 22:02:06 +1000
Message-ID: <50F7E83E.8000105@uclinux.org>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com> <201301091046.13020.arnd@arndb.de> <2270940.DTxEYMZtED@percival> <201301101008.45091.arnd@arndb.de> <CACRpkda6dqAj+DzrMCnKET7Z9PtuW0+k9ea3YDL8Z1D=oFVRpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from outbound-mail02.westnet.com.au ([203.10.1.243]:40319 "EHLO
	outbound-mail02.westnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753880Ab3AQMCP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Jan 2013 07:02:15 -0500
In-Reply-To: <CACRpkda6dqAj+DzrMCnKET7Z9PtuW0+k9ea3YDL8Z1D=oFVRpQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Alex Courbot <acourbot@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Guenter Roeck <linux@roeck-us.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Steven King <sfking@fdwdc.com>

Hi Linus,

(My gerg@snapgear.com email no longer gets to me, gerg@uclinux.org is
the best direct email for me now).

On 01/17/2013 09:15 PM, Linus Walleij wrote:
> On Thu, Jan 10, 2013 at 11:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> I've tried to find platforms that don't yet use GPIOLIB and fortunately
>> there are very few left:
>>
>> I found two that provide the generic gpio interfaces when gpiolib
>> is disabled, but use gpiolib otherwise for the same hardware,
>> arch/m68k/include/asm/mcfgpio.h and arch/blackfin/include/asm/gpio.h.
>> I would assume that we can simply remove the non-gpiolib shortcut
>> here at cost of a small overhead.
> 
> Geert/Greg: interested in looking into this issue?
> 
> The GPIO maintainers want to get rid of non-gpiolib platforms.

Steven King did most of the ColdFire GPIO work (CC'ed on this).
Steven: are you happy to drop the non-gpiolib support?

Regards
Greg
