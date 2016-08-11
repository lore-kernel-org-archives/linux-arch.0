From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [EXPERIMENTAL] enable thin archives and --gc-sections on ARM
Date: Thu, 11 Aug 2016 22:37:04 +0200
Message-ID: <7664972.4URQm6Y4Ik@wuerfel>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com> <3116731.ej669o70yG@wuerfel> <alpine.LFD.2.20.1608111536290.17623@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.20.1608111536290.17623@knanqh.ubzr>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Thursday, August 11, 2016 4:01:33 PM CEST Nicolas Pitre wrote:
> >  #ifdef CONFIG_SMP_ON_UP
> >       .init.smpalt : {
> >               __smpalt_begin = .;
> > -             *(.alt.smp.init)
> > +             KEEP(*(.alt.smp.init))
> 
> Yes unfortunately this needs a KEEP() right now as there is no explicit 
> references to those entries. But by doing so you force a reference from 
> those entries to all functions they annotate, preventing those functions 
> from being discarded if there isn't any reference to that code 
> otherwise. That's a case that falls into the "missing forward reference" 
> category in my slides.

I see. This actually relates to an existing problem with SMP alternatives
in exit sections, which cause a linker error. I've done a patch for
this at some point, but didn't feel confident enough to send it out

commit 0c598e53b3a0ad7daf077603618001edcf9bface
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Sun Mar 16 20:14:30 2014 +0100

    ARM: don't discard exit sections for spinlock debugging
    
    This avoids lots of warnings like this one:
    
    `.exit.text' referenced in section `.alt.smp.init' of drivers/built-in.o: defined in discarded section `.exit.text' of drivers/built-in.o
    
    for each spinlock that is used in an __exit function, because
    the smp alternatives try to patch out the spinlock locations.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index d24e5dd2aa7a..1f5eeeb4c8d0 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -43,8 +43,7 @@
 #define ARM_CPU_KEEP(x)
 #endif
 
-#if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || \
-	defined(CONFIG_GENERIC_BUG) || defined(CONFIG_JUMP_LABEL)
+#if defined(CONFIG_SMP_ON_UP) || defined(CONFIG_GENERIC_BUG) || defined(CONFIG_JUMP_LABEL)
 #define ARM_EXIT_KEEP(x)	x
 #define ARM_EXIT_DISCARD(x)
 #else

