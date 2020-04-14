From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Date: Tue, 14 Apr 2020 21:39:53 +1000
Message-ID: <1586863931.xb4yeowkao.astroid@bobo.none>
References: <20200413125303.423864-1-npiggin@gmail.com>
        <20200413125303.423864-5-npiggin@gmail.com>
        <20200413134106.GN21484@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200413134106.GN21484@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

Excerpts from Matthew Wilcox's message of April 13, 2020 11:41 pm:
> On Mon, Apr 13, 2020 at 10:53:03PM +1000, Nicholas Piggin wrote:
>> +static int vmap_pages_range_noflush(unsigned long start, unsigned long =
end,
>> +				    pgprot_t prot, struct page **pages,
>> +				    unsigned int page_shift)
>> +{
>> +	if (page_shift =3D=3D PAGE_SIZE) {
>=20
> ... I think you meant 'page_shift =3D=3D PAGE_SHIFT'

Thanks, good catch. I obviously didn't test the fallback path (the
other path works for small pages, it just goes one at a time).

> Overall I like this series, although it's a bit biased towards CPUs
> which have page sizes which match PMD/PUD sizes.  It doesn't offer the
> possibility of using 64kB page sizes on ARM, for example.

No, it's just an incremental step on existing huge vmap stuff in
tree, so such a thing would be out of scope.

> But it's a
> step in the right direction.
>=20

I don't know about moving kernel maps away from a generic Linux page
table format. I quite like moving to it and making it as generic as
possible.

On the other hand, I also would like to make some arch-specific
allowances for certain special cases that may not fit within the
standard page table format, but it might be a much more specific and
limited interface than the general vmalloc stuff.

Thanks,
Nick
