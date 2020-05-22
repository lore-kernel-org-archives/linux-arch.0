Return-Path: <SRS0=yLSb=7E=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:38368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730058AbgEVPth (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 May 2020 11:49:37 -0400
Date: Fri, 22 May 2020 16:49:25 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 3/6] arm64: Add tlbi_user_level TLB invalidation helper
Message-ID: <20200522154925.GE26492@gaia>
References: <20200423135656.2712-1-yezhenyu2@huawei.com>
 <20200423135656.2712-4-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423135656.2712-4-yezhenyu2@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Message-ID: <20200522154925.SsY31MOkPltyXeuW7aG_WGK9Kul33g4LMZ_pF6KGpfY@z>

On Thu, Apr 23, 2020 at 09:56:53PM +0800, Zhenyu Ye wrote:
> @@ -190,8 +196,8 @@ static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
>  	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
>  
>  	dsb(ishst);
> -	__tlbi(vale1is, addr);
> -	__tlbi_user(vale1is, addr);
> +	__tlbi_level(vale1is, addr, 0);
> +	__tlbi_user_level(vale1is, addr, 0);
>  }

This one remains with a level 0 throughout the series. Is this
intentional? If we can't guarantee the level here, better to use the
non-level __tlbi().

-- 
Catalin
