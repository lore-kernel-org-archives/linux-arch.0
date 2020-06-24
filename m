From: Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 05/22] kbuild: lto: postpone objtool
Date: Wed, 24 Jun 2020 14:49:25 -0700
Message-ID: <20200624214925.GB120457@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-6-samitolvanen@google.com>
 <20200624211908.GT4817@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200624211908.GT4817@hirez.programming.kicks-ass.net>
Sender: linux-kbuild-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 24, 2020 at 11:19:08PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 24, 2020 at 01:31:43PM -0700, Sami Tolvanen wrote:
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 30827f82ad62..12b115152532 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -120,7 +120,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >  /* Annotate a C jump table to allow objtool to follow the code flow */
> >  #define __annotate_jump_table __section(.rodata..c_jump_table)
> >  
> > -#ifdef CONFIG_DEBUG_ENTRY
> > +#if defined(CONFIG_DEBUG_ENTRY) || defined(CONFIG_LTO_CLANG)
> >  /* Begin/end of an instrumentation safe region */
> >  #define instrumentation_begin() ({					\
> >  	asm volatile("%c0:\n\t"						\
> 
> Why would you be doing noinstr validation for lto builds? That doesn't
> make sense.

This is just to avoid a ton of noinstr warnings when we run objtool on
vmlinux.o, but I'm also fine with skipping noinstr validation with LTO.

> > +ifdef CONFIG_STACK_VALIDATION
> > +ifneq ($(SKIP_STACK_VALIDATION),1)
> > +cmd_ld_ko_o +=								\
> > +	$(objtree)/tools/objtool/objtool				\
> > +		$(if $(CONFIG_UNWINDER_ORC),orc generate,check)		\
> > +		--module						\
> > +		$(if $(CONFIG_FRAME_POINTER),,--no-fp)			\
> > +		$(if $(CONFIG_GCOV_KERNEL),--no-unreachable,)		\
> > +		$(if $(CONFIG_RETPOLINE),--retpoline,)			\
> > +		$(if $(CONFIG_X86_SMAP),--uaccess,)			\
> > +		$(@:.ko=$(prelink-ext).o);
> > +
> > +endif # SKIP_STACK_VALIDATION
> > +endif # CONFIG_STACK_VALIDATION
> 
> What about the objtool invocation from link-vmlinux.sh ?

What about it? The existing objtool_link invocation in link-vmlinux.sh
works fine for our purposes as well.

Sami
