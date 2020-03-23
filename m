From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v10 00/13] arm64: Branch Target Identification support
Date: Mon, 23 Mar 2020 14:55:46 +0000
Message-ID: <20200323145546.GB3959@C02TD0UTHF1T.local>
References: <20200316165055.31179-1-broonie@kernel.org>
 <20200320173945.GC27072@arm.com>
 <20200323122143.GB4892@mbp>
 <20200323132412.GD4948@sirena.org.uk>
 <20200323135722.GA3959@C02TD0UTHF1T.local>
 <20200323143954.GC4892@mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200323143954.GC4892@mbp>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Brown <broonie@kernel.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Will Deacon <will@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>Florian Weimer <f>
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 23, 2020 at 02:39:55PM +0000, Catalin Marinas wrote:
> On Mon, Mar 23, 2020 at 01:57:22PM +0000, Mark Rutland wrote:
> > On Mon, Mar 23, 2020 at 01:24:12PM +0000, Mark Brown wrote:
> > > On Mon, Mar 23, 2020 at 12:21:44PM +0000, Catalin Marinas wrote:
> > > > On Fri, Mar 20, 2020 at 05:39:46PM +0000, Szabolcs Nagy wrote:
> > > 
> > > > +int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
> > > > +                        bool has_interp, bool is_interp)
> > > > +{
> > > > +       if (is_interp != has_interp)
> > > > +               return prot;
> > > > +
> > > > +       if (!(state->flags & ARM64_ELF_BTI))
> > > > +               return prot;
> > > > +
> > > > +       if (prot & PROT_EXEC)
> > > > +               prot |= PROT_BTI;
> > > > +
> > > > +       return prot;
> > > > +}
> > > 
> > > > At a quick look, for dynamic binaries we have has_interp == true and
> > > > is_interp == false. I don't know why but, either way, the above code
> > > > needs a comment with some justification.
> > > 
> > > I don't really know for certain either, I inherited this code as is with
> > > the understanding that this was all agreed with the toolchain and libc
> > > people - the actual discussion that lead to the decisions being made
> > > happened before I was involved.  My understanding is that the idea was
> > > that the dynamic linker would be responsible for mapping everything in
> > > dynamic applications other than itself but other than consistency I
> > > don't know why.  I guess it defers more decision making to userspace but
> > > I'm having a hard time thinking of sensible cases where one might wish
> > > to make a decision other than enabling PROT_BTI.
> > 
> > My understanding was this had been agreed with the toolchain folk a
> > while back -- anything static loaded by the kernel (i.e. a static
> > executable or the dynamic linker) would get GP set. In other cases the
> > linker will mess with the permissions on the pages anyhow, and needs to
> > be aware of BTI in order to do the right thing, so it was better to
> > leave it to userspace consistently (e.g. as that had the least risk of
> > subtle changes in behaviour leading to ABI difficulties).
> 
> So this means that the interpreter will have to mprotect(PROT_BTI) the
> text section of the primary executable.

Yes, but after fixing up any relocations in that section it's going to
have to call mprotect() on it anyhow (e.g. in order to make it
read-only), and in doing so would throw away BTI unless it was BTI
aware.

> > I think it would be best to document the current behaviour, as it's a
> > simple ABI that we can guarantee, and the dynamic linker will have to be
> > aware of BTI in order to do the right thing anyhow.
> 
> That's a valid point. If we have an old dynamic linker and the kernel
> enabled BTI automatically for the main executable, could things go wrong
> (e.g. does the PLT need to be BTI-aware)?

I believe that a PLT in an unguarded page needs no special treatment. A
PLT within a guarded page needs to be built specially for BTI.

Thanks,
Mark.
