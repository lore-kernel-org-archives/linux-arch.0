Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:48649 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751337Ab3EXLPp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 May 2013 07:15:45 -0400
Date: Fri, 24 May 2013 12:14:59 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 04/11] x86: mm: Remove general hugetlb code from x86.
Message-ID: <20130524111459.GG18272@arm.com>
References: <1369328878-11706-1-git-send-email-steve.capper@linaro.org>
 <1369328878-11706-5-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369328878-11706-5-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <Will.Deacon@arm.com>, "patches@linaro.org" <patches@linaro.org>
Message-ID: <20130524111459.u1LCqLkCT8t4z13FlZD-DWvO5ZA32RF9taWPHQld0Ng@z>

On Thu, May 23, 2013 at 06:07:51PM +0100, Steve Capper wrote:
> huge_pte_alloc, huge_pte_offset and follow_huge_p[mu]d have
> already been copied over to mm.
> 
> This patch removes the x86 copies of these functions and activates
> the general ones by enabling:
> CONFIG_ARCH_WANT_GENERAL_HUGETLB
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
