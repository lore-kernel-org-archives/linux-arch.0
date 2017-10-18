Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36540 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759222AbdJRJcJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Oct 2017 05:32:09 -0400
Date: Wed, 18 Oct 2017 10:32:03 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 26/28] arm64/sve: Add documentation
Message-ID: <20171018093203.xp5tro636chgaiuq@armageddon.cambridge.arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-27-git-send-email-Dave.Martin@arm.com>
 <20171013142421.j32jzisukewxtosx@armageddon.cambridge.arm.com>
 <20171013171758.GO19485@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171013171758.GO19485@e103592.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, Will Deacon <will.deacon@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Alan Hayward <alan.hayward@arm.com>, linux-api@vger.kernel.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Message-ID: <20171018093203.OFDPS1XCOAG8FF9v2rul_AndnHF-3uGtyP_2nn23YNY@z>

On Fri, Oct 13, 2017 at 06:17:59PM +0100, Dave P Martin wrote:
> On Fri, Oct 13, 2017 at 03:24:21PM +0100, Catalin Marinas wrote:
> > On Tue, Oct 10, 2017 at 07:38:43PM +0100, Dave P Martin wrote:
> > > +* If the SVE context is too big to fit in sigcontext.__reserved[], then extra
> > > +  space is allocated on the stack, an extra_context record is written in
> > > +  __reserved[] referencing this space.  sve_context is then written in the
> > > +  extra space.  Refer to [1] for further details about this mechanism.
> > 
> > Does this document require that the user stack is sufficiently large or
> > should we cap the vector length (prior to the last two RFC patches)?
> 
> We don't know how much free stack space there actually is until the
> signal is delivered.
[...]
> Possibly sigaltstack() should fail with ENOMEM if ss_size is too small
> for the maximum VL supported by the system, but strictly speaking that
> violates POSIX if ss_size >= MINSIGSTKSZ.

We also don't know whether the application is going to use SVE or not,
so MINSIGSTKSZ could be just fine. I don't have a better idea here
without the last two RFC patches. So just ignore my comment.

> > > +5.  Signal return
> > > +-----------------
> > > +
> > > +When returning from a signal handler:
> > > +
> > > +* If there is no sve_context record in the signal frame, or if the record is
> > > +  present but contains no register data as desribed in the previous section,
> > > +  then the SVE registers/bits become non-live and take unspecified values.
> > > +
> > > +* If sve_context is present in the signal frame and contains full register
> > > +  data, the SVE registers become live and are populated with the specified
> > > +  data.  However, for backward compatibility reasons, bits [127:0] of Z0..Z31
> > > +  are always restored from the corresponding members of fpsimd_context.vregs[]
> > > +  and not from sve_context.  The remaining bits are restored from sve_context.
> > > +
> > > +* Inclusion of fpsimd_context in the signal frame remains mandatory,
> > > +  irrespective of whether sve_context is present or not.
> > 
> > Could we relax this? I'm not sure it's worth it.
> 
> It would be cleaner, but I think it's an ABI break.  Consider a non-SVE
> program that gets linked (perhaps dynamically) against a library variant
> that happens to use SVE:

I agree that in general the kernel always needs to provide user space
with FPSIMD_MAGIC. I was wondering whether on sigreturn the kernel may
choose not to enforce this. But I'm not sure we have a scenario where it
actually matters (IIUC set/getcontext is done in user space anyway).

-- 
Catalin
