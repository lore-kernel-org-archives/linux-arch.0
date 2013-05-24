Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:46066 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751598Ab3EXLPS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 May 2013 07:15:18 -0400
Date: Fri, 24 May 2013 12:14:33 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 03/11] mm: hugetlb: Copy general hugetlb code from x86
 to mm.
Message-ID: <20130524111433.GF18272@arm.com>
References: <1369328878-11706-1-git-send-email-steve.capper@linaro.org>
 <1369328878-11706-4-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369328878-11706-4-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <Will.Deacon@arm.com>, "patches@linaro.org" <patches@linaro.org>
Message-ID: <20130524111433.YuhuPq970D3GJ8KeVW3NCN8dhJUPL3f_WGvwj_X6IM8@z>

On Thu, May 23, 2013 at 06:07:50PM +0100, Steve Capper wrote:
> The huge_pte_alloc, huge_pte_offset and follow_huge_p[mu]d
> functions in x86/mm/hugetlbpage.c do not rely on any architecture
> specific knowledge other than the fact that pmds and puds can be
> treated as huge ptes.
> 
> To allow other architectures to use this code (and reduce the need
> for code duplication), this patch copies these functions into mm,
> replaces the use of pud_large with pud_huge and provides a config
> flag to activate them:
> CONFIG_ARCH_WANT_GENERAL_HUGETLB
> 
> If CONFIG_ARCH_WANT_HUGE_PMD_SHARE is also active then the
> huge_pmd_share code will be called by huge_pte_alloc (othewise we
> call pmd_alloc and skip the sharing code).
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
