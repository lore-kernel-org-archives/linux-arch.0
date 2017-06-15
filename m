From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 2/5] arm64: signal: Refactor sigcontext parsing in
 rt_sigreturn
Date: Thu, 15 Jun 2017 18:01:30 +0100
Message-ID: <20170615170130.GB17424@e104818-lin.cambridge.arm.com>
References: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
 <1497535442-11586-3-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbdFORBe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Jun 2017 13:01:34 -0400
Content-Disposition: inline
In-Reply-To: <1497535442-11586-3-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Thu, Jun 15, 2017 at 03:03:39PM +0100, Dave P Martin wrote:
> Currently, rt_sigreturn does very limited checking on the
> sigcontext coming from userspace.
> 
> Future additions to the sigcontext data will increase the potential
> for surprises.  Also, it is not clear whether the sigcontext
> extension records are supposed to occur in a particular order.
> 
> To allow the parsing code to be extended more easily, this patch
> factors out the sigcontext parsing into a separate function, and
> adds extra checks to validate the well-formedness of the sigcontext
> structure.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
