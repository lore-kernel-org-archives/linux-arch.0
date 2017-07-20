Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36467 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932592AbdGTF7D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jul 2017 01:59:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6K5wixF032420
        for <linux-arch@vger.kernel.org>; Thu, 20 Jul 2017 01:59:03 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2btp4q9cyq-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 20 Jul 2017 01:59:02 -0400
Received: from localhost
        by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Thu, 20 Jul 2017 15:59:00 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC v6 07/62] powerpc: use helper functions in __hash_page_huge() for 64K PTE
In-Reply-To: <1500177424-13695-8-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-8-git-send-email-linuxram@us.ibm.com>
Date: Thu, 20 Jul 2017 11:28:48 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <87vamnps2v.fsf@skywalker.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
Message-ID: <20170720055848.FDVRjUOausAdfcNdypk6MfqjVrt76BkVh37EP9ggaxM@z>

Ram Pai <linuxram@us.ibm.com> writes:

> replace redundant code in __hash_page_huge() with helper
> functions pte_get_hash_gslot() and pte_set_hash_slot()
>

Can you fold all the helper function usage into one patch ?


> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/mm/hugetlbpage-hash64.c |   24 ++++--------------------
>  1 files changed, 4 insertions(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
> index 6f7aee3..e6dcd50 100644
> --- a/arch/powerpc/mm/hugetlbpage-hash64.c
> +++ b/arch/powerpc/mm/hugetlbpage-hash64.c
> @@ -23,7 +23,6 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  		     int ssize, unsigned int shift, unsigned int mmu_psize)
>  {
>  	real_pte_t rpte;
> -	unsigned long *hidxp;
>  	unsigned long vpn;
>  	unsigned long old_pte, new_pte;
>  	unsigned long rflags, pa, sz;
> @@ -74,16 +73,10 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  	/* Check if pte already has an hpte (case 2) */
>  	if (unlikely(old_pte & H_PAGE_HASHPTE)) {
>  		/* There MIGHT be an HPTE for this pte */
> -		unsigned long hash, slot, hidx;
> +		unsigned long gslot;
>
> -		hash = hpt_hash(vpn, shift, ssize);
> -		hidx = __rpte_to_hidx(rpte, 0);
> -		if (hidx & _PTEIDX_SECONDARY)
> -			hash = ~hash;
> -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> -		slot += hidx & _PTEIDX_GROUP_IX;
> -
> -		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, mmu_psize,
> +		gslot = pte_get_hash_gslot(vpn, shift, ssize, rpte, 0);
> +		if (mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn, mmu_psize,
>  					       mmu_psize, ssize, flags) == -1)
>  			old_pte &= ~_PAGE_HPTEFLAGS;
>  	}
> @@ -110,16 +103,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  			return -1;
>  		}
>
> -		/*
> -		 * Insert slot number & secondary bit in PTE second half.
> -		 */
> -		hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> -		rpte.hidx &= ~(0xfUL);
> -		*hidxp = rpte.hidx  | (slot & 0xfUL);
> -		/*
> -		 * check __real_pte for details on matching smp_rmb()
> -		 */
> -		smp_wmb();
> +		new_pte |= pte_set_hash_slot(ptep, rpte, 0, slot);
>  	}
>
>  	/*
> -- 
> 1.7.1
