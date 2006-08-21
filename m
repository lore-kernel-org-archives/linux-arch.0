Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:9232 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030301AbWHUPRb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 21 Aug 2006 11:17:31 -0400
Date: Mon, 21 Aug 2006 16:17:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] introduce kernel_execve function to replace __KERNEL_SYSCALLS__
Message-ID: <20060821151720.GB11266@flint.arm.linux.org.uk>
References: <20060819073031.GA25711@atjola.homenet> <200608201913.39989.arnd@arndb.de> <17641.30.670343.779791@cargo.ozlabs.ibm.com> <200608211712.17780.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608211712.17780.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, Bj?rn Steinbrink <B.Steinbrink@gmx.de>, Andrew Morton <akpm@osdl.org>, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Aug 21, 2006 at 05:12:17PM +0200, Arnd Bergmann wrote:
> On Monday 21 August 2006 02:36, Paul Mackerras wrote:
> > > Iit turned out most of the architectures that already implement
> > > their own execve() call instead of using the _syscall3 function
> > > for it end up passing the return value of sys_execve down, 
> > > instead of setting errno.
> > 
> > I really don't like having an "errno" variable in the kernel. ?What if
> > two processes are doing an execve concurrently?
> 
> The point is that we have two different schemes in the kernel that
> conflict:
> 
> alpha, arm{,26}, ia64, parisc, powerpc and x86_64 pass the error
> code from execve, all others pass -1 and set the global errno.

Indeed, and rather than fixing execve() for one set of architectures
and by doing that breaking the other set, the point of this change is
to fix _all_ architectures in the most expedient way.

At a later date, those architectures who are using the global errno
can have that _separate_ bug fixed.

Let's fix one bug at a time.  Especially as this probably needs to go
in to -rc.

Arnd - thanks for taking this on.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
