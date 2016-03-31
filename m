From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] asm-generic/io.h: provide default ioremap/iounmap for !HAS_IOMEM
Date: Thu, 31 Mar 2016 10:39:49 +0200
Message-ID: <CAMuHMdWXJU9wnB4zuR3dGt3AVjPzUaNth1FtQ78mneAf-joesA@mail.gmail.com>
References: <1459275781-3863-1-git-send-email-robh@kernel.org>
	<3074778.3TElYrXjM1@wuerfel>
	<CAL_JsqKsXirYNa-mUTKqeP4ra8w+MW55we8pFmN=S0a7osLy4w@mail.gmail.com>
	<CAMuHMdWc_97Yk7XJ6e4n6tibs99pPHSnJU2qqC7CGcoo4kWuNA@mail.gmail.com>
	<CAL_JsqL+fdh2_UZx=vPuOXMMiLJZEd7AvqZpAucEkwOfPZWgog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35517 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbcCaIju (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Mar 2016 04:39:50 -0400
In-Reply-To: <CAL_JsqL+fdh2_UZx=vPuOXMMiLJZEd7AvqZpAucEkwOfPZWgog@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Richard Weinberger <richard@nod.at>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Hi Rob,

On Wed, Mar 30, 2016 at 11:20 PM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Mar 30, 2016 at 3:08 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Tue, Mar 29, 2016 at 10:13 PM, Rob Herring <robh@kernel.org> wrote:
>>> Ewww. Why do the opposite of what we do for every other Kconfig symbol
>>> which is provide empty functions? It really only functions as a
>>> disable on UML flag which runs counter to enabling drivers to build
>>> for all arches.
>>
>> Usually the empty function fall into one of two classes:
>>   1. They return an error, so drivers will abort their initialization,
>>   2. They are a plain no-op, for functions with harmless side-effects.
>>
>> The !MMU versions are not dummies, but assume a transparent translation.
>> This may lead to drivers continuing their initialization and crashing the
>> system.
>
> I thought about this, but how could you even get to the point of
> having some physical address passed to the driver? Perhaps some old
> ISA driver, but I'm not sure memory ranges were ever fixed (only i/o).
> We're really only talking about UML here.

Hmm, perhaps it indeed can't happen.

>>> I actually started a patch to remove the HAS_IOMEM dependency
>>> everywhere (or just the per driver cases). It didn't break as bad as I
>>> expected, but became more than I wanted to fix. Mainly, all the devm_
>>> variants also need empty versions or to be always enabled.
>>
>> Should these dependencies on HAS_IOMEM be changed to "HAS_IOMEM ||
>> COMPILE_TEST"?
>
> Why? Most are either HAS_IOMEM or HAS_IOMEM && COMPILE_TEST.

COMPILE_TEST is meant to enable drivers that are not useful, due to missing
infrastructure.
Without having it enabled, you don't want to include useless drivers.
If you have dummies, you still want the HAS_IOMEM dependency to avoid
compiling useless drivers. I.e. it's a hint for distros, who don't want to ship
useless drivers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
