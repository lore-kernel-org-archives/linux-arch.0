From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: sys_recvmmsg: wire up or not?
Date: Thu, 14 Jan 2010 17:59:39 +1100
Message-ID: <1263452379.724.348.camel@pasglop>
References: <10f740e80912260239n17bbbd08w6c3065c12bde9c95@mail.gmail.com>
	 <200912261212.14264.arnd@arndb.de> <1263442833.724.325.camel@pasglop>
	 <20100113.202807.233259060.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51461 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329Ab0ANHAO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Jan 2010 02:00:14 -0500
In-Reply-To: <20100113.202807.233259060.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: arnd@arndb.de, geert@linux-m68k.org, acme@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org

On Wed, 2010-01-13 at 20:28 -0800, David Miller wrote:
> > Anything happening here ? We're getting that warning on ppc too
> despite
> > the fact that we use socketcall like x86... Should checksyscall be
> made
> > smarter or the syscall just removed from x86 ? :-)
> 
> I think it's better to trap directly to the system call rather
> than going through yet another demultiplexer.
> 
> I severely regretted using sys_socketcall initially on sparc32
> because it added a few microseconds to socket syscall latency
> (cpus back then were slow :-) 

Oh I definitely agree that a direct syscall is better, and I wonder in
fact if I should add new syscalls in addition to socketcall for powerpc,
for glibc to do a slow migration :-) I was just wondering about the
inconsistency for archs like us who have socketcall today, to also have
to define the syscall ...

IE. I'd rather have them all duplicated into real syscalls than some of
them only in socketcall and some on both since that will make any kind
of userspace transition even more hellish.

Cheers,
Ben.
