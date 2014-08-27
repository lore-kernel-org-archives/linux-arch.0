From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATH V2 2/6] arm: mm: Introduce special ptes for LPAE
Date: Wed, 27 Aug 2014 11:46:53 +0100
Message-ID: <20140827104653.GG6968@arm.com>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
 <1408635812-31584-3-git-send-email-steve.capper@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:41655 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932539AbaH0Kr1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Aug 2014 06:47:27 -0400
Content-Disposition: inline
In-Reply-To: <1408635812-31584-3-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Will Deacon <Will.Deacon@arm.com>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dann.frazier@canonical.com" <dann.frazier@canonical.com>, Mark Rutland <Mark.Rutland@arm.com>, "mgorman@suse.de" <mgorman@suse.de>

On Thu, Aug 21, 2014 at 04:43:28PM +0100, Steve Capper wrote:
> We need a mechanism to tag ptes as being special, this indicates that
> no attempt should be made to access the underlying struct page *
> associated with the pte. This is used by the fast_gup when operating on
> ptes as it has no means to access VMAs (that also contain this
> information) locklessly.
> 
> The L_PTE_SPECIAL bit is already allocated for LPAE, this patch modifies
> pte_special and pte_mkspecial to make use of it, and defines
> __HAVE_ARCH_PTE_SPECIAL.
> 
> This patch also excludes special ptes from the icache/dcache sync logic.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
