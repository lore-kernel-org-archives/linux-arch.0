From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/17] Cross-architecture definitions of relaxed MMIO accessors
Date: Thu, 25 Sep 2014 12:42:15 +0200
Message-ID: <4515310.nYRWfN5AyO@wuerfel>
References: <1411579056-16966-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:57274 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbaIYKnI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Sep 2014 06:43:08 -0400
In-Reply-To: <1411579056-16966-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, chris@zankel.net, cmetcalf@tilera.com, davem@davemloft.net, deller@gmx.de, dhowells@redhat.com, geert@linux-m68k.org, heiko.carstens@de.ibm.com, hpa@zytor.com, jcmvbkbc@gmail.com, jesper.nilsson@axis.com, mingo@redhat.com, monstr@monstr.eu, paulmck@linux.vnet.ibm.com, rdunlap@infradead.org, sam@ravnborg.org, schwidefsky@de.ibm.com, starvik@axis.com, takata@linux-m32r.org, tglx@linutronix.de, tony.luck@intel.com, daniel.thompson@linaro.org, broonie@linaro.org, linux@arm.linux.org.uk

On Wednesday 24 September 2014 18:17:19 Will Deacon wrote:
> 
> This is version three of the series I've originally posted here:
> 
>   v1: https://lkml.org/lkml/2014/4/17/269
>   v2: https://lkml.org/lkml/2014/5/22/468
> 
> This is basically just a rebase on top of 3.17-rc6, minus the alpha patch
> (which was merged into mainline).
> 
> I looked at reworking the non-relaxed accessors to imply mmiowb, but it
> quickly got messy as some architectures (e.g. mips) deliberately keep
> mmiowb and readX/writeX separate whilst others (e.g. powerpc) don't trust
> drivers to get mmiowb correct, so add barriers to both. Given that
> arm/arm64/x86 don't care about mmiowb, I've left that as an exercise for
> an architecture that does care.
> 
> In order to get this lot merged, we probably want to merge the asm-generic
> patch (1/17) first, so Acks would be much appreciated on the architecture
> bits.
> 
> As before, I've included the original cover letter below, as that describes
> what I'm trying to do in more detail.
> 

I'm definitely happy to merge that first patch in the asm-generic tree, or
have it go through some other tree along with architecture specific patches.
Anything that helps get these functions across all architectures really.

I don't think there is any controversy about whether or not we should
have the functions, or what the default should be on architectures that
don't provide their own, so I wonder why we can't just add the conditional
definitions to linux/io.h and remove the trivial definitions from
architectures afterwards.

	Arnd
