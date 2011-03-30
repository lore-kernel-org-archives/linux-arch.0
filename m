From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] unicore32 fix: remove arch-specific futex support
Date: Wed, 30 Mar 2011 14:50:29 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1103301446110.22418@localhost6.localdomain6>
References: <01eb01cbeeb7$30390460$90ab0d20$@mprc.pku.edu.cn> <201103301417.20027.arnd@arndb.de> <alpine.LFD.2.00.1103301421390.22418@localhost6.localdomain6> <201103301440.03479.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38463 "EHLO linutronix.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854Ab1C3Mue (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Mar 2011 08:50:34 -0400
In-Reply-To: <201103301440.03479.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, 30 Mar 2011, Arnd Bergmann wrote:

> On Wednesday 30 March 2011, Thomas Gleixner wrote:
> > The problem is that you need cmpxchg in user space as well.
> > 
> > ARM does this with some syscall magic for machines which do not have
> > cmpxchg.
> 
> Ah, right. I wonder how sh does it.
> 
> I also remember that the original unicore32 ABI had support for a cmpxchg
> system call, but that was removed with the move to the generic syscall
> table.
> 
> It is of course possible to add it back using the __NR_arch_specific_syscall
> entry point.

Either that or you take a trap. None of them is pretty. 

If the only purpose is futex support, then we can add an extra flag to
the futex ops and handle it there via asm-generic/futex.h. That would
avoid an extra syscall in the contended case.

Thanks,

	tglx
