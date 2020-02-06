From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v6 07/11] powerpc/kvm/e500: Use functions to track
 lockless pgtbl walks
Date: Thu, 6 Feb 2020 07:18:02 +0100
Message-ID: <fae235d5-78b6-87aa-ed3f-1a908d61abf4@c-s.fr>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
 <20200206030900.147032-8-leonardo@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200206030900.147032-8-leonardo@linux.ibm.com>
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
To: Leonardo Bras <leonardo@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org



Le 06/02/2020 à 04:08, Leonardo Bras a écrit :
> Applies the new functions used for tracking lockless pgtable walks on
> kvmppc_e500_shadow_map().
> 
> Fixes the place where local_irq_restore() is called: previously, if ptep
> was NULL, local_irq_restore() would never be called.
> 
> local_irq_{save,restore} is already inside {begin,end}_lockless_pgtbl_walk,
> so there is no need to repeat it here.
> 
> Variable that saves the	irq mask was renamed from flags to irq_mask so it
> doesn't lose meaning now it's not directly passed to local_irq_* functions.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>   arch/powerpc/kvm/e500_mmu_host.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
> index 425d13806645..3dcf11f77256 100644
> --- a/arch/powerpc/kvm/e500_mmu_host.c
> +++ b/arch/powerpc/kvm/e500_mmu_host.c
> @@ -336,7 +336,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>   	pte_t *ptep;
>   	unsigned int wimg = 0;
>   	pgd_t *pgdir;
> -	unsigned long flags;
> +	unsigned long irq_mask;
>   
>   	/* used to check for invalidations in progress */
>   	mmu_seq = kvm->mmu_notifier_seq;
> @@ -473,7 +473,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>   	 * We are holding kvm->mmu_lock so a notifier invalidate
>   	 * can't run hence pfn won't change.
>   	 */
> -	local_irq_save(flags);
> +	irq_mask = begin_lockless_pgtbl_walk();
>   	ptep = find_linux_pte(pgdir, hva, NULL, NULL);
>   	if (ptep) {
>   		pte_t pte = READ_ONCE(*ptep);
> @@ -481,15 +481,16 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>   		if (pte_present(pte)) {
>   			wimg = (pte_val(pte) >> PTE_WIMGE_SHIFT) &
>   				MAS2_WIMGE_MASK;
> -			local_irq_restore(flags);
>   		} else {
> -			local_irq_restore(flags);
> +			end_lockless_pgtbl_walk(irq_mask);
>   			pr_err_ratelimited("%s: pte not present: gfn %lx,pfn %lx\n",
>   					   __func__, (long)gfn, pfn);
>   			ret = -EINVAL;
>   			goto out;
>   		}
>   	}
> +	end_lockless_pgtbl_walk(irq_mask);
> +

I don't really like unbalanced begin/end.

Something like the following would be cleaner:


begin_lockless_pgtbl_walk()
ptep = find()
if (ptep) {
	pte = READ_ONCE()
	if (pte_present(pte))
		wing=
	else
		ret = -EINVAL;
}
end_lockless_pgtbl_walk()

if (ret) {
	pr_err_rate...()
	goto out;
}



>   	kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
>   
>   	kvmppc_e500_setup_stlbe(&vcpu_e500->vcpu, gtlbe, tsize,
> 

Christophe
