From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v3 3/3] generic sys_ipc wrapper
Date: Thu, 14 Jan 2010 15:25:34 +0000
Message-ID: <12728.1263482734@redhat.com>
References: <20100108100347.GA30353@lst.de> <20100106172152.GC17163@lst.de> <20100108095023.GA29560@lst.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50510 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830Ab0ANP2D (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Jan 2010 10:28:03 -0500
In-Reply-To: <20100108100347.GA30353@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, starvik@axis.com, jesper.nilsson@axis.com, ysato@users.sourceforge.jp, takata@linux-m32r.org, geert@linux-m68k.org, zippel@linux-m68k.org, gerg@uclinux.org, ralf@linux-mips.org, benh@kernel.crashing.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, viro@zeniv.linux.org.uk

Christoph Hellwig <hch@lst.de> wrote:

> From: Christoph Hellwig <hch@lst.de>
> Subject: generic sys_ipc wrapper
> 
> Add a generic implementation of the ipc demultiplexer syscall.  Except for
> s390 and sparc64 all implementations of the sys_ipc are nearly identical.
> 
> There are slight differences in the types of the parameters, where mips
> and powerpc as the only 64-bit architectures with sys_ipc use unsigned long
> for the "third" argument as it gets casted to a pointer later, while it
> traditionally is an "int" like most other paramters.  frv goes even further
> and uses unsigned long for all parameters execept for "ptr" which is a pointer
> type everywhere.  The change from int to unsigned long for "third" and back
> to "int" for the others on frv should be fine due to the in-register calling
> conventions for syscalls (we already had a similar issue with the generic
> sys_ptrace), but I'd prefer to have the arch maintainers looks over this
> in details.
> 
> Except for that h8300, m68k and m68knommu lack an impplementation of the
> semtimedop sub call which this patch adds, and various architectures have
> different strategies for the SHMAT version 1 case which apparently never
> gets used - at least on i386 it seems superflous as the compat code on
> x86-64 and ia64 doesn't even bother to implement it.
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David Howells <dhowells@redhat.com> [for FRV & MN10300]
