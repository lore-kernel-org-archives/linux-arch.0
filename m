From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64: mm: enable per pmd page table lock
Date: Tue, 19 Feb 2019 08:38:54 +0530
Message-ID: <f67b5468-2144-c51f-6cf0-ea7ece93b502@arm.com>
References: <20190214211642.2200-1-yuzhao@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214211642.2200-1-yuzhao@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yu Zhao <yuzhao@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org



On 02/15/2019 02:46 AM, Yu Zhao wrote:
> Switch from per mm_struct to per pmd page table lock by enabling
> ARCH_ENABLE_SPLIT_PMD_PTLOCK. This provides better granularity for
> large system.
> 
> I'm not sure if there is contention on mm->page_table_lock. Given
> the option comes at no cost (apart from initializing more spin
> locks), why not enable it now.
> 

This has similar changes to what I had posted part of the general page table
page accounting clean up series on arm64 last month.

https://www.spinics.net/lists/arm-kernel/msg701954.html
 
