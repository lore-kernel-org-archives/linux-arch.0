From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v1] arm64: tlb: don't set the ttl value in flush_tlb_page_nosync
Date: Fri, 10 Jul 2020 16:29:08 +0100
Message-ID: <159439494095.22236.16676727348403184772.b4-ty@arm.com>
References: <20200710094158.468-1-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgGJP3M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jul 2020 11:29:12 -0400
In-Reply-To: <20200710094158.468-1-yezhenyu2@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will@kernel.org, Zhenyu Ye <yezhenyu2@huawei.com>
Cc: arm@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, xiexiangyou@huawei.com, linux-arm-kernel@lists.infradead.org

On Fri, 10 Jul 2020 17:41:58 +0800, Zhenyu Ye wrote:
> flush_tlb_page_nosync() may be called from pmd level, so we
> can not set the ttl = 3 here.
> 
> The callstack is as follows:
> 
> 	pmdp_set_access_flags
> 		ptep_set_access_flags
> 			flush_tlb_fix_spurious_fault
> 				flush_tlb_page
> 					flush_tlb_page_nosync

Applied to arm64 (for-next/tlbi), thanks!

[1/1] arm64: tlb: don't set the ttl value in flush_tlb_page_nosync
      https://git.kernel.org/arm64/c/61c11656b67b

-- 
Catalin
