Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:44035 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760988Ab3D3QtA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 30 Apr 2013 12:49:00 -0400
Date: Tue, 30 Apr 2013 17:48:14 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH 3/9] mm: hugetlb: Copy general hugetlb code from
 x86 to mm.
Message-ID: <20130430164814.GK29766@arm.com>
References: <1367339448-21727-1-git-send-email-steve.capper@linaro.org>
 <1367339448-21727-4-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1367339448-21727-4-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <Will.Deacon@arm.com>
Message-ID: <20130430164814.cOBSheVffkGA4zjrAorT6B-ALI5KQsky9pZS4lUmQdo@z>

On Tue, Apr 30, 2013 at 05:30:42PM +0100, Steve Capper wrote:
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 41179b0..e1dc5ae 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
...
> +pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
> +{
> +	pgd_t *pgd;
> +	pud_t *pud;
> +	pmd_t *pmd = NULL;
> +
> +	pgd = pgd_offset(mm, addr);
> +	if (pgd_present(*pgd)) {
> +		pud = pud_offset(pgd, addr);
> +		if (pud_present(*pud)) {
> +			if (pud_large(*pud))

That's more of a question for the x86 guys - can we replace pud_large()
here with pud_huge()? It looks like the former simply checks for present
and huge, so pud_huge() would be enough. This saves an additional
definition.

-- 
Catalin
