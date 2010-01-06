From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] generic sys_ipc wrapper
Date: Wed, 6 Jan 2010 21:48:44 +0100
Message-ID: <201001062148.44515.arnd@arndb.de>
References: <20100106172152.GC17163@lst.de> <201001062052.11641.arnd@arndb.de> <20100106195905.GE1728@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58277 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756073Ab0AFUv5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jan 2010 15:51:57 -0500
In-Reply-To: <20100106195905.GE1728@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, ysato@users.sourceforge.jp, takata@linux-m32r.org, geert@linux-m68k.org, zippel@linux-m68k.org, gerg@uclinux.org, ralf@linux-mips.org, benh@kernel.crashing.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, viro@zeniv.linux.org.uk

On Wednesday 06 January 2010 20:59:05 Russell King - ARM Linux wrote:
> > This would not build on any of the architecture mentioned, because of
> > incorrect placement of curly braces, but as Al mentioned it should just
> > go away entirely.
> 
> They look fine to me.

Ah, right. I just got confused.

	Arnd 
