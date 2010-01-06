From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 3/3] generic sys_ipc wrapper
Date: Wed, 6 Jan 2010 18:22:00 +0000
Message-ID: <20100106182200.GB30528@ZenIV.linux.org.uk>
References: <20100106172152.GC17163@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:48451 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526Ab0AFSWK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jan 2010 13:22:10 -0500
Content-Disposition: inline
In-Reply-To: <20100106172152.GC17163@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, ysato@users.sourceforge.jp, takata@linux-m32r.org, geert@linux-m68k.org, zippel@linux-m68k.org, gerg@uclinux.org, ralf@linux-mips.org, benh@kernel.crashing.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com

On Wed, Jan 06, 2010 at 06:21:52PM +0100, Christoph Hellwig wrote:

> Except for that h8300, m68k and m68knommu lack an impplementation of the
> semtimedop sub call which this patch adds, and various architectures have
> different strategies for the SHMAT version 1 case which apparently never
> gets used - at least on i386 it seems superflous as the compat code on
> x86-64 and ia64 doesn't even bother to implement it.

Kill the SHMAT crap; it's _not_ a part of user-visible API (note that it
checks that we'd come there with KERNEL_DS).

It had been a one-time kludge for ibcs2 module.  Blindly copied to
architectures than never had that shite at all, not that it had survived
even on i386 past 2.2.x (2.4 analog doesn't use that thing).

Just make it fail with -EINVAL in that case.
