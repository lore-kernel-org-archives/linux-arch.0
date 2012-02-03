From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] gpiolib/arches: Centralise bolierplate asm/gpio.h
Date: Fri, 3 Feb 2012 16:16:28 -0700
Message-ID: <CACxGe6sbwy8z+U8=5rtvjyDrt3SZD2N33GiGHwPOMUAxt_BXTA@mail.gmail.com>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAJaTeTp2w85UHnmH-PPMZsQGQMNa-93kw-tjmDxA_wjJXkYQcQ@mail.gmail.com> <20111026073348.GB2915@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20111026073348.GB2915@opensource.wolfsonmicro.com>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Mike Frysinger <vapier@gentoo.org>, Russell King <linux@arm.linux.org.uk>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 26, 2011 at 1:33 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Oct 25, 2011 at 07:44:14PM -0400, Mike Frysinger wrote:
>
>> i don't think this is generally how asm-generic is handled. =A0inste=
ad, how about:
>> =A0- move the duplicate code to asm-generic/gpio.h
>> =A0- have the arches which merely need asm-generic/gpio.h add "gener=
ic-y
>> +=3D gpio.h" to their include/asm/Kbuild
>> =A0- for arches which need to override these common funcs in some wa=
y,
>> add #ifdef protection to the asm-generic/gpio.h
>
>> and it seems like with slightly more work, this path allow you to
>> merge most of arch/sh/include/asm/gpio.h. =A0and it has the advantag=
e of
>> not needing new Kconfig symbols.
>
> That's really not how gpiolib is currently handled, unfortunately -
> trying to transition over to that model in one patch would be way too
> much.
>
> The goal here from that point of view is to make transitioning to
> something more sensible easier by getting rid of the boilerplate code=
,
> it makes doing the more invasive changes like you're suggesting much
> easier as we're only dealing with the architectures that are actually
> doing something. =A0It also means that we're able to immediately work=
 on
> turning on gpiolib on random architectures which is a definite win.

I had picked up this patch, but I've dropped again from gpio/next
since there are still a lot of drivers including asm/gpio.h.  It
caused build breakage on linux-next with allmodconfig.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
