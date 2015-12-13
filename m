From: Chen Gang <chengang@emindsoft.com.cn>
Subject: Re: [PATCH trivial] include/asm-generic/pgtable.h: Notice about coding
 styles
Date: Sun, 13 Dec 2015 17:14:09 +0800
Message-ID: <566D36E1.3030709@emindsoft.com.cn>
References: <566D357E.3030004@emindsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail113-251.mail.alibaba.com ([205.204.113.251]:42478 "EHLO
	us-alimail-mta2.hst.scl.en.alidc.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751363AbbLMJML (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 13 Dec 2015 04:12:11 -0500
In-Reply-To: <566D357E.3030004@emindsoft.com.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <chengang@emindsoft.com.cn>, arnd@arndb.de, trivial@kernel.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, chenwei@emindsoft.com.cn, Chen Gang <gang.chen.5i5j@gmail.com>

Hello all:

After communicated with my company, I am permitted to use my company
email to send patches to open source community.

My company supports what I have done for open source community, but at
present, I still use my personal mail id as Signed-of-by (make and send
patches mainly during my free time).

And thank my company for the support.=20


Thanks.

On 12/13/15 17:08, Chen Gang wrote:
>=20
> Notice about 80 columns, and function parameters alignment.
>=20
> Export zero_pfn only once.
>=20
> Remove pte variable in ptep_get_and_clear_full().
>=20
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  include/asm-generic/pgtable.h | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgta=
ble.h
> index 63abda1..aecf0141 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -135,8 +135,8 @@ static inline pmd_t pmdp_huge_get_and_clear(struc=
t mm_struct *mm,
>  #ifndef __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR_FULL
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static inline pmd_t pmdp_huge_get_and_clear_full(struct mm_struct *m=
m,
> -					    unsigned long address, pmd_t *pmdp,
> -					    int full)
> +						 unsigned long address,
> +						 pmd_t *pmdp, int full)
>  {
>  	return pmdp_huge_get_and_clear(mm, address, pmdp);
>  }
> @@ -148,9 +148,7 @@ static inline pte_t ptep_get_and_clear_full(struc=
t mm_struct *mm,
>  					    unsigned long address, pte_t *ptep,
>  					    int full)
>  {
> -	pte_t pte;
> -	pte =3D ptep_get_and_clear(mm, address, ptep);
> -	return pte;
> +	return ptep_get_and_clear(mm, address, ptep);
>  }
>  #endif
> =20
> @@ -183,7 +181,8 @@ extern pmd_t pmdp_huge_clear_flush(struct vm_area=
_struct *vma,
> =20
>  #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
>  struct mm_struct;
> -static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned=
 long address, pte_t *ptep)
> +static inline void ptep_set_wrprotect(struct mm_struct *mm,
> +				      unsigned long address, pte_t *ptep)
>  {
>  	pte_t old_pte =3D *ptep;
>  	set_pte_at(mm, address, ptep, pte_wrprotect(old_pte));
> @@ -583,10 +582,11 @@ extern void untrack_pfn(struct vm_area_struct *=
vma, unsigned long pfn,
>  			unsigned long size);
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
> @@ -596,13 +596,11 @@ static inline int is_zero_pfn(unsigned long pfn=
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
Chen Gang (=E9=99=88=E5=88=9A)

Open, share, and attitude like air, water, and life which God blessed
