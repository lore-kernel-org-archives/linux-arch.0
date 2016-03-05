From: Ingo Molnar <mingo@kernel.org>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Sat, 5 Mar 2016 12:40:12 +0100
Message-ID: <20160305114012.GA7259@gmail.com>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
 <20160304094424.GA16228@gmail.com>
 <1457115514.15454.216.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38779 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832AbcCELkR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 5 Mar 2016 06:40:17 -0500
Content-Disposition: inline
In-Reply-To: <1457115514.15454.216.camel@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>


* Toshi Kani <toshi.kani@hpe.com> wrote:

> > So I'd say that since ioremap() in itself is fragile enough, we sho=
uld work=20
> > towards eliminating overlapping ranges.
> >=20
> > The thing is, the whole vmap_area logic is based around non-overlap=
ping=20
> > ranges, sorted into the vmap_area_root rbtree.
> >=20
> > Just check the logic in mm/vmalloc.c::alloc_vmap_area(): it's based=
 on finding=20
> > holes in the kernel-virtual allocations. 'Overlapping ranges' is ve=
ry much not=20
> > part of that logic, at least to my understanding.
> >=20
> > How are overlapping ioremap()s even possible with that logic? The a=
llocator=20
> > searches for holes, not allowing for overlaps. What am I missing?
> >=20
> > Could you outline a specific case where it's done intentionally - a=
nd the=20
> > purpose behind that intention?
>=20
> The term "overlapping" is a bit misleading. [...]

A bit? It was totally misleading ...

You meant virtual aliases for the same physical address, and those of c=
ourse are=20
allowed, as long the cache attributes are compatible, that is what the =
whole=20
memtype infrastructure is about, as you yourself note:

> [...] =A0This is "alias" mapping -- a physical address range is mappe=
d to multiple=20
> virtual address ranges. =A0There is no overlapping in VMA.
>=20
> Such alias mappings are used by multiple modules. =A0For instance, a =
PMEM range is=20
> mapped to the kernel and user spaces. =A0/dev/mem is another example =
that creates=20
> a user space mapping to a physical address where other mappings may a=
lready=20
> exist.
>=20
> Hence, alias mapping itself is a supported use-case. =A0However, alia=
s mapping=20
> with different cache types is not as it causes undefined behavior. =A0=
Therefore,=20
> PAT module protects from this case by tracking cache types used for m=
apping=20
> physical ranges. =A0When a different cache type is requested,=20
> is_new_memtype_allowed() checks if the request needs to be failed or =
can be=20
> changed to the existing type.

So where is the problem? The memtype implementation and hence most iore=
map() users=20
are supposed to be safe. set_memory_*() APIs are supposed to be safe as=
 well, as=20
they too go via the memtype API.

> I agree that the current implementation is fragile, and some interfac=
es skip=20
> such check at all, ex.=A0vm_insert_pfn().

Most of those are really just low level interfaces for special cases th=
at skip the=20
memtype infrastructure.

Thanks,

	Ingo
