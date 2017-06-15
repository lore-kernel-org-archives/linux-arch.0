From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 4/5] arm64: signal: factor out signal frame record
 allocation
Date: Thu, 15 Jun 2017 18:33:14 +0100
Message-ID: <20170615173313.GD17424@e104818-lin.cambridge.arm.com>
References: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
 <1497535442-11586-5-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbdFORdR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Jun 2017 13:33:17 -0400
Content-Disposition: inline
In-Reply-To: <1497535442-11586-5-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Thu, Jun 15, 2017 at 03:03:41PM +0100, Dave P Martin wrote:
> This patch factors out the allocator for signal frame optional
> records into a separate function, to ensure consistency and
> facilitate later expansion.
> 
> No overrun checking is currently done, because the allocation is in
> user memory and anyway the kernel never tries to allocate enough
> space in the signal frame yet for an overrun to occur.  This
> behaviour will be refined in future patches.
> 
> The approach taken in this patch to allocation of the terminator
> record is not very clean: this will also be replaced in subsequent
> patches.
> 
> For future extension, a comment is added in sigcontext.h
> documenting the current static allocations in __reserved[].  This
> will be important for determining under what circumstances
> userspace may or may not see an expanded signal frame.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
