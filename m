From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm: add an option for erratum 657417
Date: Wed, 24 Aug 2016 17:01:30 +0200
Message-ID: <2147968.tzghefjZMo@wuerfel>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com> <20160824190530.5b67b356@roar.ozlabs.ibm.com> <20160824205646.4d6170e1@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:53047 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755085AbcHXPC3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2016 11:02:29 -0400
In-Reply-To: <20160824205646.4d6170e1@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, linux-kbuild@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Julian Brown <julian@codesourcery.com>, Alan Modra <amodra@gmail.com>, Segher Boessenkool <segher@kernel.crashing.org>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Wednesday, August 24, 2016 8:56:46 PM CEST Nicholas Piggin wrote:
> On Wed, 24 Aug 2016 19:05:30 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
> > Thanks, I'll take a look.
> 
> Okay, I can't reproduce your bad linking times even with gc-sections. It's
> possible I'm doing something wrong, but with my patches + your patch and
> standard arm allyesconfig:
> 
>   20:33:56  AR      built-in.o
>   20:33:57  LD      vmlinux.o
>   MODPOST vmlinux.o
>   20:34:12  GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.o
>   20:34:24  KSYM    .tmp_kallsyms1.o
>   20:34:45  KSYM    .tmp_kallsyms2.o
>   20:34:54  LD      vmlinux
>   20:35:07  SORTEX  vmlinux
>   20:35:07  SYSMAP  System.map
> 
> I have about 71 seconds for the final link phase.


I've tracked down my remaining build time regression to
a bad binutils snapshot (2.26.51) I had been using, and upgraded
to the 2.27 release now, which is roughly the same as what
you have:

14:45:41   LINK    vmlinux
14:45:41  AR      built-in.o
14:45:42  LD      vmlinux.o
14:51:49   MODPOST vmlinux.o
14:51:51  GEN     .version
14:51:51   CHK     include/generated/compile.h
  UPD     include/generated/compile.h
14:51:51   CC      init/version.o
14:51:52   AR      init/built-in.o
14:52:04  KSYM    .tmp_kallsyms1.o
14:52:31  KSYM    .tmp_kallsyms2.o
14:52:43  LD      vmlinux
14:52:55  SORTEX  vmlinux
14:52:55  SYSMAP  System.map
14:52:56   OBJCOPY arch/arm/boot/Image

The long minutes that were spent in "arm-linux-gnueabi-ld 
-r -o vmlinux.o --whole-archive built-in.o" are all gone now.

I still see a problem with big-endian builds failing with
thinarc/gc-sections, I'll investigate that some other day,
or you could have a look at that if you want to make sure
it's an ARM specific problem, not something with your
patches in general.

The patch that I sent for enabling the two on ARM blocks
out CONFIG_CPU_BIG_ENDIAN, so just revert that hunk to see
the problem. It's possible that it only breaks when doing
a big-endian build after a little-endian build without
a "make clean" inbetween.

	Arnd
