Return-Path: <SRS0=05z6=56=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-5-npiggin@gmail.com>
 <20200413134106.GN21484@bombadil.infradead.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <36616218-1d3a-b18a-8fb8-4fc9eff22780@c-s.fr>
Date: Tue, 14 Apr 2020 14:28:35 +0200
MIME-Version: 1.0
In-Reply-To: <20200413134106.GN21484@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Matthew Wilcox <willy@infradead.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200414122835.LKkCifIYBDd92hQKODMzvfZBIYhwCrMpYjmX0ZYhCHA@z>



Le 13/04/2020 =C3=A0 15:41, Matthew Wilcox a =C3=A9crit=C2=A0:
> On Mon, Apr 13, 2020 at 10:53:03PM +1000, Nicholas Piggin wrote:
>> +static int vmap_pages_range_noflush(unsigned long start, unsigned lon=
g end,
>> +				    pgprot_t prot, struct page **pages,
>> +				    unsigned int page_shift)
>> +{
>> +	if (page_shift =3D=3D PAGE_SIZE) {
>=20
> ... I think you meant 'page_shift =3D=3D PAGE_SHIFT'
>=20
> Overall I like this series, although it's a bit biased towards CPUs
> which have page sizes which match PMD/PUD sizes.  It doesn't offer the
> possibility of using 64kB page sizes on ARM, for example.  But it's a
> step in the right direction.
>=20

I was going to ask more or less the same question, I would have liked to=20
use 512kB hugepages on powerpc 8xx.

Even the 8M hugepages (still on the 8xx), can they be used as well,=20
taking into account that two PGD entries have to point to the same 8M pag=
e ?

I sent out a series which tends to make the management of 512k and 8M=20
pages closer to what Linux expects, in order to use them inside kernel,=20
for Linear mappings and Kasan mappings for the moment. See=20
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D164620
It would be nice if we could amplify it a use it for ioremaps and=20
vmallocs as well.

Christophe
