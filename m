From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] arm: add an option for erratum 657417
Date: Wed, 24 Aug 2016 19:05:30 +1000
Message-ID: <20160824190530.5b67b356@roar.ozlabs.ibm.com>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
        <2466265.8og15RQ8jv@wuerfel>
        <20160824140044.266d045d@roar.ozlabs.ibm.com>
        <3214675.EzzC1Ail5Z@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35510 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754405AbcHXJFm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2016 05:05:42 -0400
In-Reply-To: <3214675.EzzC1Ail5Z@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, linux-kbuild@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Julian Brown <julian@codesourcery.com>, Alan Modra <amodra@gmail.com>, Segher Boessenkool <segher@kernel.crashing.org>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Wed, 24 Aug 2016 09:41:39 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday, August 24, 2016 2:00:44 PM CEST Nicholas Piggin wrote:
> > On Tue, 23 Aug 2016 14:01:29 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >   
> > > On Friday, August 12, 2016 6:19:17 PM CEST Nicholas Piggin wrote:  
> > > > Erratum 657417 is worked around by the linker by inserting additional
> > > > branch trampolines to avoid problematic branch target locations. This
> > > > results in much higher linking time and presumably slower and larger
> > > > generated code. The workaround also seems to only be required when
> > > > linking thumb2 code, but the linker applies it for non-thumb2 code as
> > > > well.
> > > > 
> > > > The workaround today is left to the linker to apply, which is overly
> > > > conservative.
> > > > 
> > > > https://sourceware.org/ml/binutils/2009-05/msg00297.html
> > > > 
> > > > This patch adds an option which defaults to "y" in cases where we
> > > > could possibly be running Cortex A8 and using Thumb2 instructions.
> > > > In reality the workaround might not be required at all for the kernel
> > > > if virtual instruction memory is linear in physical memory. However it
> > > > is more conservative to keep the workaround, and it may be the case
> > > > that the TLB lookup would be required in order to catch branches to
> > > > unmapped or no-execute pages.
> > > > 
> > > > In an allyesconfig build, this workaround causes a large load on
> > > > the linker's branch stub hash and slows down the final link by a
> > > > factor of 5.
> > > > 
> > > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > >     
> > > 
> > > Thanks a lot for finding this issue. I can confirm that your patch
> > > helps noticeably in all configurations, reducing time for a relink
> > > from 18 minutes to 9 minutes on my machine in the best case, but
> > > the factor 10 slowdown of the final link with your thin archives
> > > and gc-sections patches remains.
> > > 
> > > I suspect there is still something else going on besides the 657417
> > > slowing things down, but it's also possible that I'm doing something
> > > wrong here.  
> > 
> > Okay, I was only testing thin archives. gc-sections I didn't look at.
> > With thin archives, one final arm allyesconfig link with this patch is
> > not showing a regression. gc-sections must be causing something else
> > ARM specific, because powerpc seems to link fast with gc-sections.  
> 
> Ok, I see. For completeness, here are my results with thin archives and
> without gc-sections on ARM:

This is about what I saw.

> 
> || no THUMB2, thin archives, no gc-sections, before: 144 seconds
> 
> 09:29:51   LINK    vmlinux
> 09:29:51  AR      built-in.o
> 09:29:52  LD      vmlinux.o
> 09:30:12   MODPOST vmlinux.o
> 09:30:14  GEN     .version
> 09:30:14   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
> 09:30:14   CC      init/version.o
> 09:30:15   AR      init/built-in.o
> 09:30:43  KSYM    .tmp_kallsyms1.o
> 09:31:28  KSYM    .tmp_kallsyms2.o
> 09:31:40  LD      vmlinux
> 09:32:13  SORTEX  vmlinux
> 09:32:13  SYSMAP  System.map
> 09:32:15   OBJCOPY arch/arm/boot/Image
> 
> || no THUMB2, thin archives, no gc-sections, after: 70 seconds
> 
> 09:33:54   LINK    vmlinux
> 09:33:54  AR      built-in.o
> 09:33:55  LD      vmlinux.o
> 09:34:13   MODPOST vmlinux.o
> 09:34:15  GEN     .version
> 09:34:16   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
> 09:34:16   CC      init/version.o
> 09:34:16   AR      init/built-in.o
> 09:34:24  KSYM    .tmp_kallsyms1.o
> 09:34:43  KSYM    .tmp_kallsyms2.o
> 09:34:55  LD      vmlinux
> 09:35:03  SORTEX  vmlinux
> 09:35:03  SYSMAP  System.map
> 09:35:04   OBJCOPY arch/arm/boot/Image
> 
> The final 'LD' step is much faster here as you also found, and now
> the time for the complete link is mainly the initial 'LD vmlinux.o'
> step, which did not get faster with your patch.

The info here isn't very good because KSYM is printed after the link
but before the kallsyms generation. We can kind of see what's happening
if we take the time between the KSYM and the LD vmlinux as the time for
kallsyms: 
                           before    after
KSYM                      ~12s      ~12s
LD      vmlinux.o          20s       18s
LD      .tmp_kallsyms1.o   28s        8s
LD      .tmp_kallsyms2.o   33s        7s
LD      vmlinux            33s        8s

Probably the cortex a8 workaround does not get applied to vmlinux.o
link (due to being incremental), so we don't see any speedup with the
patch. It takes longer overall I guess because it keeps a lot of
symbols in the output file (due to incremental).


> > Can you send your latest ARM patch to enable this and I'll have a look
> > at it?  
> 
> See below. I have not updated the patch description yet, but included
> the changes that Nico suggested. The test above used the same patch
> but left out the 'select LD_DEAD_CODE_DATA_ELIMINATION' line.

Thanks, I'll take a look.
