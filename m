From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RESEND PATCH v5 3/6] arm64: Add tlbi_user_level TLB
 invalidation helper
Date: Thu, 9 Jul 2020 17:48:46 +0100
Message-ID: <20200709164845.GB6579@gaia>
References: <20200625080314.230-1-yezhenyu2@huawei.com>
 <20200625080314.230-4-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200625080314.230-4-yezhenyu2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 25, 2020 at 04:03:11PM +0800, Zhenyu Ye wrote:
> @@ -189,8 +195,9 @@ static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
>  	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
>  
>  	dsb(ishst);
> -	__tlbi(vale1is, addr);
> -	__tlbi_user(vale1is, addr);
> +	/* This function is only called on a small page */
> +	__tlbi_level(vale1is, addr, 3);
> +	__tlbi_user_level(vale1is, addr, 3);
>  }

Actually, that's incorrect. It was ok in v2 of your patches when I
suggested to drop level 0, just leave the function unchanged but I
missed that you updated it to pass level 3.

pmdp_set_access_flags -> ptep_set_access_flags ->
flush_tlb_fix_spurious_fault -> flush_tlb_page -> flush_tlb_page_nosync.

-- 
Catalin
