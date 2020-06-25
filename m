From: Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [RFC][PATCH] objtool,x86_64: Replace recordmcount with objtool
Date: Thu, 25 Jun 2020 15:40:42 -0700
Message-ID: <20200625224042.GA169781@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-5-samitolvanen@google.com>
 <20200624212737.GV4817@hirez.programming.kicks-ass.net>
 <20200624214530.GA120457@google.com>
 <20200625074530.GW4817@hirez.programming.kicks-ass.net>
 <20200625161503.GB173089@google.com>
 <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407565AbgFYWkv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jun 2020 18:40:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2286DC08C5DB
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 15:40:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cm23so4038344pjb.5
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 15:40:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>, mhelsley@vmware.com

On Thu, Jun 25, 2020 at 10:02:35PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 25, 2020 at 09:15:03AM -0700, Sami Tolvanen wrote:
> > On Thu, Jun 25, 2020 at 09:45:30AM +0200, Peter Zijlstra wrote:
> 
> > > At least for x86_64 I can do a really quick take for a recordmcount pass
> > > in objtool, but I suppose you also need this for ARM64 ?
> > 
> > Sure, sounds good. arm64 uses -fpatchable-function-entry with clang, so we
> > don't need recordmcount there.
> 
> This is on top of my local pile:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git master
> 
> which notably includes the static_call series.
> 
> Not boot tested, but it generates the required sections and they look
> more or less as expected, ymmv.
> 
> ---
>  arch/x86/Kconfig              |  1 -
>  scripts/Makefile.build        |  3 ++
>  scripts/link-vmlinux.sh       |  2 +-
>  tools/objtool/builtin-check.c |  9 ++---
>  tools/objtool/builtin.h       |  2 +-
>  tools/objtool/check.c         | 81 +++++++++++++++++++++++++++++++++++++++++++
>  tools/objtool/check.h         |  1 +
>  tools/objtool/objtool.h       |  1 +
>  8 files changed, 91 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index a291823f3f26..189575c12434 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -174,7 +174,6 @@ config X86
>  	select HAVE_EXIT_THREAD
>  	select HAVE_FAST_GUP
>  	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
> -	select HAVE_FTRACE_MCOUNT_RECORD
>  	select HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_FUNCTION_TRACER
>  	select HAVE_GCC_PLUGINS

This breaks DYNAMIC_FTRACE according to kernel/trace/ftrace.c:

  #ifndef CONFIG_FTRACE_MCOUNT_RECORD
  # error Dynamic ftrace depends on MCOUNT_RECORD
  #endif

And the build errors after that seem to confirm this. It looks like we might
need another flag to skip recordmcount.

Anyway, since objtool is run before recordmcount, I just left this unchanged
for testing and ignored the recordmcount warnings about __mcount_loc already
existing. Something is a bit off still though, I see this at boot:

  ------------[ ftrace bug ]------------
  ftrace failed to modify
  [<ffffffff81000660>] __tracepoint_iter_initcall_level+0x0/0x40
   actual:   0f:1f:44:00:00
  Initializing ftrace call sites
  ftrace record flags: 0
   (0)
   expected tramp: ffffffff81056500
  ------------[ cut here ]------------

Otherwise, this looks pretty good.

Sami
