From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] asm-generic/gpio.h: merge basic gpiolib wrappers
Date: Fri, 28 Oct 2011 16:04:47 +0200
Message-ID: <CAJaTeTrbzVH15Hh-uRMvrJJUUPdhKMjL7Z4NwsN17oJLn190FA@mail.gmail.com>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1319720503-3183-1-git-send-email-vapier@gentoo.org> <20111027131124.GK19187@n2100.arm.linux.org.uk>
 <CAJaTeTp71t0BYsEpDu07BE5ox2FBAiH7xEQqjhb=6QadrsQGAQ@mail.gmail.com>
 <20111028124200.GU19187@n2100.arm.linux.org.uk> <CACRpkda4NvJeh3X6M57tV_9BbAvY99KQikxB+e0nXtABKU2mQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33421 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab1J1OFJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 10:05:09 -0400
In-Reply-To: <CACRpkda4NvJeh3X6M57tV_9BbAvY99KQikxB+e0nXtABKU2mQg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

On Fri, Oct 28, 2011 at 15:51, Linus Walleij wrote:
> On Fri, Oct 28, 2011 at 2:42 PM, Russell King - ARM Linux wrote:
>> On Fri, Oct 28, 2011 at 02:15:00PM +0200, Mike Frysinger wrote:
>>>
>>> it's interesting you highlight davinci. =A0if i'm reading things
>>> correctly, the current davinci code is broken today and my v2 propo=
sed
>>> patch actually fixes it.
>>
>> That looks like an error in patch 5f3fcf9649dbb010ccac41259d04147775=
ec8fc2
>> (ARM: 7040/1: mach-davinci: break out GPIO driver specifics) which d=
oes
>> this:
>>
>> -#define __ARM_GPIOLIB_COMPLEX
>>
>> Linus, can you send a fix?
>
> OK I'm onto it.
>
> Sorry for the mess!

thanks ... i'll wait for the fix (please cc me) and redo my gpio
change on top of that.  i need to send a v3 anyways since the v2 does
break one platform.
-mike
