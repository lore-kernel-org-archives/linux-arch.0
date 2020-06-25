From: Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 05/22] kbuild: lto: postpone objtool
Date: Thu, 25 Jun 2020 12:32:17 -0700
Message-ID: <20200625193217.GA59566@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-6-samitolvanen@google.com>
 <20200624211908.GT4817@hirez.programming.kicks-ass.net>
 <20200624214925.GB120457@google.com>
 <20200625074716.GX4817@hirez.programming.kicks-ass.net>
 <20200625162226.GC173089@google.com>
 <20200625183351.GH4800@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403781AbgFYTcY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jun 2020 15:32:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4672C08C5C1
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 12:32:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d12so3264321ply.1
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 12:32:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200625183351.GH4800@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org

On Thu, Jun 25, 2020 at 08:33:51PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 25, 2020 at 09:22:26AM -0700, Sami Tolvanen wrote:
> > On Thu, Jun 25, 2020 at 09:47:16AM +0200, Peter Zijlstra wrote:
> 
> > > Right, then we need to make --no-vmlinux work properly when
> > > !DEBUG_ENTRY, which I think might be buggered due to us overriding the
> > > argument when the objname ends with "vmlinux.o".
> > 
> > Right. Can we just remove that and  pass --vmlinux to objtool in
> > link-vmlinux.sh, or is the override necessary somewhere else?
> 
> Think we can remove it; it was just convenient when running manually.

Great, I'll change this in v2.

> > > > > > +ifdef CONFIG_STACK_VALIDATION
> > > > > > +ifneq ($(SKIP_STACK_VALIDATION),1)
> > > > > > +cmd_ld_ko_o +=								\
> > > > > > +	$(objtree)/tools/objtool/objtool				\
> > > > > > +		$(if $(CONFIG_UNWINDER_ORC),orc generate,check)		\
> > > > > > +		--module						\
> > > > > > +		$(if $(CONFIG_FRAME_POINTER),,--no-fp)			\
> > > > > > +		$(if $(CONFIG_GCOV_KERNEL),--no-unreachable,)		\
> > > > > > +		$(if $(CONFIG_RETPOLINE),--retpoline,)			\
> > > > > > +		$(if $(CONFIG_X86_SMAP),--uaccess,)			\
> > > > > > +		$(@:.ko=$(prelink-ext).o);
> > > > > > +
> > > > > > +endif # SKIP_STACK_VALIDATION
> > > > > > +endif # CONFIG_STACK_VALIDATION
> > > > > 
> > > > > What about the objtool invocation from link-vmlinux.sh ?
> > > > 
> > > > What about it? The existing objtool_link invocation in link-vmlinux.sh
> > > > works fine for our purposes as well.
> > > 
> > > Well, I was wondering why you're adding yet another objtool invocation
> > > while we already have one.
> > 
> > Because we can't run objtool until we have compiled bitcode to native
> > code, so for modules, we're need another invocation after everything has
> > been compiled.
> 
> Well, that I understand, my question was why we need one in
> scripts/link-vmlinux.sh and an additional one. I think we're just
> talking past one another and agree we only need one.

We need just one for vmlinux.o, but this rule adds an objtool invocation
for kernel modules, which we also couldn't check earlier. We link all
the bitcode for modules into <module>.lto.o and run modpost and objtool
on that before building the final .ko.

Sami
