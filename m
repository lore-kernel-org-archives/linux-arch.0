From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RESEND PATCH v5 3/6] arm64: Add tlbi_user_level TLB
 invalidation helper
Date: Fri, 10 Jul 2020 09:53:27 +0100
Message-ID: <20200710085326.GA11839@gaia>
References: <20200625080314.230-1-yezhenyu2@huawei.com>
 <20200625080314.230-4-yezhenyu2@huawei.com>
 <20200709164845.GB6579@gaia>
 <33a5dc75-8209-e198-bb41-8b4ab82c000e@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgGJIxe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jul 2020 04:53:34 -0400
Content-Disposition: inline
In-Reply-To: <33a5dc75-8209-e198-bb41-8b4ab82c000e@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com

On Fri, Jul 10, 2020 at 09:20:59AM +0800, Zhenyu Ye wrote:
> On 2020/7/10 0:48, Catalin Marinas wrote:
> > On Thu, Jun 25, 2020 at 04:03:11PM +0800, Zhenyu Ye wrote:
> >> @@ -189,8 +195,9 @@ static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
> >>  	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
> >>  
> >>  	dsb(ishst);
> >> -	__tlbi(vale1is, addr);
> >> -	__tlbi_user(vale1is, addr);
> >> +	/* This function is only called on a small page */
> >> +	__tlbi_level(vale1is, addr, 3);
> >> +	__tlbi_user_level(vale1is, addr, 3);
> >>  }
> > 
> > Actually, that's incorrect. It was ok in v2 of your patches when I
> > suggested to drop level 0, just leave the function unchanged but I
> > missed that you updated it to pass level 3.
> > 
> > pmdp_set_access_flags -> ptep_set_access_flags ->
> > flush_tlb_fix_spurious_fault -> flush_tlb_page -> flush_tlb_page_nosync.
> 
> How do you want to fix this error? I notice that this series have been applied
> to arm64 (for-next/tlbi).  Should I send a new series based on arm64 (for-next/tlbi)?

Just a patch on top with a Fixes: tag.

Thanks.

-- 
Catalin
