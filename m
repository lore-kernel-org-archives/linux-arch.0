Return-Path: <SRS0=hIPo=75=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [PATCH] mm/pgtable: Move extern zero_pfn outside
 __HAVE_COLOR_ZERO_PAGE
References: <1592280498-15442-1-git-send-email-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f55dff2d-d32e-8de1-0177-e6ba713e0cd9@redhat.com>
Date: Tue, 16 Jun 2020 09:39:07 +0200
MIME-Version: 1.0
In-Reply-To: <1592280498-15442-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200616073907.zlqz5zzWuJkYBDFNPSmaMyzJ1nHTy3guwPZvf6TrbD0@z>

On 16.06.20 06:08, Anshuman Khandual wrote:
> zero_pfn variable is required whether __HAVE_COLOR_ZERO_PAGE is enabled

Why is that relevant for this patch?

> or not. Also it should not really be declared individually in all funct=
ions
> where it gets used. Just move the declaration outside, which also makes=
 it
> available for other potential users.

So, all you're essentially doing is exposing zero_pfn in pgtable.h now.

If everybody should just use my_zero_pfn(), I don't really see the
benefit of this patch, sorry.

>=20
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Applies on 5.8-rc1. If the earlier motivation was to hide zero_pfn from
> general visibility, we could just put in a comment and update the commi=
t
> message that my_zero_pfn() should always be used rather than zero_pfn.
> Build tested on many platforms and boot tested on arm64, x86.
>=20
>  include/linux/pgtable.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 32b6c52d41b9..078e9864abca 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1020,10 +1020,11 @@ extern void untrack_pfn(struct vm_area_struct *=
vma, unsigned long pfn,
>  extern void untrack_pfn_moved(struct vm_area_struct *vma);
>  #endif
> =20
> +extern unsigned long zero_pfn;
> +
>  #ifdef __HAVE_COLOR_ZERO_PAGE
>  static inline int is_zero_pfn(unsigned long pfn)
>  {
> -	extern unsigned long zero_pfn;
>  	unsigned long offset_from_zero_pfn =3D pfn - zero_pfn;
>  	return offset_from_zero_pfn <=3D (zero_page_mask >> PAGE_SHIFT);
>  }
> @@ -1033,13 +1034,11 @@ static inline int is_zero_pfn(unsigned long pfn=
)
>  #else
>  static inline int is_zero_pfn(unsigned long pfn)
>  {
> -	extern unsigned long zero_pfn;
>  	return pfn =3D=3D zero_pfn;
>  }
> =20
>  static inline unsigned long my_zero_pfn(unsigned long addr)
>  {
> -	extern unsigned long zero_pfn;
>  	return zero_pfn;
>  }
>  #endif
>=20


--=20
Thanks,

David / dhildenb
