Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751068AbeCIO0B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Mar 2018 09:26:01 -0500
Date: Fri, 9 Mar 2018 14:25:57 +0000
From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v2 2/3] arm64: fpsimd: Fix bad si_code for undiagnosed
 SIGFPE
Message-ID: <20180309142557.GT32331@e103592.cambridge.arm.com>
References: <1519926248-12591-1-git-send-email-Dave.Martin@arm.com>
 <1519926248-12591-3-git-send-email-Dave.Martin@arm.com>
 <20180308171153.GD14918@arm.com>
 <87o9jymbsj.fsf@xmission.com>
 <20180309131017.GB20370@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309131017.GB20370@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>
Message-ID: <20180309142557.p0Y8xxuI0d1xvqRLt-4F1INs5Hsk_EuBu1URIYN7J7M@z>

On Fri, Mar 09, 2018 at 01:10:18PM +0000, Will Deacon wrote:
> Hi Eric,
> 
> On Thu, Mar 08, 2018 at 04:40:12PM -0600, Eric W. Biederman wrote:
> > Will Deacon <will.deacon@arm.com> writes:
> > 
> > > On Thu, Mar 01, 2018 at 05:44:07PM +0000, Dave Martin wrote:
> > >> Currently a SIGFPE delivered in response to a floating-point
> > >> exception trap may have si_code set to 0 on arm64.  As reported by
> > >> Eric, this is a bad idea since this is the value of SI_USER -- yet
> > >> this signal is definitely not the result of kill(2), tgkill(2) etc.
> > >> and si_uid and si_pid make limited sense whereas we do want to
> > >> yield a value for si_addr (which doesn't exist for SI_USER).
> > >
> > > [...]
> > >
> > >> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > >> index e7226c4..9040038 100644
> > >> --- a/arch/arm64/kernel/fpsimd.c
> > >> +++ b/arch/arm64/kernel/fpsimd.c
> > >> @@ -39,6 +39,7 @@
> > >>  #include <linux/slab.h>
> > >>  #include <linux/sysctl.h>
> > >>  
> > >> +#include <asm/esr.h>
> > >>  #include <asm/fpsimd.h>
> > >>  #include <asm/cputype.h>
> > >>  #include <asm/simd.h>
> > >> @@ -867,18 +868,20 @@ asmlinkage void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
> > >>  asmlinkage void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
> > >>  {
> > >>  	siginfo_t info;
> > >> -	unsigned int si_code = FPE_FIXME;
> > >> -
> > >> -	if (esr & FPEXC_IOF)
> > >> -		si_code = FPE_FLTINV;
> > >> -	else if (esr & FPEXC_DZF)
> > >> -		si_code = FPE_FLTDIV;
> > >> -	else if (esr & FPEXC_OFF)
> > >> -		si_code = FPE_FLTOVF;
> > >> -	else if (esr & FPEXC_UFF)
> > >> -		si_code = FPE_FLTUND;
> > >> -	else if (esr & FPEXC_IXF)
> > >> -		si_code = FPE_FLTRES;
> > >> +	unsigned int si_code = FPE_FLTUNK;
> > >
> > > Happy to take this patch once the dependency on FPE_FLTUNK in core code is
> > > resolved.
> > 
> > Would it help for me to take the FPE_FLTUNK patch into my siginfo-next
> > branch?   So that there is a common branch with the code so we don't
> > need to worry about conflicts.  If so I will look at that on Monday.
> 
> Yes please, that would be helpful actually. I can then pull that into
> arm64 if you give me a stable branch or tag. Alternatively, I can define
> FPE_FLTUNK locally and remove it at -rc1.

OK Eric, let me know if you need me to rebase anything for the first 2
patches.

Cheers
---Dave
