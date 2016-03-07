From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Mon, 07 Mar 2016 10:03:48 -0700
Message-ID: <1457370228.15454.311.camel@hpe.com>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
	 <20160304094424.GA16228@gmail.com> <1457115514.15454.216.camel@hpe.com>
	 <20160305114012.GA7259@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160305114012.GA7259@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Sat, 2016-03-05 at 12:40 +0100, Ingo Molnar wrote:
> * Toshi Kani <toshi.kani@hpe.com> wrote:
>=20
> > > So I'd say that since ioremap() in itself is fragile enough, we
> > > should work towards eliminating overlapping ranges.
> > >=20
> > > The thing is, the whole vmap_area logic is based around non-
> > > overlapping ranges, sorted into the vmap_area_root rbtree.
> > >=20
> > > Just check the logic in mm/vmalloc.c::alloc_vmap_area(): it's bas=
ed
> > > on finding holes in the kernel-virtual allocations. 'Overlapping
> > > ranges' is very much not part of that logic, at least to my
> > > understanding.
> > >=20
> > > How are overlapping ioremap()s even possible with that logic? The
> > > allocator searches for holes, not allowing for overlaps. What am =
I
> > > missing?
> > >=20
> > > Could you outline a specific case where it's done intentionally -=
 and
> > > the purpose behind that intention?
> >=20
> > The term "overlapping" is a bit misleading. [...]
>=20
> A bit? It was totally misleading ...
>=20
> You meant virtual aliases for the same physical address, and those of
> course are allowed, as long the cache attributes are compatible, that=
 is
> what the whole memtype infrastructure is about, as you yourself note:
>=20
> > [...] =C2=A0This is "alias" mapping -- a physical address range is =
mapped to
> > multiple virtual address ranges. =C2=A0There is no overlapping in V=
MA.
> >=20
> > Such alias mappings are used by multiple modules. =C2=A0For instanc=
e, a PMEM
> > range is mapped to the kernel and user spaces. =C2=A0/dev/mem is an=
other
> > example that creates a user space mapping to a physical address whe=
re
> > other mappings may already exist.
> >=20
> > Hence, alias mapping itself is a supported use-case. =C2=A0However,=
 alias
> > mapping with different cache types is not as it causes undefined
> > behavior. =C2=A0Therefore, PAT module protects from this case by tr=
acking
> > cache types used for mapping physical ranges. =C2=A0When a differen=
t cache
> > type is requested, is_new_memtype_allowed() checks if the request n=
eeds
> > to be failed or can be changed to the existing type.
>=20
> So where is the problem? The memtype implementation and hence most
> ioremap() users are supposed to be safe. set_memory_*() APIs are supp=
osed
> to be safe as well, as they too go via the memtype API.

Let me try to summarize...

The original issue Luis brought up was that drivers written to work wit=
h
MTRR may create a single ioremap range covering multiple cache attribut=
es
since MTRR can overwrite cache attribute of a certain range. =C2=A0Conv=
erting
such drivers with PAT-based ioremap interfaces, i.e. ioremap_wc() and
ioremap_nocache(), requires a separate ioremap map for each cache
attribute, which can be challenging as it may result in overlapping ior=
emap
ranges (in his term) with different cache attributes.

So, Luis asked about 'sematics of overlapping ioremap()' calls. =C2=A0H=
ence, I
responded that aliasing mapping itself is supported, but alias with
different cache attribute is not. =C2=A0We have checks in place to dete=
ct such
condition. =C2=A0Overlapping ioremap calls with a different cache attri=
bute
either fails or gets redirected to the existing cache attribute on x86.

> > I agree that the current implementation is fragile, and some interf=
aces
> > skip such check at all, ex.=C2=A0vm_insert_pfn().
>=20
> Most of those are really just low level interfaces forl cases that sk=
ip the memtype infrastructure.

Yes, and I'm just stating the fact that some pfn map use-cases, such as
mmap, are not tracked in memtype. =C2=A0For example, drm_gem_mmap()
->=C2=A0drm_gem_mmap_obj() sets its VMA as WC attribute. =C2=A0i915_gem=
_fault() then
creates a WC map with=C2=A0vm_insert_pfn() at fault.

Thanks,
-Toshi
