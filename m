Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751475AbdJ3QR1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Oct 2017 12:17:27 -0400
Date: Mon, 30 Oct 2017 16:17:22 +0000
From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v4 20/28] arm64/sve: Add prctl controls for userspace
 vector length management
Message-ID: <20171030161709.GJ19485@e103592.cambridge.arm.com>
References: <1509101470-7881-1-git-send-email-Dave.Martin@arm.com>
 <1509101470-7881-21-git-send-email-Dave.Martin@arm.com>
 <87r2toiikt.fsf@linaro.org>
 <20171028160506.GI19485@e103592.cambridge.arm.com>
 <87fua07gyq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fua07gyq.fsf@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: linux-arch@vger.kernel.org, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Message-ID: <20171030161722.i7Op4c0jCcud1sRdTNtqfOjLsCQkjQz7TQhvvK8bSbU@z>

On Mon, Oct 30, 2017 at 04:12:13PM +0000, Alex Bennée wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > On Fri, Oct 27, 2017 at 06:52:50PM +0100, Alex Bennée wrote:
> >>
> >> Dave Martin <Dave.Martin@arm.com> writes:
> >>
> >> > This patch adds two arm64-specific prctls, to permit userspace to
> >> > control its vector length:
> >> >
> >> >  * PR_SVE_SET_VL: set the thread's SVE vector length and vector
> >> >    length inheritance mode.
> >> >
> >> >  * PR_SVE_GET_VL: get the same information.
> >> >
> >> > Although these prctls resemble instruction set features in the SVE
> >> > architecture, they provide additional control: the vector length
> >> > inheritance mode is Linux-specific and nothing to do with the
> >> > architecture, and the architecture does not permit EL0 to set its
> >> > own vector length directly.  Both can be used in portable tools
> >> > without requiring the use of SVE instructions.
> >> >
> >> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> >> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> >> > Cc: Alex Bennée <alex.bennee@linaro.org>
> >>
> >> FYI there is a minor conflict applying this on current master.
> >
> > There are some trivial conflicts with one or two patches that already
> > went into arm64/for-next/core, so I based on that for this posting, not
> > torvalds/master.
> >
> > There's a note in the cover letter giving the precise commit I based
> > on, though the branch doesn't seem to have moved yet since I posted.
> 
> Ahh probably those. It was only a few header file shuffles. I was
> rushing to apply before my flight back I failed to note the change in
> base commit.
> 
> >
> > Otherwise, I don't see any conflict -- can you give details?
> 
> Only that #endif _ASM_ had been dropped from the header file.

The #ifndef __ASSEMBLY__ ... #endif is added by another in-flight patch,
so it depends on whether that patch (from arm64/for-next/core) is already
applied.

Cheers
---Dave
