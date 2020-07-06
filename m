Return-Path: <SRS0=tLCE=AR=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbgGFS3p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jul 2020 14:29:45 -0400
Date: Mon, 6 Jul 2020 20:29:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Message-ID: <20200706182926.GH4800@hirez.programming.kicks-ass.net>
References: <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
 <20200701114027.GO4800@hirez.programming.kicks-ass.net>
 <20200701140654.GL9247@paulmck-ThinkPad-P72>
 <20200701150512.GH4817@hirez.programming.kicks-ass.net>
 <20200701160338.GN9247@paulmck-ThinkPad-P72>
 <20200702082040.GB4781@hirez.programming.kicks-ass.net>
 <20200702175948.GV9247@paulmck-ThinkPad-P72>
 <20200703131330.GX4800@hirez.programming.kicks-ass.net>
 <20200703144228.GF9247@paulmck-ThinkPad-P72>
 <20200706162633.GA13288@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706162633.GA13288@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Message-ID: <20200706182926.pbHoGe1-7_t5W7_R4qtVqvO0rmmJONMYvaGB9A-O8fk@z>

On Mon, Jul 06, 2020 at 09:26:33AM -0700, Paul E. McKenney wrote:

> And perhaps more constructively, we do need to prioritize address and data
> dependencies over control dependencies.  For one thing, there are a lot
> more address/data dependencies in existing code than there are control
> dependencies, and (sadly, perhaps more importantly) there are a lot more
> people who are convinced that address/data dependencies are important.

If they do not consider their Linux OS running correctly :-)

> For another (admittedly more theoretical) thing, the OOTA scenarios
> stemming from control dependencies are a lot less annoying than those
> from address/data dependencies.
> 
> And address/data dependencies are as far as I know vulnerable to things
> like conditional-move instructions that can cause problems for control
> dependencies.
> 
> Nevertheless, yes, control dependencies also need attention.

Today I added one more \o/
