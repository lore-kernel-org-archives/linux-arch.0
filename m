Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:46969 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751091Ab3EXLNA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 May 2013 07:13:00 -0400
Date: Fri, 24 May 2013 12:11:52 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 01/11] mm: hugetlb: Copy huge_pmd_share from x86 to mm.
Message-ID: <20130524111152.GD18272@arm.com>
References: <1369328878-11706-1-git-send-email-steve.capper@linaro.org>
 <1369328878-11706-2-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369328878-11706-2-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <Will.Deacon@arm.com>, "patches@linaro.org" <patches@linaro.org>
Message-ID: <20130524111152.1COSl4_l6FZAArrOK5dRiwj_juJzHxPTTxqeUoOUxuY@z>

On Thu, May 23, 2013 at 06:07:48PM +0100, Steve Capper wrote:
> Under x86, multiple puds can be made to reference the same bank of
> huge pmds provided that they represent a full PUD_SIZE of shared
> huge memory that is aligned to a PUD_SIZE boundary.
> 
> The code to share pmds does not require any architecture specific
> knowledge other than the fact that pmds can be indexed, thus can
> be beneficial to some other architectures.
> 
> This patch copies the huge pmd sharing (and unsharing) logic from
> x86/ to mm/ and introduces a new config option to activate it:
> CONFIG_ARCH_WANTS_HUGE_PMD_SHARE
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
