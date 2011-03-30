From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] unicore32 fix: remove arch-specific futex support
Date: Wed, 30 Mar 2011 14:27:13 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1103301421390.22418@localhost6.localdomain6>
References: <01eb01cbeeb7$30390460$90ab0d20$@mprc.pku.edu.cn> <201103301417.20027.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48391 "EHLO linutronix.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755813Ab1C3M1W (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Mar 2011 08:27:22 -0400
In-Reply-To: <201103301417.20027.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, 30 Mar 2011, Arnd Bergmann wrote:

> On Wednesday 30 March 2011, Guan Xuetao wrote:
> > The futex functions in unicore32 are not used and verified,
> > so just replaced by asm-generic version.
> > 
> > Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
> 
> Note that the a working futex implementation would be really useful
> to get efficient multithreaded applications. On uniprocessor
> machines, this can easily be done by disabling interrupts, like
> you also do for spinlock and atomic.
> 
> I believe we could actually copy the arch/sh/include/asm/futex-irq.h
> implementation to include/asm-generic and use that whenever CONFIG_SMP
> is disabled. That would also help a lot of other architectures.

The problem is that you need cmpxchg in user space as well.

ARM does this with some syscall magic for machines which do not have
cmpxchg.

	tglx
