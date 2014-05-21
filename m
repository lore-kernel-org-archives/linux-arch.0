From: =?utf-8?B?566h6Zuq5rab?= <gxt@pku.edu.cn>
Subject: =?utf-8?Q?=E5=9B=9E=E5=A4=8D=EF=BC=9A_[PATCH_25/27]_unicore32:_Us?=
 =?utf-8?Q?e_common_bits_from_generic_tlb.h?=
Date: Wed, 21 May 2014 17:27:44 +0800 (CST)
Message-ID: <81003682.42191.1400664464528.JavaMail.root@bj-mail03.pku.edu.cn>
References: <1400093999-18703-26-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400093999-18703-26-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>
List-Id: linux-arch.vger.kernel.org

Great.

Btw, please cc first email in this patch series to everyone.

Acked-by: Xuetao Guan <gxt@mprc.pku.edu.cn>

----- Richard Weinberger <richard@nod.at> =E5=86=99=E9=81=93=EF=BC=9A
> It is no longer needed to define them on our own.
>=20
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/unicore32/include/asm/tlb.h | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/arch/unicore32/include/asm/tlb.h b/arch/unicore32/includ=
e/asm/tlb.h
> index 9cca15c..e6ba38a 100644
> --- a/arch/unicore32/include/asm/tlb.h
> +++ b/arch/unicore32/include/asm/tlb.h
> @@ -12,11 +12,6 @@
>  #ifndef __UNICORE_TLB_H__
>  #define __UNICORE_TLB_H__
> =20
> -#define tlb_start_vma(tlb, vma)				do { } while (0)
> -#define tlb_end_vma(tlb, vma)				do { } while (0)
> -#define __tlb_remove_tlb_entry(tlb, ptep, address)	do { } while (0)
> -#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
> -
>  #define __pte_free_tlb(tlb, pte, addr)				\
>  	do {							\
>  		pgtable_page_dtor(pte);				\
> --=20
> 1.8.4.2
>=20
