From: Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 05/22] kbuild: lto: postpone objtool
Date: Thu, 25 Jun 2020 09:22:26 -0700
Message-ID: <20200625162226.GC173089@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-6-samitolvanen@google.com>
 <20200624211908.GT4817@hirez.programming.kicks-ass.net>
 <20200624214925.GB120457@google.com>
 <20200625074716.GX4817@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389522AbgFYQWe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jun 2020 12:22:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDEDC08C5C1
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 09:22:34 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so547406pgf.0
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 09:22:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200625074716.GX4817@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org

On Thu, Jun 25, 2020 at 09:47:16AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 24, 2020 at 02:49:25PM -0700, Sami Tolvanen wrote:
> > On Wed, Jun 24, 2020 at 11:19:08PM +0200, Peter Zijlstra wrote:
> > > On Wed, Jun 24, 2020 at 01:31:43PM -0700, Sami Tolvanen wrote:
> > > > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > > > index 30827f82ad62..12b115152532 100644
> > > > --- a/include/linux/compiler.h
> > > > +++ b/include/linux/compiler.h
> > > > @@ -120,7 +120,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> > > >  /* Annotate a C jump table to allow objtool to follow the code flow */
> > > >  #define __annotate_jump_table __section(.rodata..c_jump_table)
> > > >  
> > > > -#ifdef CONFIG_DEBUG_ENTRY
> > > > +#if defined(CONFIG_DEBUG_ENTRY) || defined(CONFIG_LTO_CLANG)
> > > >  /* Begin/end of an instrumentation safe region */
> > > >  #define instrumentation_begin() ({					\
> > > >  	asm volatile("%c0:\n\t"						\
> > > 
> > > Why would you be doing noinstr validation for lto builds? That doesn't
> > > make sense.
> > 
> > This is just to avoid a ton of noinstr warnings when we run objtool on
> > vmlinux.o, but I'm also fine with skipping noinstr validation with LTO.
> 
> Right, then we need to make --no-vmlinux work properly when
> !DEBUG_ENTRY, which I think might be buggered due to us overriding the
> argument when the objname ends with "vmlinux.o".

Right. Can we just remove that and  pass --vmlinux to objtool in
link-vmlinux.sh, or is the override necessary somewhere else?

> > > > +ifdef CONFIG_STACK_VALIDATION
> > > > +ifneq ($(SKIP_STACK_VALIDATION),1)
> > > > +cmd_ld_ko_o +=								\
> > > > +	$(objtree)/tools/objtool/objtool				\
> > > > +		$(if $(CONFIG_UNWINDER_ORC),orc generate,check)		\
> > > > +		--module						\
> > > > +		$(if $(CONFIG_FRAME_POINTER),,--no-fp)			\
> > > > +		$(if $(CONFIG_GCOV_KERNEL),--no-unreachable,)		\
> > > > +		$(if $(CONFIG_RETPOLINE),--retpoline,)			\
> > > > +		$(if $(CONFIG_X86_SMAP),--uaccess,)			\
> > > > +		$(@:.ko=$(prelink-ext).o);
> > > > +
> > > > +endif # SKIP_STACK_VALIDATION
> > > > +endif # CONFIG_STACK_VALIDATION
> > > 
> > > What about the objtool invocation from link-vmlinux.sh ?
> > 
> > What about it? The existing objtool_link invocation in link-vmlinux.sh
> > works fine for our purposes as well.
> 
> Well, I was wondering why you're adding yet another objtool invocation
> while we already have one.

Because we can't run objtool until we have compiled bitcode to native
code, so for modules, we're need another invocation after everything has
been compiled.

Sami
