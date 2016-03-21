From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Mon, 21 Mar 2016 17:38:40 +0000 (GMT)
Message-ID: <alpine.LFD.2.20.1603211721070.25290@eddie.linux-mips.org>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com> <20160304094424.GA16228@gmail.com> <1457115514.15454.216.camel@hpe.com> <20160305114012.GA7259@gmail.com> <1457370228.15454.311.camel@hpe.com> <20160308121601.GA6573@gmail.com>
 <1457483385.15454.519.camel@hpe.com> <20160309091525.GA11866@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:40480 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756906AbcCURim (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2016 13:38:42 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27008786AbcCURikZbhxU (ORCPT
        <rfc822;linux-arch@vger.kernel.org> + 1 other);
        Mon, 21 Mar 2016 18:38:40 +0100
In-Reply-To: <20160309091525.GA11866@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Toshi Kani <toshi.kani@hpe.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>

On Wed, 9 Mar 2016, Ingo Molnar wrote:

> > > So to go back to the original suggestion from Luis, I've quoted i=
t, but
> > > with a s/overlapping/aliased substitution:
> > >=20
> > > > I had suggested long ago then that one possible resolution was =
for us
> > > > to add an API that *enables* aliased ioremap() calls, and only =
use it
> > > > on select locations in the kernel. This means we only have to c=
onvert a
> > > > few users to that call to white list such semantics, and by def=
ault
> > > > we'd disable aliased calls. To kick things off -- is this strat=
egy
> > > > agreeable for all other architectures?
> > >=20
> > > I'd say that since the overwhelming majority of ioremap() calls a=
re not
> > > aliased, ever, thus making it 'harder' to accidentally alias is p=
robably
> > > a good idea.
> >=20
> > Did you mean 'aliased' or 'aliased with different cache attribute'?=
 =A0The former=20
> > check might be too strict.
>=20
> I'd say even 'same attribute' aliasing is probably relatively rare.

 Please note that aliased cached mappings (any kinds of, not necessaril=
y=20
from `ioremap') cause a lot of headache (read: handling trouble) with=20
architectures such as MIPS which support virtually indexed caches which=
=20
suffer from cache aliasing.  There is a risk of data corruption if the=20
same physical memory address space location is accessed through differe=
nt=20
virtual mappings as not all hardware catches duplicate cache entries=20
created in such a case.

 We handle it in software for user mappings (although I keep having a=20
feeling something always keeps escaping, due to the vast diversity of=20
cache configurations possible), however I don't think we do for `iorema=
p',=20
so disallowing aliased `ioremap' mappings by default sounds like a good=
=20
idea to me.

 FWIW,

  Maciej
