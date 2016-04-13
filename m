From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Wed, 13 Apr 2016 23:03:10 +0200
Message-ID: <20160413210310.GE1990@wotan.suse.de>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
 <20160304094424.GA16228@gmail.com>
 <1457115514.15454.216.camel@hpe.com>
 <20160305114012.GA7259@gmail.com>
 <1457370228.15454.311.camel@hpe.com>
 <20160308121601.GA6573@gmail.com>
 <1457483385.15454.519.camel@hpe.com>
 <20160309091525.GA11866@gmail.com>
 <alpine.LFD.2.20.1603211721070.25290@eddie.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45546 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbcDMVDP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 13 Apr 2016 17:03:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1603211721070.25290@eddie.linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Ingo Molnar <mingo@kernel.org>, Toshi Kani <toshi.kani@hpe.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>

On Mon, Mar 21, 2016 at 05:38:40PM +0000, Maciej W. Rozycki wrote:
> On Wed, 9 Mar 2016, Ingo Molnar wrote:
>=20
> > > > So to go back to the original suggestion from Luis, I've quoted=
 it, but
> > > > with a s/overlapping/aliased substitution:
> > > >=20
> > > > > I had suggested long ago then that one possible resolution wa=
s for us
> > > > > to add an API that *enables* aliased ioremap() calls, and onl=
y use it
> > > > > on select locations in the kernel. This means we only have to=
 convert a
> > > > > few users to that call to white list such semantics, and by d=
efault
> > > > > we'd disable aliased calls. To kick things off -- is this str=
ategy
> > > > > agreeable for all other architectures?
> > > >=20
> > > > I'd say that since the overwhelming majority of ioremap() calls=
 are not
> > > > aliased, ever, thus making it 'harder' to accidentally alias is=
 probably
> > > > a good idea.
> > >=20
> > > Did you mean 'aliased' or 'aliased with different cache attribute=
'? =A0The former=20
> > > check might be too strict.
> >=20
> > I'd say even 'same attribute' aliasing is probably relatively rare.
>=20
>  Please note that aliased cached mappings (any kinds of, not necessar=
ily=20
> from `ioremap') cause a lot of headache (read: handling trouble) with=
=20
> architectures such as MIPS which support virtually indexed caches whi=
ch=20
> suffer from cache aliasing.  There is a risk of data corruption if th=
e=20
> same physical memory address space location is accessed through diffe=
rent=20
> virtual mappings as not all hardware catches duplicate cache entries=20
> created in such a case.
>=20
>  We handle it in software for user mappings (although I keep having a=
=20
> feeling something always keeps escaping, due to the vast diversity of=
=20
> cache configurations possible), however I don't think we do for `iore=
map',=20
> so disallowing aliased `ioremap' mappings by default sounds like a go=
od=20
> idea to me.

Great, well lets do the work then.

  Luis
