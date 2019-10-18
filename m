From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 11/12] arm64: BTI: Reset BTYPE when skipping emulated
 instructions
Date: Fri, 18 Oct 2019 12:04:29 +0100
Message-ID: <20191018110428.GA27759@lakrids.cambridge.arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-12-git-send-email-Dave.Martin@arm.com>
 <20191011142157.GC33537@lakrids.cambridge.arm.com>
 <20191011144743.GJ27757@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191011144743.GJ27757@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Andrew Jones <drjones@redhat.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org, Sudakshina Das <sudi.das@arm.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 11, 2019 at 03:47:43PM +0100, Dave Martin wrote:
> On Fri, Oct 11, 2019 at 03:21:58PM +0100, Mark Rutland wrote:
> > On Thu, Oct 10, 2019 at 07:44:39PM +0100, Dave Martin wrote:
> > > Since normal execution of any non-branch instruction resets the
> > > PSTATE BTYPE field to 0, so do the same thing when emulating a
> > > trapped instruction.
> > > 
> > > Branches don't trap directly, so we should never need to assign a
> > > non-zero value to BTYPE here.
> > > 
> > > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > > ---
> > >  arch/arm64/kernel/traps.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > > index 3af2768..4d8ce50 100644
> > > --- a/arch/arm64/kernel/traps.c
> > > +++ b/arch/arm64/kernel/traps.c
> > > @@ -331,6 +331,8 @@ void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
> > >  
> > >  	if (regs->pstate & PSR_MODE32_BIT)
> > >  		advance_itstate(regs);
> > > +	else
> > > +		regs->pstate &= ~(u64)PSR_BTYPE_MASK;
> > 
> > This looks good to me, with one nit below.
> > 
> > We don't (currently) need the u64 cast here, and it's inconsistent with
> > what we do elsewhere. If the upper 32-bit of pstate get allocated, we'll
> > need to fix up all the other masking we do:
> 
> Huh, looks like I missed that.  Dang.  Will fix.
> 
> > [mark@lakrids:~/src/linux]% git grep 'pstate &= ~'
> > arch/arm64/kernel/armv8_deprecated.c:           regs->pstate &= ~PSR_AA32_E_BIT;
> > arch/arm64/kernel/cpufeature.c:         regs->pstate &= ~PSR_SSBS_BIT;
> > arch/arm64/kernel/debug-monitors.c:     regs->pstate &= ~DBG_SPSR_SS;
> > arch/arm64/kernel/insn.c:       pstate &= ~(pstate >> 1);       /* PSR_C_BIT &= ~PSR_Z_BIT */
> > arch/arm64/kernel/insn.c:       pstate &= ~(pstate >> 1);       /* PSR_C_BIT &= ~PSR_Z_BIT */
> > arch/arm64/kernel/probes/kprobes.c:     regs->pstate &= ~PSR_D_BIT;
> > arch/arm64/kernel/probes/kprobes.c:     regs->pstate &= ~DAIF_MASK;
> > arch/arm64/kernel/ptrace.c:     regs->pstate &= ~SPSR_EL1_AARCH32_RES0_BITS;
> > arch/arm64/kernel/ptrace.c:                     regs->pstate &= ~PSR_AA32_E_BIT;
> > arch/arm64/kernel/ptrace.c:     regs->pstate &= ~SPSR_EL1_AARCH64_RES0_BITS;
> > arch/arm64/kernel/ptrace.c:             regs->pstate &= ~DBG_SPSR_SS;
> > arch/arm64/kernel/ssbd.c:       task_pt_regs(task)->pstate &= ~val;
> > arch/arm64/kernel/traps.c:      regs->pstate &= ~PSR_AA32_IT_MASK;
> > 
> > ... and at that point I'd suggest we should just ensure the bit
> > definitions are all defined as unsigned long in the first place since
> > adding casts to each use is error-prone.
> 
> Are we concerned about changing the types of UAPI #defines?  That can
> cause subtle and unexpected breakage, especially when the signedness
> of a #define changes.
> 
> Ideally, we'd just change all these to 1UL << n.

I agree that's the ideal -- I don't know how concerned we are w.r.t. the
UAPI headers, I'm afraid.

Thanks,
Mark.
