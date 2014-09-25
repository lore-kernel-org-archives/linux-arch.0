From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/17] Cross-architecture definitions of relaxed MMIO accessors
Date: Thu, 25 Sep 2014 21:17:19 +0200
Message-ID: <201409252117.19754.arnd@arndb.de>
References: <1411579056-16966-1-git-send-email-will.deacon@arm.com> <4240583.SJ4jiIW6Zy@wuerfel> <54243395.902@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:56066 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbaIYTTv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Sep 2014 15:19:51 -0400
In-Reply-To: <54243395.902@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "chris@zankel.net" <chris@zankel.net>, "cmetcalf@tilera.com" <cmetcalf@tilera.com>, "davem@davemloft.net" <davem@davemloft.net>, "deller@gmx.de" <deller@gmx.de>, "dhowells@redhat.com" <dhowells@redhat.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "hpa@zytor.com" <hpa@zytor.com>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>, "mingo@redhat.com" <mingo@redhat.com>, "monstr@monstr.eu" <monstr@monstr.eu>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "sam@ravnborg.org" <sam@ravnborg.org>

On Thursday 25 September 2014, Daniel Thompson wrote:
> > +
> > +#ifndef readq_relaxed
> > +#define readq_relaxed readq
> > +#endif
> 
> Not really sure if it matters but this gives a rather surprising
> behaviour to #ifdef readq_relaxed given that readq may not be defined.
> 

It was intentional. I could have written this as

#if !defined(readq_relaxed) && defined(readq)

but the effect would be almost the same, and the version I picked looks
simpler. Note that 32-bit architectures could provide readq, it's just
the generic code that doesn't, because most you typically don't get
atomic 64-bit accesses from dereferencing a 64-bit pointer as the
generic readq() function does.

	Arnd
