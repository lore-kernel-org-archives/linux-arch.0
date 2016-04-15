From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Fri, 15 Apr 2016 08:47:29 -0600
Message-ID: <1460731649.24985.86.camel@hpe.com>
References: <20160304094424.GA16228@gmail.com>
	 <1457115514.15454.216.camel@hpe.com> <20160305114012.GA7259@gmail.com>
	 <1457370228.15454.311.camel@hpe.com> <20160308121601.GA6573@gmail.com>
	 <1457483385.15454.519.camel@hpe.com> <20160309091525.GA11866@gmail.com>
	 <1457734432.6393.199.camel@hpe.com> <20160316014548.GK1990@wotan.suse.de>
	 <1458254693.6393.506.camel@hpe.com> <20160413211638.GF1990@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160413211638.GF1990@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Ingo Molnar <mingo@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Wed, 2016-04-13 at 23:16 +0200, Luis R. Rodriguez wrote:
> On Thu, Mar 17, 2016 at 04:44:53PM -0600, Toshi Kani wrote:
> > On Wed, 2016-03-16 at 02:45 +0100, Luis R. Rodriguez wrote:
> > > On Fri, Mar 11, 2016 at 03:13:52PM -0700, Toshi Kani wrote:
:
> > >=20
> > > If aliasing with different cache attributes is not allowed for x8=
6
> > > and if its also rare for other architectures that just leaves the
> > > hunt for valid aliasing uses. That still may be hard to hunt for,=
 but
> > > I also suspect it may be rare.
> >
> > Yes, I'd fail the different cache attribute case if we are to place
> > more strict check.
>
> OK it seems this is a good starting point. How can we get a general
> architecture consensus aliasing with different cache attributes is a
> terrible idea ? Perhaps a patch to WARN/error out and let architectur=
es
> opt in to this piece of code?

I expect aliasing with different cache attributes is a bad idea on most
architectures. =C2=A0Given the fact that track_pfn_remap(), track_pfn_i=
nsert(),
etc. are only implemented on x86, I suspect that other architectures wo=
uld
not be able to implement such check easily, though. =C2=A0

On x86, ioremap() and remap_pfn_range() already fail on a conflicting c=
ache
type if it is not allowed by the rule defined in is_new_memtype_allowed=
().
=C2=A0This exception handling is necessary for remap_pfn_range() called=
 by
/dev/mem, but I do not think it's necessary for ioremap(). =C2=A0I thin=
k we can
start from adding a warning message to ioremap().


> > > > > Are there cases where we change the caching attribute of RAM =
for
> > > > > valid reasons, outside of legacy quirks?
> > > >
> > > > ati_create_page_map() is one example that it gets a RAM page
> > > > by=C2=A0__get_free_page(),=C2=A0and=C2=A0changes=C2=A0it=C2=A0t=
o=C2=A0UC=C2=A0by=C2=A0calling=C2=A0set_memory_uc
> > > > ().
> > >
> > > Should we instead have an API that lets it ask for RAM and of UC
> > > type? That would seem a bit cleaner. BTW do you happen to know *w=
hy*
> > > it needs UC RAM types?
> >
> > This RAM page is then shared between graphic card and CPU. =C2=A0I =
think
> > this is because graphic card cannot snoop the cache.
>
> Was this reason alone sufficient to open such APIs broadly for RAM?

According to commit 75cbade8ea3, such APIs were introduced because driv=
ers
previously had to deal with low-level staff. =C2=A0So, I think we need =
to keep
them as long as we have such drivers...

Thanks,
-Toshi
