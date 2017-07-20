Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933183AbdGTF6a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jul 2017 01:58:30 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6K5sxHT030131
        for <linux-arch@vger.kernel.org>; Thu, 20 Jul 2017 01:58:29 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2btgx7kf57-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 20 Jul 2017 01:58:29 -0400
Received: from localhost
        by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Thu, 20 Jul 2017 15:58:27 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC v6 06/62] powerpc: use helper functions in __hash_page_64K() for 64K PTE
In-Reply-To: <1500177424-13695-7-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com> <1500177424-13695-7-git-send-email-linuxram@us.ibm.com>
Date: Thu, 20 Jul 2017 11:28:13 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <87y3rjps3u.fsf@skywalker.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
Message-ID: <20170720055813.f3dfZ6hWKk6xE6szVE0tApD9OkQyE0I-GXZWSG-oCNY@z>

Ram Pai <linuxram@us.ibm.com> writes:

> replace redundant code in __hash_page_64K() with helper
> functions pte_get_hash_gslot() and pte_set_hash_slot()
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>


> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/mm/hash64_64k.c |   24 ++++--------------------
>  1 files changed, 4 insertions(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
> index 0012618..645f621 100644
> --- a/arch/powerpc/mm/hash64_64k.c
> +++ b/arch/powerpc/mm/hash64_64k.c
> @@ -244,7 +244,6 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
>  		    unsigned long flags, int ssize)
>  {
>  	real_pte_t rpte;
> -	unsigned long *hidxp;
>  	unsigned long hpte_group;
>  	unsigned long rflags, pa;
>  	unsigned long old_pte, new_pte;
> @@ -289,18 +288,12 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
>
>  	vpn  = hpt_vpn(ea, vsid, ssize);
>  	if (unlikely(old_pte & H_PAGE_HASHPTE)) {
> -		unsigned long hash, slot, hidx;
> -
> -		hash = hpt_hash(vpn, shift, ssize);
> -		hidx = __rpte_to_hidx(rpte, 0);
> -		if (hidx & _PTEIDX_SECONDARY)
> -			hash = ~hash;
> -		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> -		slot += hidx & _PTEIDX_GROUP_IX;
> +		unsigned long gslot;
>  		/*
>  		 * There MIGHT be an HPTE for this pte
>  		 */
> -		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_64K,
> +		gslot = pte_get_hash_gslot(vpn, shift, ssize, rpte, 0);
> +		if (mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn, MMU_PAGE_64K,
>  					       MMU_PAGE_64K, ssize,
>  					       flags) == -1)
>  			old_pte &= ~_PAGE_HPTEFLAGS;
> @@ -350,17 +343,8 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
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
>  		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
> +		new_pte |= pte_set_hash_slot(ptep, rpte, 0, slot);
>  	}
>  	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
>  	return 0;
> -- 
> 1.7.1
