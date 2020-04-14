Return-Path: <SRS0=05z6=56=kvack.org=owner-linux-mm@kernel.org>
Date: Tue, 14 Apr 2020 07:20:14 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Message-ID: <20200414142014.GO21484@bombadil.infradead.org>
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-5-npiggin@gmail.com>
 <20200413134106.GN21484@bombadil.infradead.org>
 <36616218-1d3a-b18a-8fb8-4fc9eff22780@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <36616218-1d3a-b18a-8fb8-4fc9eff22780@c-s.fr>
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200414142014.JzdueGXMJuF5_HoUffzgd59gVOA_UyTVDMHBQF-mTyg@z>

On Tue, Apr 14, 2020 at 02:28:35PM +0200, Christophe Leroy wrote:
> Le 13/04/2020 =E0 15:41, Matthew Wilcox a =E9crit=A0:
> > On Mon, Apr 13, 2020 at 10:53:03PM +1000, Nicholas Piggin wrote:
> > > +static int vmap_pages_range_noflush(unsigned long start, unsigned =
long end,
> > > +				    pgprot_t prot, struct page **pages,
> > > +				    unsigned int page_shift)
> > > +{
> > > +	if (page_shift =3D=3D PAGE_SIZE) {
> >=20
> > ... I think you meant 'page_shift =3D=3D PAGE_SHIFT'
> >=20
> > Overall I like this series, although it's a bit biased towards CPUs
> > which have page sizes which match PMD/PUD sizes.  It doesn't offer th=
e
> > possibility of using 64kB page sizes on ARM, for example.  But it's a
> > step in the right direction.
>=20
> I was going to ask more or less the same question, I would have liked t=
o use
> 512kB hugepages on powerpc 8xx.
>=20
> Even the 8M hugepages (still on the 8xx), can they be used as well, tak=
ing
> into account that two PGD entries have to point to the same 8M page ?
>=20
> I sent out a series which tends to make the management of 512k and 8M p=
ages
> closer to what Linux expects, in order to use them inside kernel, for L=
inear
> mappings and Kasan mappings for the moment. See
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D164620
> It would be nice if we could amplify it a use it for ioremaps and vmall=
ocs
> as well.

I haven't been looking at vmalloc at all; I've been looking at the page
cache.  See:
https://lore.kernel.org/linux-mm/20200212041845.25879-1-willy@infradead.o=
rg/

Once we have large pages in the page cache, I want to sort out the API
for asking the CPU to insert a TLB entry.  Right now, we use set_pte_at()=
,
set_pmd_at() and set_pud_at().  I'm thinking something along the lines of=
:

vm_fault_t vmf_set_page_at(struct vm_fault *vmf, struct page *page);

and the architecture can insert whatever PTEs and/or TLB entries it
likes based on compound_order(page) -- if, say, it's a 1MB page, it might
choose to insert 2 * 512kB entries, or just the upper or lower 512kB entr=
y
(depending which half of the 1MB page the address sits in).
