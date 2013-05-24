Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:58851 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751514Ab3EXLOn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 May 2013 07:14:43 -0400
Date: Fri, 24 May 2013 12:13:59 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 02/11] x86: mm: Remove x86 version of huge_pmd_share.
Message-ID: <20130524111359.GE18272@arm.com>
References: <1369328878-11706-1-git-send-email-steve.capper@linaro.org>
 <1369328878-11706-3-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369328878-11706-3-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <Will.Deacon@arm.com>, "patches@linaro.org" <patches@linaro.org>
Message-ID: <20130524111359.z-0rG5R2hfBKFnm3el3vB6JVQ3ZcrVV2PIbr6t_QPxM@z>

On Thu, May 23, 2013 at 06:07:49PM +0100, Steve Capper wrote:
> The huge_pmd_share code has been copied over to mm/hugetlb.c to
> make it accessible to other architectures.
> 
> Remove the x86 copy of the huge_pmd_share code and enable the
> ARCH_WANT_HUGE_PMD_SHARE config flag. That way we reference the
> general one.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
