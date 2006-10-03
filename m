Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.ocs.com.au ([202.147.117.210]:44854 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S965540AbWJCAJy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2006 20:09:54 -0400
From: Keith Owens <kaos@sgi.com>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers 
In-reply-to: Your message of "Tue, 12 Sep 2006 17:27:14 +0100."
             <3951.1158078434@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Oct 2006 10:10:25 +1000
Message-ID: <18466.1159834225@ocs3.ocs.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells (on Tue, 12 Sep 2006 17:27:14 +0100) wrote:
>
>Patch 3/3 seems to be stuck on the linux-arch mailing list and is either
>delayed or maybe has been discarded, probably due to its size (about a
>megabyte).  It can be downloaded from here:
>
>	http://people.redhat.com/~dhowells/irq-global-regs.diff.bz2

This blows up immediately on IA64.

  GEN     /build/kaos/2.6.18-irq-global/obj/Makefile
scripts/kconfig/conf -s arch/ia64/Kconfig
  Using /build/kaos/2.6.18-irq-global/linux-2.6 as source for kernel
  GEN     /build/kaos/2.6.18-irq-global/obj/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-ia64
  CC      arch/ia64/kernel/asm-offsets.s
In file included from include2/asm/hardirq.h:11,
                 from /build/kaos/2.6.18-irq-global/linux-2.6/include/linux/hardirq.h:7,
                 from /build/kaos/2.6.18-irq-global/linux-2.6/include/linux/interrupt.h:11,
                 from /build/kaos/2.6.18-irq-global/linux-2.6/include/asm-ia64/mca.h:16,
                 from /build/kaos/2.6.18-irq-global/linux-2.6/arch/ia64/kernel/asm-offsets.c:15:
/build/kaos/2.6.18-irq-global/linux-2.6/include/linux/irq.h:24:26: error: asm/irq_regs.h: No such file or directory

Are you expecting the include path to automatically fallback to
include/asm-generic if a file does not exist in include/asm-$(ARCH)?
That does not happen.

Workaround with "cp include/asm-generic/irq_regs.h include/asm-ia64/",
then there are several compile errors in IA64 specific code, patches to
follow.

I am concerned about code that has been missed in this patch.  For
example,

arch/ia64/kernel/perfmon.c:
  static int
  pfm_do_interrupt_handler(int irq, void *arg, struct pt_regs *regs)

BTW, this patch is going to cause major headaches for KDB, it uses
pt_regs all over the place.  Having said that, I think the patch is
worthwhile.  Tracking down the pt_regs in the register stack in an IA64
dump can be a major headache, using a global structure will make life
easier.

