Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753852AbdHUN47 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Aug 2017 09:56:59 -0400
Date: Mon, 21 Aug 2017 14:56:54 +0100
From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 06/27] arm64/sve: System register and exception syndrome
 definitions
Message-ID: <20170821135654.GP6321@e103592.cambridge.arm.com>
References: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com>
 <1502280338-23002-7-git-send-email-Dave.Martin@arm.com>
 <87a82t5kos.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a82t5kos.fsf@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Message-ID: <20170821135654.KIoAQDHMH83TEfYZOVG9hkSu5W_anUddCvU9Gul8ltw@z>

On Mon, Aug 21, 2017 at 10:33:55AM +0100, Alex Bennée wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > The SVE architecture adds some system registers, ID register fields
> > and a dedicated ESR exception class.
> >
> > This patch adds the appropriate definitions that will be needed by
> > the kernel.
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm64/include/asm/esr.h     |  3 ++-
> >  arch/arm64/include/asm/kvm_arm.h |  1 +
> >  arch/arm64/include/asm/sysreg.h  | 16 ++++++++++++++++
> >  arch/arm64/kernel/traps.c        |  1 +
> >  4 files changed, 20 insertions(+), 1 deletion(-)

[...]

> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index 248339e..2d259e8 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h

[...]

> > +#define SYS_ZCR_EL1			sys_reg(3, 0, 1, 2, 0)
> > +
> 
> I'll have to take these on trust. They are mentioned in both the ARM ARM
> and the SVE supplement but I can't see any actual definitions of them.

[I note from subsequent replies you've now found this in the
accompanying HTML]

[...]

> > +#define CPACR_EL1_ZEN_EL1EN	(1 << 16)
> > +#define CPACR_EL1_ZEN_EL0EN	(1 << 17)
> > +#define CPACR_EL1_ZEN		(CPACR_EL1_ZEN_EL1EN |
> > CPACR_EL1_ZEN_EL0EN)
> 
> This is a little weird as it is a 2 bit field in which 00 and 11 are not
> simply the sum of their bits. If the code wrote CPACR_EL1_ZEN_EL0EN |
> CPACR_EL1_ZEN_EL1EN to the CPACR_EL1 you wouldn't get the expected behaviour.

This seemed natural-ish if you believe that disabling at EL1 implies
disabling at EL0.  This is consistent with the way the traps at EL2/3
work, and lack of this property would be a sort of privilege inversion.

The meanings of the bits are not orthogonal, but it's still useful to be
able to twiddle EL0EN by itself when EL1EN is set (since we wan't to
control access for EL0 but leave EL1 access enabled).

Maybe comments would be sufficient:

#define CPACR_EL1_ZEN_EL1EN ... /* enable EL1 access */
#define CPACR_EL1_ZEN_EL0EN ... /* enable EL0 access, if EL1EN is also set */

I'm not sure how to make the names both reasonably terse and self-
escribing, but I'm open to ideas.

Cheers
---Dave
