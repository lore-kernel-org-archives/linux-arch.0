From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: __ARCH_WANT_SYSCALL_DEPRECATED
Date: Mon, 29 Aug 2011 12:43:24 +0200
Message-ID: <20110829104324.GM24840@distanz.ch>
References: <20110822193602.GA23301@codeaurora.org> <2047151.mWElcT8jZQ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from symlink.to.noone.org ([85.10.207.172]:37084 "EHLO sym.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037Ab1H2Ldl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Aug 2011 07:33:41 -0400
Content-Disposition: inline
In-Reply-To: <2047151.mWElcT8jZQ@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>, GLIBC Devel <libc-alpha@sourceware.org>, Chris Metcalf <cmetcalf@tilera.com>, Jonas Bonn <jonas.bonn@gmail.com>, libc-ports@sourceware.org, linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org, Mark Salter <msalter@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

On 2011-08-22 at 22:43:18 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 22 August 2011 14:36:02 Linas Vepstas wrote:
> > 
> > So: What's the latest on asm-generic support on glibc? 
> > I just pulled glibc-2.14 and note that Chris Metcalf's
> > generic implementation hasn't been folded in yet. 
> > It seems to work well for me, so can we expect it
> > anytime soon?
> > 
> > Another problem:  If I don't define __ARCH_WANT_SYSCALL_DEPRECATED
> > in the kernel asm/unistd.h  then glibc won't build: currently,
> > I get 
> > ../sysdeps/unix/sysv/linux/getdents.c:105: error: ???__NR_getdents??? undeclared (first use in this function)
> > 
> > A very quick grep tells me that asm-generic defines a getdents64
> > but that is not what glibc is looking for.  Is there any chance
> > that there are glibc patches floating around somewhere that heal
> > this and any remaining __ARCH_WANT_SYSCALL_DEPRECATED issues?
> 
> I don't know the answer to your question, but I've added Mark Salter,
> Guan Xuetao and Tobias Klauser to the list, since they probably have
> the same issue on c64x, unicore32 and nios2. c64x is currently nommu,
> but there is a similar problem with uclibc and I expect that architecture
> to grow an mmu at some point.

On nios2 we're using an outdated eglibc version (based on glibc 2.5)
right now and thus we still rely on our own non-asm-generic version of
asm/unistd.h

I'm currently in the process of converting our arch to solely use
asm-generic header wherever possible one of which is the syscall ABI.
This will also mean we'll have to redo the libc parts.

Tobias
