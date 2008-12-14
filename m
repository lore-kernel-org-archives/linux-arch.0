From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC] remove linux/hardirq.h from asm-generic/local.h
Date: Sun, 14 Dec 2008 09:58:03 -0800
Message-ID: <20081214095803.9d16e85f.akpm@linux-foundation.org>
References: <20081214133941.GA18035@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57375 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750950AbYLNR6v (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 14 Dec 2008 12:58:51 -0500
In-Reply-To: <20081214133941.GA18035@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Sun, 14 Dec 2008 13:39:41 +0000 Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> While looking at reducing the amount of architecture namespace pollution
> in the generic kernel, I found that asm/irq.h is included in the vast
> majority of compilations on ARM (around 650 files.)
> 
> Since asm/irq.h includes a sub-architecture include file on ARM, this
> causes a negative impact on the ccache's ability to re-use the build
> results from other sub-architectures, so we have a desire to reduce
> the dependencies on asm/irq.h.
> 
> It turns out that a major cause of this is the needless include of
> linux/hardirq.h into asm-generic/local.h.  The patch below removes this
> include, resulting in some 250 to 300 files (around half) of the kernel
> then omitting asm/irq.h.
> 
> My test builds still succeed, provided two ARM files are fixed
> (arch/arm/kernel/traps.c and arch/arm/mm/fault.c) - so there may be
> negative impacts for this on other architectures.
> 
> Note that x86 does not include asm/irq.h nor linux/hardirq.h in its
> asm/local.h, so this patch can be viewed as bringing the generic version
> into line with the x86 version.

Sure.  Includes are easy to add and hard to remove.  I'll queue it up
and see if there's fallout.

btw,

> From: Russell King <rmk+lkml@arm.linux.org.uk>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

that will result in the two rmk's getting separate akpm spam, different
Author from Signer-offer, etc.  Adding an explicit From: line would
improve things.
