From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 05/19] arm64: get rid of superfluous __GFP_REPEAT
Date: Mon, 11 Apr 2016 16:49:47 +0100
Message-ID: <20160411154947.GC19749@arm.com>
References: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
 <1460372892-8157-6-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50774 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071AbcDKPtv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Apr 2016 11:49:51 -0400
Content-Disposition: inline
In-Reply-To: <1460372892-8157-6-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org

On Mon, Apr 11, 2016 at 01:07:58PM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> __GFP_REPEAT has a rather weak semantic but since it has been introduced
> around 2.6.12 it has been ignored for low order allocations.
> 
> {pte,pmd,pud}_alloc_one{_kernel}, late_pgtable_alloc use PGALLOC_GFP for
> __get_free_page (aka order-0).
> 
> pgd_alloc is slightly more complex because it allocates from pgd_cache
> if PGD_SIZE != PAGE_SIZE and PGD_SIZE depends on the configuration
> (CONFIG_ARM64_VA_BITS, PAGE_SHIFT and CONFIG_PGTABLE_LEVELS).
> 
> As per
> config PGTABLE_LEVELS
> 	int
> 	default 2 if ARM64_16K_PAGES && ARM64_VA_BITS_36
> 	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
> 	default 3 if ARM64_64K_PAGES && ARM64_VA_BITS_48
> 	default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
> 	default 3 if ARM64_16K_PAGES && ARM64_VA_BITS_47
> 	default 4 if !ARM64_64K_PAGES && ARM64_VA_BITS_48
> 
> we should have the following options
> 
> CONFIG_ARM64_VA_BITS:48 CONFIG_PGTABLE_LEVELS:4 PAGE_SIZE:4k size:4096 pages:1
> CONFIG_ARM64_VA_BITS:48 CONFIG_PGTABLE_LEVELS:4 PAGE_SIZE:16k size:16 pages:1
> CONFIG_ARM64_VA_BITS:48 CONFIG_PGTABLE_LEVELS:3 PAGE_SIZE:64k size:512 pages:1
> CONFIG_ARM64_VA_BITS:47 CONFIG_PGTABLE_LEVELS:3 PAGE_SIZE:16k size:16384 pages:1
> CONFIG_ARM64_VA_BITS:42 CONFIG_PGTABLE_LEVELS:2 PAGE_SIZE:64k size:65536 pages:1
> CONFIG_ARM64_VA_BITS:39 CONFIG_PGTABLE_LEVELS:3 PAGE_SIZE:4k size:4096 pages:1
> CONFIG_ARM64_VA_BITS:36 CONFIG_PGTABLE_LEVELS:2 PAGE_SIZE:16k size:16384 pages:1
> 
> All of them fit into a single page (aka order-0). This means that this
> flag has never been actually useful here because it has always been used
> only for PAGE_ALLOC_COSTLY requests.

This all looks fine to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
