Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail113-248.mail.alibaba.com ([205.204.113.248]:53197 "EHLO
	us-alimail-mta1.hst.scl.en.alidc.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753682AbbLOOR5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Dec 2015 09:17:57 -0500
Message-ID: <56702193.9040004@emindsoft.com.cn>
Date: Tue, 15 Dec 2015 22:20:03 +0800
From: Chen Gang <chengang@emindsoft.com.cn>
MIME-Version: 1.0
Subject: Re: [PATCH trivial] include: asm-generic: Notice about 80 columns
 in pgtable-no*.h
References: <56702088.9080605@emindsoft.com.cn>
In-Reply-To: <56702088.9080605@emindsoft.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, trivial@kernel.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20151215142003.7Rao8223Ar6D48N8leld4V6xztEsrlNT7fNWLQh1ADM@z>


After this patch, I finish 'scanning' mm related headers in
"include/asm-genric/*".

Next I shall continue 'scanning' mm related headers in
"include/linux/*" to know about the common sense information.

Thanks.

On 12/15/15 22:15, Chen Gang wrote:
> 
> It is a trivial patch.
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  include/asm-generic/pgtable-nopmd.h | 3 ++-
>  include/asm-generic/pgtable-nopud.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
> index 725612b..7a81185 100644
> --- a/include/asm-generic/pgtable-nopmd.h
> +++ b/include/asm-generic/pgtable-nopmd.h
> @@ -38,7 +38,8 @@ static inline void pud_clear(pud_t *pud)	{ }
>   * (pmds are folded into puds so this doesn't get actually called,
>   * but the define is needed for a generic inline function.)
>   */
> -#define set_pud(pudptr, pudval)			set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
> +#define set_pud(pudptr, pudval)			(set_pmd((pmd_t *)(pudptr), \
> +							(pmd_t) { pudval }))
>  
>  static inline pmd_t * pmd_offset(pud_t * pud, unsigned long address)
>  {
> diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
> index 810431d..bc78818 100644
> --- a/include/asm-generic/pgtable-nopud.h
> +++ b/include/asm-generic/pgtable-nopud.h
> @@ -33,7 +33,8 @@ static inline void pgd_clear(pgd_t *pgd)	{ }
>   * (puds are folded into pgds so this doesn't get actually called,
>   * but the define is needed for a generic inline function.)
>   */
> -#define set_pgd(pgdptr, pgdval)			set_pud((pud_t *)(pgdptr), (pud_t) { pgdval })
> +#define set_pgd(pgdptr, pgdval)			(set_pud((pud_t *)(pgdptr), \
> +							(pud_t) { pgdval }))
>  
>  static inline pud_t * pud_offset(pgd_t * pgd, unsigned long address)
>  {
> 

-- 
Chen Gang (陈刚)

Open, share, and attitude like air, water, and life which God blessed
