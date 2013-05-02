Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:51300 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755837Ab3EBKAm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 May 2013 06:00:42 -0400
Date: Thu, 2 May 2013 11:00:00 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH 8/9] ARM64: mm: Introduce MAX_ZONE_ORDER for 64K
 and THP.
Message-ID: <20130502100000.GB20730@arm.com>
References: <1367339448-21727-1-git-send-email-steve.capper@linaro.org>
 <1367339448-21727-9-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1367339448-21727-9-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <Will.Deacon@arm.com>
Message-ID: <20130502100000.lmTt88mxJdx1jIx_lwvf_pZkVPx8LtwS_BrtZs5tBiU@z>

On Tue, Apr 30, 2013 at 05:30:47PM +0100, Steve Capper wrote:
> The buddy allocator has a default order of 11, which is too low to
> allocate enough memory for 512MB Transparent HugePages if our base
> page size is 64K. For any order less than 13, the combination of
> THP with 64K pages will cause a compile error.
> 
> This patch introduces the MAX_ZONE_ORDER config option that allows
> one to explicitly override the order of the buddy allocator. If
> 64K pages and THP are enabled the minimum value is set to 13.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
>  arch/arm64/Kconfig | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 16aa780..908fd95 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -196,6 +196,23 @@ config ARCH_WANT_HUGE_PMD_SHARE
>  
>  source "mm/Kconfig"
>  
> +config FORCE_MAX_ZONEORDER
> +	int "Maximum zone order"
> +	range 11 64 if !(ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
> +	range 13 64 if ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE
> +	default "11" if !(ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
> +	default "13" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)

Can we just keep some sane defaults here without giving too much choice
to the user? Something like:

config FORCE_MAX_ZONEORDER
	int
	default "13" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
	default "11"

We can extend it later if people need this but I'm aiming for a single
config on a multitude of boards.

-- 
Catalin
