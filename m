Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:52029 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752404Ab3EXLWf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 May 2013 07:22:35 -0400
Date: Fri, 24 May 2013 12:21:49 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 07/11] ARM64: mm: Make PAGE_NONE pages read only and
 no-execute.
Message-ID: <20130524112149.GJ18272@arm.com>
References: <1369328878-11706-1-git-send-email-steve.capper@linaro.org>
 <1369328878-11706-8-git-send-email-steve.capper@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369328878-11706-8-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <Will.Deacon@arm.com>, "patches@linaro.org" <patches@linaro.org>
Message-ID: <20130524112149.5rRUjJYPikQg6WAMspMh80liti-8eDQY_izX2rHg0xs@z>

On Thu, May 23, 2013 at 06:07:54PM +0100, Steve Capper wrote:
> If we consider the following code sequence:
> 
> 	my_pte = pte_modify(entry, myprot);
> 	x = pte_write(my_pte);
> 	y = pte_exec(my_pte);
> 
> If myprot comes from a PROT_NONE page, then x and y will both be
> true which is undesireable behaviour.
> 
> This patch sets the no-execute and read-only bits for PAGE_NONE
> such that the code above will return false for both x and y.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
