From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH v2 0/6] Signal frame expansion support
Date: Thu, 20 Apr 2017 13:45:19 +0100
Message-ID: <20170420124516.GQ3750@e103592.cambridge.arm.com>
References: <1492016239-19511-1-git-send-email-Dave.Martin@arm.com>
 <8760hz47u7.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S945414AbdDTMp2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Apr 2017 08:45:28 -0400
Content-Disposition: inline
In-Reply-To: <8760hz47u7.fsf@concordia.ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>

On Thu, Apr 20, 2017 at 09:49:36PM +1000, Michael Ellerman wrote:
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > (Note: This is an arm64-specific series, but the concepts introduced may
> > be of interest to other arches -- see in particular patch 6.)
> 
> Hi Dave,
> 
> I think we (powerpc) will probably want to use this too.
> 
> I haven't dug into the details yet, I'll try and do that after the 4.12
> merge window.

That would be great, thanks.

Since I've been focusing on arm64 and SVE, there may be generalities
or design issues that I've missed.

Cheers
---Dave
