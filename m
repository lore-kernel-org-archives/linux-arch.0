From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v6 04/11] powerpc/mce_power: Use functions to track
 lockless pgtbl walks
Date: Thu, 6 Feb 2020 06:48:12 +0100
Message-ID: <e8a5db5a-d1a5-ef25-af46-c44949750e8a@c-s.fr>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
 <20200206030900.147032-5-leonardo@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:50830 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgBFFsa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Feb 2020 00:48:30 -0500
In-Reply-To: <20200206030900.147032-5-leonardo@linux.ibm.com>
Content-Language: fr
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Leonardo Bras <leonardo@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org



Le 06/02/2020 à 04:08, Leonardo Bras a écrit :
> Applies the new functions used for tracking lockless pgtable walks on
> addr_to_pfn().
> 
> local_irq_{save,restore} is already inside {begin,end}_lockless_pgtbl_walk,
> so there is no need to repeat it here.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>   arch/powerpc/kernel/mce_power.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index 1cbf7f1a4e3d..a9e38ef4e437 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -29,7 +29,7 @@ unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
>   {
>   	pte_t *ptep;
>   	unsigned int shift;
> -	unsigned long pfn, flags;
> +	unsigned long pfn, irq_mask;

Why change the name ? flags is a well known historical name.

>   	struct mm_struct *mm;
>   
>   	if (user_mode(regs))
> @@ -37,7 +37,7 @@ unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
>   	else
>   		mm = &init_mm;
>   
> -	local_irq_save(flags);
> +	irq_mask = begin_lockless_pgtbl_walk();
>   	ptep = __find_linux_pte(mm->pgd, addr, NULL, &shift);
>   
>   	if (!ptep || pte_special(*ptep)) {
> @@ -53,7 +53,7 @@ unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
>   	}
>   
>   out:
> -	local_irq_restore(flags);
> +	end_lockless_pgtbl_walk(irq_mask);
>   	return pfn;
>   }
>   
> 

Christophe
