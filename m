Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:20120 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932333AbWJDEGb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Oct 2006 00:06:31 -0400
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by zeus1.kernel.org (8.13.7/8.13.1) with ESMTP id k943QsTx000530
	for <linux-arch@vger.kernel.org>; Wed, 4 Oct 2006 03:27:06 GMT
From: Keith Owens <kaos@sgi.com>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers 
In-reply-to: Your message of "Tue, 03 Oct 2006 10:54:04 +0100."
             <10074.1159869244@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Oct 2006 13:26:23 +1000
Message-ID: <20655.1159932383@kao2.melbourne.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells (on Tue, 03 Oct 2006 10:54:04 +0100) wrote:
>Keith Owens <kaos@sgi.com> wrote:
>
>> >	http://people.redhat.com/~dhowells/irq-global-regs.diff.bz2
>
>I'd forgotten about that.  Try:
>
>	http://people.redhat.com/~dhowells/34-irq-global-regs.diff
>
>instead.  That's the uptodate one.

That is the one that I am using, and it blows up immediately on IA64.
There is no automatic default to scan include/asm-generic after
asm-$(ARCH).

make
  GEN     /build/kaos/2.6.18-irq-global/obj/Makefile
scripts/kconfig/conf -s arch/ia64/Kconfig
  Using /build/kaos/2.6.18-irq-global/linux-2.6 as source for kernel
  GEN     /build/kaos/2.6.18-irq-global/obj/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CC      arch/ia64/kernel/asm-offsets.s
In file included from include2/asm/hardirq.h:11,
                 from /build/kaos/2.6.18-irq-global/linux-2.6/include/linux/hardirq.h:7,
                 from /build/kaos/2.6.18-irq-global/linux-2.6/include/linux/interrupt.h:11,
                 from /build/kaos/2.6.18-irq-global/linux-2.6/include/asm-ia64/mca.h:16,
                 from /build/kaos/2.6.18-irq-global/linux-2.6/arch/ia64/kernel/asm-offsets.c:15:
/build/kaos/2.6.18-irq-global/linux-2.6/include/linux/irq.h:24:26: error: asm/irq_regs.h: No such file or directory


