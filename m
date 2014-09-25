Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:50579 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbaIYKoN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Sep 2014 06:44:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 01/17] asm-generic: io: implement relaxed accessor macros as conditional wrappers
Date: Thu, 25 Sep 2014 12:43:41 +0200
Message-ID: <14780144.KRcmhp8YbE@wuerfel>
In-Reply-To: <20140925103846.GI20043@arm.com>
References: <1411579056-16966-1-git-send-email-will.deacon@arm.com> <4501051.vdxhyhkTWv@wuerfel> <20140925103846.GI20043@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "chris@zankel.net" <chris@zankel.net>, "cmetcalf@tilera.com" <cmetcalf@tilera.com>, "davem@davemloft.net" <davem@davemloft.net>, "deller@gmx.de" <deller@gmx.de>, "dhowells@redhat.com" <dhowells@redhat.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "hpa@zytor.com" <hpa@zytor.com>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>, "mingo@redhat.com" <mingo@redhat.com>, "monstr@monstr.eu" <monstr@monstr.eu>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "sam@ravnborg.org" <sam@ravnborg.org>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "starvik@axis.com" <starvik@axis.com>, "takata@linux-m32r.org" <takata@linux-m32r.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "tony.luck@intel.com" <tony.luck@intel.com>, "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>, "broonie@linaro.org" <broonie@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>
Message-ID: <20140925104341.rr97UL9vSghrGtsSiFpM9JqQqLCxwynkPkdNmwT-JWw@z>

On Thursday 25 September 2014 11:38:46 Will Deacon wrote:
> On Thu, Sep 25, 2014 at 11:32:00AM +0100, Arnd Bergmann wrote:
> > On Wednesday 24 September 2014 18:17:20 Will Deacon wrote:
> > > {read,write}{b,w,l,q}_relaxed are implemented by some architectures in
> > > order to permit memory-mapped I/O accesses with weaker barrier semantics
> > > than the non-relaxed variants.
> > > 
> > > This patch adds wrappers to asm-generic so that drivers can rely on the
> > > relaxed accessors being available, even if they don't always provide
> > > weaker ordering guarantees. Since some architectures both include
> > > asm-generic/io.h and define some relaxed accessors, the definitions here
> > > are conditional for the time being.
> > > 
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  include/asm-generic/io.h | 26 ++++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > > 
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks, Arnd. Do you have other patches queued for asm-generic, or shall I
> take this patch (on its own) via the arm64 tree?

I don't have other patches queued up yet, but Thierry has another patch
for asm-generic/io.h that I want to merge, so this time I'd prefer to
take it through my tree in case there are conflicts.

	Arnd
