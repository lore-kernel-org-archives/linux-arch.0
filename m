From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 3/6] generic sys_ipc wrapper
Date: Mon, 8 Feb 2010 10:22:31 -0500
Message-ID: <20100208152231.GY24051@bombadil.infradead.org>
References: <20100201185544.GC11045@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:34970 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239Ab0BHPWp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Feb 2010 10:22:45 -0500
Content-Disposition: inline
In-Reply-To: <20100201185544.GC11045@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, ysato@users.sourceforge.jp, takata@linux-m32r.org, geert@linux-m68k.org, zippel@linux-m68k.org, gerg@uclinux.org, ralf@linux-mips.org, benh@kernel.crashing.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, viro@zeniv.linux.org.uk

On Mon, Feb 01, 2010 at 07:55:44PM +0100, Christoph Hellwig wrote:
> Add a generic implementation of the ipc demultiplexer syscall.  Except for
> s390 and sparc64 all implementations of the sys_ipc are nearly identical.
><...>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks Christoph! I had started cleaning this up a few years ago when I
was debugging some IPC issues on parisc with the individual calls. Never
saw it through though.

emphatically Acked-by: Kyle McMartin <kyle@mcmartin.ca>
