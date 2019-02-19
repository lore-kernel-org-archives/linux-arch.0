Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39718 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbfBSDIz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Feb 2019 22:08:55 -0500
Subject: Re: [PATCH] arm64: mm: enable per pmd page table lock
References: <20190214211642.2200-1-yuzhao@google.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f67b5468-2144-c51f-6cf0-ea7ece93b502@arm.com>
Date: Tue, 19 Feb 2019 08:38:54 +0530
MIME-Version: 1.0
In-Reply-To: <20190214211642.2200-1-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu Zhao <yuzhao@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20190219030854._A_VkLr7DyQiMUx2Qs67vMs7OllMaKAhopFrefMTlNI@z>



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
 
