From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/5] arm64: signal: factor frame layout and population
 into separate passes
Date: Thu, 15 Jun 2017 18:20:15 +0100
Message-ID: <20170615172015.GC17424@e104818-lin.cambridge.arm.com>
References: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
 <1497535442-11586-4-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751829AbdFORUT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Jun 2017 13:20:19 -0400
Content-Disposition: inline
In-Reply-To: <1497535442-11586-4-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Thu, Jun 15, 2017 at 03:03:40PM +0100, Dave P Martin wrote:
> In preparation for expanding the signal frame, this patch refactors
> the signal frame setup code in setup_sigframe() into two separate
> passes.
> 
> The first pass, setup_sigframe_layout(), determines the size of the
> signal frame and its internal layout, including the presence and
> location of optional records.  The resulting knowledge is used to
> allocate and locate the user stack space required for the signal
> frame and to determine which optional records to include.
> 
> The second pass, setup_sigframe(), is called once the stack frame
> is allocated in order to populate it with the necessary context
> information.
> 
> As a result of these changes, it becomes more natural to represent
> locations in the signal frame by a base pointer and an offset,
> since the absolute address of each location is not known during the
> layout pass.  To be more consistent with this logic,
> parse_user_sigframe() is refactored to describe signal frame
> locations in a similar way.
> 
> This change has no effect on the signal ABI, but will make it
> easier to expand the signal frame in future patches.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
