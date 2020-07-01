From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Date: Wed, 1 Jul 2020 17:05:12 +0200
Message-ID: <20200701150512.GH4817@hirez.programming.kicks-ass.net>
References: <CAKwvOdmxz91c-M8egR9GdR1uOjeZv7-qoTP=pQ55nU8TCpkK6g@mail.gmail.com>
 <20200625080313.GY4817@hirez.programming.kicks-ass.net>
 <20200625082433.GC117543@hirez.programming.kicks-ass.net>
 <20200625085745.GD117543@hirez.programming.kicks-ass.net>
 <20200630191931.GA884155@elver.google.com>
 <20200630201243.GD4817@hirez.programming.kicks-ass.net>
 <20200630203016.GI9247@paulmck-ThinkPad-P72>
 <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
 <20200701114027.GO4800@hirez.programming.kicks-ass.net>
 <20200701140654.GL9247@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731039AbgGAPFV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jul 2020 11:05:21 -0400
Content-Disposition: inline
In-Reply-To: <20200701140654.GL9247@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>

On Wed, Jul 01, 2020 at 07:06:54AM -0700, Paul E. McKenney wrote:

> The current state in the C++ committee is that marking variables
> carrying dependencies is the way forward.  This is of course not what
> the Linux kernel community does, but it should not be hard to have a
> -fall-variables-dependent or some such that causes all variables to be
> treated as if they were marked.  Though I was hoping for only pointers.
> Are they -sure- that they -absolutely- need to carry dependencies
> through integers???

What's 'need'? :-)

I'm thinking __ktime_get_fast_ns() is better off with a dependent load
than it is with an extra smp_rmb().

Yes we can stick an smp_rmb() in there, but I don't like it. Like I
wrote earlier, if I wanted a control dependency, I'd have written one.
