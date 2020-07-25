From: Marc Zyngier <maz@kernel.org>
Subject: Re: [RESEND RFC PATCH v1] arm64: kvm: flush tlbs by range in
 unmap_stage2_range function
Date: Sat, 25 Jul 2020 18:40:13 +0100
Message-ID: <5d54c860b3b4e7a98e4d53397e6424ae@kernel.org>
References: <20200724134315.805-1-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726904AbgGYRkQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 25 Jul 2020 13:40:16 -0400
In-Reply-To: <20200724134315.805-1-yezhenyu2@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, steven.price@arm.com, mark.rutland@arm.com, ascull@google.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com

On 2020-07-24 14:43, Zhenyu Ye wrote:
> Now in unmap_stage2_range(), we flush tlbs one by one just after the
> corresponding pages cleared.  However, this may cause some performance
> problems when the unmap range is very large (such as when the vm
> migration rollback, this may cause vm downtime too loog).

You keep resending this patch, but you don't give any numbers
that would back your assertion.

> This patch moves the kvm_tlb_flush_vmid_ipa() out of loop, and
> flush tlbs by range after other operations completed.  Because we
> do not make new mapping for the pages here, so this doesn't violate
> the Break-Before-Make rules.
> 
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h |  2 ++
>  arch/arm64/kvm/hyp/tlb.c         | 36 ++++++++++++++++++++++++++++++++
>  arch/arm64/kvm/mmu.c             | 11 +++++++---
>  3 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_asm.h 
> b/arch/arm64/include/asm/kvm_asm.h
> index 352aaebf4198..ef8203d3ca45 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -61,6 +61,8 @@ extern char __kvm_hyp_vector[];
> 
>  extern void __kvm_flush_vm_context(void);
>  extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t 
> ipa);
> +extern void __kvm_tlb_flush_vmid_range(struct kvm *kvm, phys_addr_t 
> start,
> +				       phys_addr_t end);
>  extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
>  extern void __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu);
> 
> diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
> index d063a576d511..4f4737a7e588 100644
> --- a/arch/arm64/kvm/hyp/tlb.c
> +++ b/arch/arm64/kvm/hyp/tlb.c
> @@ -189,6 +189,42 @@ void __hyp_text __kvm_tlb_flush_vmid_ipa(struct
> kvm *kvm, phys_addr_t ipa)
>  	__tlb_switch_to_host(kvm, &cxt);
>  }
> 
> +void __hyp_text __kvm_tlb_flush_vmid_range(struct kvm *kvm, 
> phys_addr_t start,
> +					   phys_addr_t end)
> +{
> +	struct tlb_inv_context cxt;
> +	unsigned long addr;
> +
> +	start = __TLBI_VADDR(start, 0);
> +	end = __TLBI_VADDR(end, 0);
> +
> +	dsb(ishst);
> +
> +	/* Switch to requested VMID */
> +	kvm = kern_hyp_va(kvm);
> +	__tlb_switch_to_guest(kvm, &cxt);
> +
> +	if ((end - start) >= 512 << (PAGE_SHIFT - 12)) {
> +		__tlbi(vmalls12e1is);

And what is this magic value based on? You don't even mention in the
commit log that you are taking this shortcut.

> +		goto end;
> +	}
> +
> +	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
> +		__tlbi(ipas2e1is, addr);
> +
> +	dsb(ish);
> +	__tlbi(vmalle1is);
> +
> +end:
> +	dsb(ish);
> +	isb();
> +
> +	if (!has_vhe() && icache_is_vpipt())
> +		__flush_icache_all();
> +
> +	__tlb_switch_to_host(kvm, &cxt);
> +}
> +

I'm sorry, but without numbers backing this approach for a number
of workloads and a representative set of platforms, this is
going nowhere.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
