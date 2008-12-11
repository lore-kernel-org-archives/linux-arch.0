From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 00/19] unify init_task
Date: Thu, 11 Dec 2008 17:10:54 +0100
Message-ID: <200812111710.55215.arnd@arndb.de>
References: <cover.1228966585.git.kyle@mcmartin.ca> <cover.1228966585.git.kyle@mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62930 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756233AbYLKQLA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2008 11:11:00 -0500
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-arch@vger.kernel.org

On Thursday 11 December 2008, Kyle McMartin wrote:
> Create a common kernel/init_task.c, and convert low hanging fruit to
> use it. Architecture maintainers will need to ensure that I didn't
> break anything before applying the init_task removal patch to their
> arch.
> 
> A few architectures appear to possibly rely on link-ordering (with
> an extra-y makefile rule) and may need additional linker script rules.

FWIW, here is the alignment of init_thread_info on all architectures:

alpha: 2 * PAGE_SIZE
arm, avr32, frv, mn10300, s390, sh, x86: THREAD_SIZE
blackfin: THREAD_SIZE, but uses a different section
cris, m68k-sun3: PAGE_SIZE
h8300, m32r, m68knommu, ppc32, xtensa, m68k-std: 0x2000/8192
ia64: PAGE_SIZE (but ia64 is different)
mips: _PAGE_SIZE
parisc, ppc64: 16384
ppc32: 8192
um: KERNEL_STACK_SIZE
sparc: PAGE_SIZE with .text section
sparc64: 16384 (implicit)

This is the same as THREAD_SIZE on all architectures, except for
mips in certain configurations, which should be fixed.

Maybe we can get all of them to just use THREAD_SIZE in there?

	Arnd <><
