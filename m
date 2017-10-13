Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752752AbdJMRfG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Oct 2017 13:35:06 -0400
Date: Fri, 13 Oct 2017 18:35:01 +0100
From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v3 26/28] arm64/sve: Add documentation
Message-ID: <20171013173500.GP19485@e103592.cambridge.arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-27-git-send-email-Dave.Martin@arm.com>
 <20171013142421.j32jzisukewxtosx@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171013142421.j32jzisukewxtosx@armageddon.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, Will Deacon <will.deacon@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Alan Hayward <alan.hayward@arm.com>, linux-api@vger.kernel.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Message-ID: <20171013173501.2j_vDvCxbblmgVp8d65FQNWxRaUp-606a3FLsOafRmU@z>

On Fri, Oct 13, 2017 at 03:24:21PM +0100, Catalin Marinas wrote:
> On Tue, Oct 10, 2017 at 07:38:43PM +0100, Dave P Martin wrote:

[...]

> > +* If the SVE context is too big to fit in sigcontext.__reserved[], then extra
> > +  space is allocated on the stack, an extra_context record is written in
> > +  __reserved[] referencing this space.  sve_context is then written in the
> > +  extra space.  Refer to [1] for further details about this mechanism.
> 
> Does this document require that the user stack is sufficiently large or
> should we cap the vector length (prior to the last two RFC patches)?

Oh, I think I missed your point here.

I don't think it's worth capping the vector length beyond what the
series alread does: the last two patches provide a way to find out how
big the signal frame could be, but software still needs porting either
way if it enables large vectors via prctl or ptrace.

Conversely, software basing its stack allocations on SIGSTKSZ (16K) will
probably get away with it: this seems to be the common choice when
allocating stacks.  Apart from models, we're not likely to see SVE
implementations with huge vector lengths for a while yet.


In any case, /proc/sys/abi/sve_default_vector_length proves a
discretionary global clamp that can be set by the distro or admin.  This
will prevent programs from seeing large frames unless the VL is set
explicitly to something > 64 bytes via prctl/ptrace (which current
software won't do).

[...]

Cheers
---Dave
