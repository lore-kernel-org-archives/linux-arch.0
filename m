Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:49528 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbaIZJ32 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Sep 2014 05:29:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/17] Cross-architecture definitions of relaxed MMIO accessors
Date: Fri, 26 Sep 2014 11:28:38 +0200
Message-ID: <2497501.Mvb1tbCjLR@wuerfel>
In-Reply-To: <20140926084019.GJ5182@n2100.arm.linux.org.uk>
References: <1411579056-16966-1-git-send-email-will.deacon@arm.com> <201409252117.19754.arnd@arndb.de> <20140926084019.GJ5182@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Will Deacon <will.deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "chris@zankel.net" <chris@zankel.net>, "cmetcalf@tilera.com" <cmetcalf@tilera.com>, "davem@davemloft.net" <davem@davemloft.net>, "deller@gmx.de" <deller@gmx.de>, "dhowells@redhat.com" <dhowells@redhat.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "hpa@zytor.com" <hpa@zytor.com>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>, "mingo@redhat.com" <mingo@redhat.com>, "monstr@monstr.eu" <monstr@monstr.eu>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "sam@ravnborg.org" <sam@ravnborg.org>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "starvik@axis.com" <starvik@axis.com>, "takata@linux-m32r.org" <takata@linux-m32r.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "tony.luck@intel.com" <tony.luck@intel.com>, "broonie@linaro.org" <broonie@linaro.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Message-ID: <20140926092838.bwvr5zx2fMq98UxbY1UzwW4QUs-knlmUjkDCJ2OCqqY@z>

On Friday 26 September 2014 09:40:19 Russell King - ARM Linux wrote:
> 
> How would a 32-bit architecture know whether it should read the least
> significant 32-bit or the most significant 32-bit part of the 64-bit
> register first.  What would be right for one driver may not ben correct
> for another.  Hence, this decision should only be made by the driver
> wanting the accessor, and not having the accessor symbol defined should
> be the trigger for the driver to handle the problem themselves.

Some 32-bit architectures can trigger 64-bit bus cycles using well
defined accesses using register pairs. Meta seems to fit into this
category:

static inline u64 __raw_readq(const volatile void __iomem *addr)
{
       u64 ret;
       asm volatile("GETL %0,%t0,[%1]"
                    : "=da" (ret)
                    : "da" (addr)
                    : "memory");
       return ret;
}

Most other architectures I think cannot do this however, and would
turn the access into two separate bus cycles, which in addition to
the problem you mentioned could also result in side-effects from
doing an access at the wrong offset, so we definitely can't rely
on having these functions.

	Arnd
