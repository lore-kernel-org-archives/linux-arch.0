From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/5] arm64: signal: split frame link record from
 sigcontext structure
Date: Thu, 15 Jun 2017 17:37:47 +0100
Message-ID: <20170615163747.GA17424@e104818-lin.cambridge.arm.com>
References: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
 <1497535442-11586-2-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752094AbdFOQhv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Jun 2017 12:37:51 -0400
Content-Disposition: inline
In-Reply-To: <1497535442-11586-2-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Thu, Jun 15, 2017 at 03:03:38PM +0100, Dave P Martin wrote:
> In order to be able to increase the amount of the data currently
> written to the __reserved[] array in the signal frame, it is
> necessary to overwrite the locations currently occupied by the
> {fp,lr} frame link record pushed at the top of the signal stack.
> 
> In order for this to work, this patch detaches the frame link
> record from struct rt_sigframe and places it separately at the top
> of the signal stack.  This will allow subsequent patches to insert
> data between it and __reserved[].
> 
> This change relies on the non-ABI status of the placement of the
> frame record with respect to struct sigframe: this status is
> undocumented, but the placement is not declared or described in the
> user headers, and known unwinder implementations (libgcc,
> libunwind, gdb) appear not to rely on it.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

I'm fine with this approach:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
