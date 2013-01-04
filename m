From: Christoffer Dall <c.dall@virtualopensystems.com>
Subject: Re: [RFC PATCH 1/6] ARM: mm: correct pte_same behaviour for LPAE.
Date: Fri, 4 Jan 2013 00:03:26 -0500
Message-ID: <CANM98qJEigKksbv5QdGLWzCdaSj9NipJ-RYrouzWPRn6XVCw0Q@mail.gmail.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
	<1350576942-25299-2-git-send-email-steve.capper@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:51898 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab3ADFD1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jan 2013 00:03:27 -0500
Received: by mail-ie0-f177.google.com with SMTP id k13so19390271iea.36
        for <linux-arch@vger.kernel.org>; Thu, 03 Jan 2013 21:03:27 -0800 (PST)
In-Reply-To: <1350576942-25299-2-git-send-email-steve.capper@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, aarcange@redhat.com, bill4carson@gmail.com, tawfik@marvell.com, catalin.marinas@arm.com, will.deacon@arm.com, cmetcalf@tilera.com, mhocko@suse.cz, maen@marvell.com, hoffman@marvell.com, notasas@gmail.com, kirill@shutemov.name, akpm@linux-foundation.org, shadi@marvell.com

On Thu, Oct 18, 2012 at 12:15 PM, Steve Capper <steve.capper@arm.com> wrote:
> For 3 levels of paging the PTE_EXT_NG bit will be set for user address ptes
> that are written to a page table but not for ptes created with mk_pte.
>
> This can cause some comparison tests made by pte_same to fail spuriously and
> lead to other problems.
>
> To correct this behaviour, we mask off PTE_EXT_NG for any pte that is
> present before running the comparison.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Steve Capper <steve.capper@arm.com>
> ---
>  arch/arm/include/asm/pgtable-2level.h |    5 +++++
>  arch/arm/include/asm/pgtable-3level.h |    5 +++++
>  arch/arm/include/asm/pgtable.h        |   23 +++++++++++++++++++++++
>  3 files changed, 33 insertions(+)
>
> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> index 2317a71..662a00e 100644
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> @@ -125,6 +125,11 @@
>  #define L_PTE_SHARED           (_AT(pteval_t, 1) << 10)        /* shared(v6), coherent(xsc3) */
>
>  /*
> + * for 2 levels of paging we don't mask off any bits when comparing present ptes
> + */
> +#define L_PTE_CMP_MASKOFF      0
> +
> +/*
>   * These are the memory types, defined to be compatible with
>   * pre-ARMv6 CPUs cacheable and bufferable bits:   XXCB
>   */
> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
> index b249035..0eaeb55 100644
> --- a/arch/arm/include/asm/pgtable-3level.h
> +++ b/arch/arm/include/asm/pgtable-3level.h
> @@ -84,6 +84,11 @@
>  #define L_PTE_DIRTY_HIGH       (1 << (55 - 32))
>
>  /*
> + * we need to mask off PTE_EXT_NG when comparing present ptes.
> + */
> +#define L_PTE_CMP_MASKOFF      PTE_EXT_NG
> +
> +/*
>   * AttrIndx[2:0] encoding (mapping attributes defined in the MAIR* registers).
>   */
>  #define L_PTE_MT_UNCACHED      (_AT(pteval_t, 0) << 2) /* strongly ordered */
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 08c1231..c35bf46 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -248,6 +248,29 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  }
>
>  /*
> + * For 3 levels of paging the PTE_EXT_NG bit will be set for user address ptes
> + * that are written to a page table but not for ptes created with mk_pte.
> + *

Why is this not the case for 2 levels of paging as well?

Is that because it's always checked against the Linux version, or?


> + * This can cause some comparison tests made by pte_same to fail spuriously and
> + * lead to other problems.
> + *
> + * To correct this behaviour, we mask off PTE_EXT_NG for any pte that is
> + * present before running the comparison.

nit: This comment doesn't really explain the rationale, I'm assuming
that pte_same is used to compare only which page gets mapped, assuming
the attributes etc. remain the same? or also the attributes should be
the same, only mk_pte sets all of these except the NG bit.

> + */
> +#define __HAVE_ARCH_PTE_SAME
> +static inline int pte_same(pte_t pte_a, pte_t pte_b)
> +{
> +       pteval_t vala = pte_val(pte_a), valb = pte_val(pte_b);
> +       if (pte_present(pte_a))
> +               vala &= ~L_PTE_CMP_MASKOFF;
> +
> +       if (pte_present(pte_b))
> +               valb &= ~L_PTE_CMP_MASKOFF;
> +
> +       return vala == valb;
> +}
> +
> +/*
>   * Encode and decode a swap entry.  Swap entries are stored in the Linux
>   * page tables as follows:
>   *
> --
> 1.7.9.5
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
