From: Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 04/22] kbuild: lto: fix recordmcount
Date: Wed, 24 Jun 2020 14:45:30 -0700
Message-ID: <20200624214530.GA120457@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-5-samitolvanen@google.com>
 <20200624212737.GV4817@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404455AbgFXVpi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 17:45:38 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1363C061573
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 14:45:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ne5so1773915pjb.5
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 14:45:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200624212737.GV4817@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org

On Wed, Jun 24, 2020 at 11:27:37PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 24, 2020 at 01:31:42PM -0700, Sami Tolvanen wrote:
> > With LTO, LLVM bitcode won't be compiled into native code until
> > modpost_link. This change postpones calls to recordmcount until after
> > this step.
> > 
> > In order to exclude specific functions from inspection, we add a new
> > code section .text..nomcount, which we tell recordmcount to ignore, and
> > a __nomcount attribute for moving functions to this section.
> 
> I'm confused, you only add this to functions in ftrace itself, which is
> compiled with:
> 
>  KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
> 
> and so should not have mcount/fentry sites anyway. So what's the point
> of ignoring them further?
> 
> This Changelog does not explain.

Normally, recordmcount ignores each ftrace.o file, but since we are
running it on vmlinux.o, we need another way to stop it from looking
at references to mcount/fentry that are not calls. Here's a comment
from recordmcount.c:

  /*
   * The file kernel/trace/ftrace.o references the mcount
   * function but does not call it. Since ftrace.o should
   * not be traced anyway, we just skip it.
   */

But I agree, the commit message could use more defails. Also +Steven
for thoughts about this approach.

Sami
