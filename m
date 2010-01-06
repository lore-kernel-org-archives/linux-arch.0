From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 3/3] generic sys_ipc wrapper
Date: Wed, 06 Jan 2010 19:16:12 +0000
Message-ID: <7501.1262805372@redhat.com>
References: <20100106172152.GC17163@lst.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27920 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193Ab0AFTSf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 6 Jan 2010 14:18:35 -0500
In-Reply-To: <20100106172152.GC17163@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, starvik@axis.com, jesper.nilsson@axis.com, ysato@users.sourceforge.jp, takata@linux-m32r.org, geert@linux-m68k.org, zippel@linux-m68k.org, gerg@uclinux.org, ralf@linux-mips.org, benh@kernel.crashing.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, viro@zeniv.linux.org.uk

Christoph Hellwig <hch@lst.de> wrote:

> various architectures have different strategies for the SHMAT version 1 case
> which apparently never gets used - at least on i386 it seems superflous as
> the compat code on x86-64 and ia64 doesn't even bother to implement it.

The SHMAT version 1 case can be dropped for FRV and MN10300 - neither of them
support iBCS.

> frv goes even further and uses unsigned long for all parameters execept for
> "ptr" which is a pointer type everywhere.  The change from int to unsigned
> long for "third" and back to "int" for the others on frv should be fine due
> to the in-register calling conventions for syscalls (we already had a
> similar issue with the generic sys_ptrace), but I'd prefer to have the arch
> maintainers looks over this in details.

That should be okay - the registers are all 32-bits, so int, long and pointers
are all the same size.

David
