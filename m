From: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH] arch: m68k: include: asm: the 3rd parameter of 'insl' and
 'outsl' need '<< 2'
Date: Fri, 7 Jun 2013 10:47:45 +1200
Message-ID: <CAOmrzkKROD5gkLdme7C2wF4NVMCB=i4_Tr+MVWt0DoVh9E5biw@mail.gmail.com>
References: <51A71E49.1000707@asianux.com>
	<CAMuHMdUz8o4d=RiAMW8-pCrnZyfoH9EETVqjcb7E1GqCgYmQ7g@mail.gmail.com>
	<51A93FA0.1050203@biophys.uni-duesseldorf.de>
	<51A94281.7050708@biophys.uni-duesseldorf.de>
	<51AC6472.3060606@asianux.com>
	<CAMuHMdVLA_zgeGxTTzfXnBYZiihH3w+LLcW0cRzVk_dvkFojgg@mail.gmail.com>
	<51AE87DF.5000301@asianux.com>
	<51AEE7C0.9060206@biophys.uni-duesseldorf.de>
	<Pine.BSM.4.64L.1306050936200.18048@herc.mirbsd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:61559 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab3FFWrq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jun 2013 18:47:46 -0400
In-Reply-To: <Pine.BSM.4.64L.1306050936200.18048@herc.mirbsd.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thorsten Glaser <tg@mirbsd.de>
Cc: Chen Gang <gang.chen@asianux.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@uclinux.org>, schmitz@debian.org, Sam Ravnborg <sam@ravnborg.org>, Greg KH <gregkh@linuxfoundation.org>, linux-m68k <linux-m68k@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Thorsten,

>> No need for the #ifdef CONFIG_Q40 - Q40 is the only m68k subarch tha=
t builds
>> the parport_pc module (which includes parport.h), IIRC. Is that corr=
ect,
>> Thorsten?
>
> The header is included outside of Q40. There is no Q40 kernel
> in Debian (yet). So, no.

OK, so it's the Amiga use of parport_pc that you had issues with. I
really should stop
relying on my increasingly fuzzy memory.

Looking at the arch defconfigs, neither Amiga or Atari defines
CONFIG_PARPORT_PC.
Is this driver used on any m68k subarch at all? At this stage I'm not
even certain it is
in fact used on Q40.

Anyway, back to the patch at hand: any change to parport_pc.h should
not affect m68k at all,
so you're free to patch this any way you please.

Changes to m68k asm/io.h should be avoided unless shown to cause no
harm to existing drivers.
I can't see direct use of insl/outsl in Atari m68k drivers I checked,
but due to the slightly tangled
nature of m68k io.h, these may get pulled in through macros yet. I'd
prefer the code stays as-is.

Regards,

   Michael


2013/6/6 Thorsten Glaser <tg@mirbsd.de>:
> schmitz dixit:
>
>> No need for the #ifdef CONFIG_Q40 - Q40 is the only m68k subarch tha=
t builds
>> the parport_pc module (which includes parport.h), IIRC. Is that corr=
ect,
>> Thorsten?
>
> The header is included outside of Q40. There is no Q40 kernel
> in Debian (yet). So, no.
>
> bye,
> //mirabilos
> --
> 17:08=E2=8E=9C=C2=ABVutral=C2=BB fr=C3=BCher gabs keine packenden sma=
rtphones und so
> 17:08=E2=8E=9C=C2=ABVutral=C2=BB heute gibts frauen die sind facebook=
s=C3=BCchtig
> 17:10=E2=8E=9C=C2=ABVutral=C2=BB aber auch traurig; fr=C3=BCher warst=
 du als nerd voll am arsch
> 17:10=E2=8E=9C=C2=ABVutral=C2=BB heute bist du als nerd der einzige d=
er wirklich damit klarkommt
