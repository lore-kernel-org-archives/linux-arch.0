Return-Path: <SRS0=B4xR=AR=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [PATCH v6 07/26] mm: Preserve the PG_arch_* flags in
 __split_huge_page_tail()
References: <20200703153718.16973-1-catalin.marinas@arm.com>
 <20200703153718.16973-8-catalin.marinas@arm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <16aeea8c-b5c4-0d19-2fde-f95ef8dfddc6@redhat.com>
Date: Mon, 6 Jul 2020 16:16:13 +0200
MIME-Version: 1.0
In-Reply-To: <20200703153718.16973-8-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200706141613.6_BVYVqvMsY4JzyG78zL0kczSOC0dmyrIxUi86cvGqE@z>

On 03.07.20 17:36, Catalin Marinas wrote:
> When a huge page is split into normal pages, part of the head page flag=
s
> are transferred to the tail pages. However, the PG_arch_* flags are not
> part of the preserved set.
>=20
> PG_arch_1 is currently used by the arch code to handle cache maintenanc=
e
> for user space (either for I-D cache coherency or for D-cache aliases
> consistent with the kernel mapping). Since splitting a huge page does
> not change the physical or virtual address of a mapping, additional
> cache maintenance for the tail pages is unnecessary. Preserving the
> PG_arch_1 flag from the head page in the tail pages would not break the
> current use-cases.

^ is fairly arm64 specific, no? (I remember that the semantics are
different e.g., on s390x).

Did you check if this is actually safe to do on other architectures?
Maybe rephrase the description to make this clearer.

>=20
> PG_arch_2 is currently used for arm64 MTE support to mark pages that
> have valid tags. The absence of such flag causes the arm64 set_pte_at()
> to clear the tags in order to avoid stale tags exposed to user or the
> swapping out hooks to ignore the tags. Not preserving PG_arch_2 on huge
> page splitting leads to tag corruption in the tail pages.

"currently"? I don't think so - isn't it follow-up patches in this series=
?

>=20
> To avoid the above and for consistency between the two PG_arch_* flags,
> preserve both PG_arch_1 and PG_arch_2 in __split_huge_page_tail().
>=20
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>=20
> Notes:
>     New in v6.
>=20
>  mm/huge_memory.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 78c84bee7e29..22b3236a6dd8 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2364,6 +2364,10 @@ static void __split_huge_page_tail(struct page *=
head, int tail,
>  			 (1L << PG_workingset) |
>  			 (1L << PG_locked) |
>  			 (1L << PG_unevictable) |
> +			 (1L << PG_arch_1) |
> +#ifdef CONFIG_64BIT
> +			 (1L << PG_arch_2) |
> +#endif
>  			 (1L << PG_dirty)));
> =20
>  	/* ->mapping in first tail page is compound_mapcount */
>=20


--=20
Thanks,

David / dhildenb
