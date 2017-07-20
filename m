Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933017AbdGTG2P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jul 2017 02:28:15 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6K6OaN5056779
        for <linux-arch@vger.kernel.org>; Thu, 20 Jul 2017 02:28:15 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2btce3x65s-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 20 Jul 2017 02:28:15 -0400
Received: from localhost
        by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Thu, 20 Jul 2017 16:28:12 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC v6 26/62] powerpc: Program HPTE key protection bits
In-Reply-To: <1500177424-13695-27-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-27-git-send-email-linuxram@us.ibm.com>
Date: Thu, 20 Jul 2017 11:58:02 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <87pocvpqq5.fsf@skywalker.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
Message-ID: <20170720062802.wTzvkXrGECKT0Ox4G0YLTnCDl45GvOa_Y-Wq2ZrlgmU@z>

Ram Pai <linuxram@us.ibm.com> writes:

> Map the PTE protection key bits to the HPTE key protection bits,
> while creating HPTE  entries.
>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |    5 +++++
>  arch/powerpc/include/asm/pkeys.h              |   12 ++++++++++++
>  arch/powerpc/mm/hash_utils_64.c               |    4 ++++
>  3 files changed, 21 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> index 6981a52..f7a6ed3 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -90,6 +90,8 @@
>  #define HPTE_R_PP0		ASM_CONST(0x8000000000000000)
>  #define HPTE_R_TS		ASM_CONST(0x4000000000000000)
>  #define HPTE_R_KEY_HI		ASM_CONST(0x3000000000000000)
> +#define HPTE_R_KEY_BIT0		ASM_CONST(0x2000000000000000)
> +#define HPTE_R_KEY_BIT1		ASM_CONST(0x1000000000000000)
>  #define HPTE_R_RPN_SHIFT	12
>  #define HPTE_R_RPN		ASM_CONST(0x0ffffffffffff000)
>  #define HPTE_R_RPN_3_0		ASM_CONST(0x01fffffffffff000)
> @@ -104,6 +106,9 @@
>  #define HPTE_R_C		ASM_CONST(0x0000000000000080)
>  #define HPTE_R_R		ASM_CONST(0x0000000000000100)
>  #define HPTE_R_KEY_LO		ASM_CONST(0x0000000000000e00)
> +#define HPTE_R_KEY_BIT2		ASM_CONST(0x0000000000000800)
> +#define HPTE_R_KEY_BIT3		ASM_CONST(0x0000000000000400)
> +#define HPTE_R_KEY_BIT4		ASM_CONST(0x0000000000000200)
>
>  #define HPTE_V_1TB_SEG		ASM_CONST(0x4000000000000000)
>  #define HPTE_V_VRMA_MASK	ASM_CONST(0x4001ffffff000000)
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index ad39db0..bbb5d85 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -41,6 +41,18 @@ static inline u64 vmflag_to_page_pkey_bits(u64 vm_flags)
>  		((vm_flags & VM_PKEY_BIT4) ? H_PAGE_PKEY_BIT0 : 0x0UL));
>  }
>
> +static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
> +{
> +	if (!pkey_inited)
> +		return 0x0UL;
> +
> +	return (((pteflags & H_PAGE_PKEY_BIT0) ? HPTE_R_KEY_BIT0 : 0x0UL) |
> +		((pteflags & H_PAGE_PKEY_BIT1) ? HPTE_R_KEY_BIT1 : 0x0UL) |
> +		((pteflags & H_PAGE_PKEY_BIT2) ? HPTE_R_KEY_BIT2 : 0x0UL) |
> +		((pteflags & H_PAGE_PKEY_BIT3) ? HPTE_R_KEY_BIT3 : 0x0UL) |
> +		((pteflags & H_PAGE_PKEY_BIT4) ? HPTE_R_KEY_BIT4 : 0x0UL));
> +}
> +
>  static inline int vma_pkey(struct vm_area_struct *vma)
>  {
>  	if (!pkey_inited)
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index f88423b..1e74529 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -231,6 +231,10 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
>  		 */
>  		rflags |= HPTE_R_M;
>
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	rflags |= pte_to_hpte_pkey_bits(pteflags);
> +#endif
> +
>  	return rflags;
>  }
>
> -- 
> 1.7.1
