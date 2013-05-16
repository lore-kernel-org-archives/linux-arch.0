Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:47914 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751167Ab3EPOkI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 May 2013 10:40:08 -0400
Date: Thu, 16 May 2013 15:32:36 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH v2 09/11] ARM64: mm: HugeTLB support.
Message-ID: <20130516143236.GD18308@arm.com>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-10-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1368006763-30774-10-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <Will.Deacon@arm.com>, "patches@linaro.org" <patches@linaro.org>
Message-ID: <20130516143236.cPc3HY_to_urVuD7DdcLx8f2-1qD_spzvo9C2JW-b6Y@z>

On Wed, May 08, 2013 at 10:52:41AM +0100, Steve Capper wrote:
> --- /dev/null
> +++ b/arch/arm64/include/asm/hugetlb.h
...
> +static inline int pud_large(pud_t pud)
> +{
> +	return !(pud_val(pud) & PUD_TABLE_BIT);
> +}

I already commented on this - do we really need pud_large() which is
the same as pud_huge()? It's only defined on x86 and can be safely
replaced with pud_huge().

> --- /dev/null
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -0,0 +1,70 @@
...
> +int pmd_huge(pmd_t pmd)
> +{
> +	return !(pmd_val(pmd) & PMD_TABLE_BIT);
> +}
> +
> +int pud_huge(pud_t pud)
> +{
> +	return !(pud_val(pud) & PUD_TABLE_BIT);
> +}

You could even go further and make pud/pmd_huge static inline functions
for slightly better efficiency (needs changing in the linux/hugetlb.h
header).

-- 
Catalin
