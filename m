Return-Path: <SRS0=n14h=4F=kvack.org=owner-linux-mm@kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 3/5] mm/vma: Replace all remaining open encodings with
 is_vm_hugetlb_page()
References: <1581915833-21984-1-git-send-email-anshuman.khandual@arm.com>
 <1581915833-21984-4-git-send-email-anshuman.khandual@arm.com>
Message-ID: <50a93384-7a97-6a8e-9c46-c82d47330c06@arm.com>
Date: Mon, 17 Feb 2020 14:51:45 +0530
MIME-Version: 1.0
In-Reply-To: <1581915833-21984-4-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Alexander Viro <viro@zeniv.linux.org.uk>, Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200217092145.GVRQDgNHFhpaWMCI9I8gS_3Ms2nNeg5WnG41ootbBLM@z>

On 02/17/2020 10:33 AM, Anshuman Khandual wrote:
> This replaces all remaining open encodings with is_vm_hugetlb_page().
> 
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Will Deacon <will@kernel.org>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: kvm-ppc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/powerpc/kvm/e500_mmu_host.c | 2 +-
>  fs/binfmt_elf.c                  | 2 +-
>  include/asm-generic/tlb.h        | 2 +-
>  kernel/events/core.c             | 3 ++-
>  4 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
> index 425d13806645..3922575a1c31 100644
> --- a/arch/powerpc/kvm/e500_mmu_host.c
> +++ b/arch/powerpc/kvm/e500_mmu_host.c
> @@ -422,7 +422,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
>  				break;
>  			}
>  		} else if (vma && hva >= vma->vm_start &&
> -			   (vma->vm_flags & VM_HUGETLB)) {
> +			   (is_vm_hugetlb_page(vma))) {

Additional braces around is_vm_hugetlb_page() can be dropped here.
