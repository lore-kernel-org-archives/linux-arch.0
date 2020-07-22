From: peterz@infradead.org
Subject: Re: [patch V4 02/15] entry: Provide generic syscall entry
 functionality
Date: Wed, 22 Jul 2020 09:54:55 +0200
Message-ID: <20200722075455.GQ119549@hirez.programming.kicks-ass.net>
References: <20200721105706.030914876@linutronix.de>
 <20200721110808.455350746@linutronix.de>
 <202007211426.B40A7A7BD@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <202007211426.B40A7A7BD@keescook>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 21, 2020 at 02:38:16PM -0700, Kees Cook wrote:
> One thing I noticed while doing syscall entry timings for the kernel
> stack base offset randomization was that the stack protector was being
> needlessly enabled in certain paths (seccomp, audit) due to seeing a
> register array being declared on the stack. As part of that series I
> suggested down-grading the stack protector. Since then, Peter's changes
> entirely disabled the stack protector on the entry code, which I
> grudgingly accept (I'd rather have a way to mark a variable as "ignore
> this for stack protector detection", but ... there isn't, so fine.)

I don't think I'd like to have that per variable, but a function
attribute to disable stack protector would be awesome, except our
GCC-besties forgot to create that function attribute :-(

If/when we get such a function attribute, we can add it to noinstr.

Also see this here:

  https://lkml.kernel.org/r/20200314164451.346497-1-slyfox@gentoo.org
