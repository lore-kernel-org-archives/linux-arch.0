From: Kees Cook <keescook@chromium.org>
Subject: Re: [patch V3 01/13] entry: Provide generic syscall entry
 functionality
Date: Fri, 17 Jul 2020 10:49:13 -0700
Message-ID: <202007171045.FB4A586F1D@keescook>
References: <20200716182208.180916541@linutronix.de>
 <20200716185424.011950288@linutronix.de>
 <202007161336.B993ED938@keescook>
 <87d04vt98w.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87d04vt98w.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 16, 2020 at 11:55:59PM +0200, Thomas Gleixner wrote:
> Kees Cook <keescook@chromium.org> writes:
> > On Thu, Jul 16, 2020 at 08:22:09PM +0200, Thomas Gleixner wrote:
> >> This code is needlessly duplicated and  different in all
> >> architectures.
> >> 
> >> Provide a generic version based on the x86 implementation which has all the
> >> RCU and instrumentation bits right.
> >
> > Ahh! You're reading my mind!
> 
> I told you about that plan at the last conference over a beer :)

Thank you for incepting it in my head, then! ;)

> > [1] https://lore.kernel.org/lkml/20200716193141.4068476-2-krisman@collabora.com/
> 
> Saw that fly by. *shudder*

Aw, it's nice. Better emulation! :)

> 
> >> +/*
> >> + * Define dummy _TIF work flags if not defined by the architecture or for
> >> + * disabled functionality.
> >> + */
> >
> > When I was thinking about this last week I was pondering having a split
> > between the arch-agnositc TIF flags and the arch-specific TIF flags, and
> > that each arch could have a single "there is agnostic work to be done"
> > TIF in their thread_info, and the agnostic flags could live in
> > task_struct or something. Anyway, I'll keep reading...
> 
> That's going to be nasty. We rather go and expand the TIF storage to
> 64bit. And then do the following in a generic header:

I though the point was to make the TIF_WORK check as fast as possible,
even on the 32-bit word systems. I mean it's not a huge performance hit,
but *shrug*

> 
> #ifndef TIF_ARCH_SPECIFIC
> # define TIF_ARCH_SPECIFIC
> #endif
> 
> enum tif_bits {
> 	TIF_NEED_RESCHED = 0,
>         TIF_...,
>         TIF_LAST_GENERIC,
>         TIF_ARCH_SPECIFIC,
> };
>         
> and in the arch specific one:
> 
> #define TIF_ARCH_SPECIFIC	\
> 	TIF_ARCH_1,             \
>         TIF_ARCH_2,
> 
> or something like that.

Okay, yeah, that can work.

> > There's been some recent confusion over "has the syscall changed,
> > or did seccomp request it be skipped?" that was explored in arm64[2]
> > (though I see Will and Keno in CC already). There might need to be a
> > clearer way to distinguish between "wild userspace issued a -1 syscall"
> > and "seccomp or ptrace asked for the syscall to be skipped". The
> > difference is mostly about when ENOSYS gets set, with respect to calls
> > to syscall_set_return_value(), but if the syscall gets changed, the arch
> > may need to recheck the value and consider ENOSYS, etc. IIUC, what Will
> > ended up with[3] was having syscall_trace_enter() return the syscall return
> > value instead of the new syscall.
> 
> I was chatting with Will about that yesterday. IIRC he plans to fix the
> immediate issue on arm64 first and then move arm64 over to the generic
> variant. That's the reason why I reshuffled the patch series so the
> generic parts are first which allows me to provide will a branch with
> just those. If there are any changes needed we can just feed them back
> into that branch and fixup the affected architecture trees.
> 
> IOW, that should not block progress on this stuff.

Ok, great! I just wanted to make sure that didn't surprise anyone. :)

-- 
Kees Cook
