Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46094 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932412AbcGDJSn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 4 Jul 2016 05:18:43 -0400
Date: Mon, 4 Jul 2016 11:18:41 +0200
From: Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH v2 1/2] arm64: implement FTRACE_WITH_REGS
Message-ID: <20160704091841.GB19960@lst.de>
References: <20160627151500.2247A68D20@newverein.lst.de> <20160627151717.BD25468D26@newverein.lst.de> <20160701125344.usuovsvbpilzen4m@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160701125344.usuovsvbpilzen4m@treble>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, takahiro.akashi@linaro.org, Jungseok Lee <jungseoklee85@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Li Bin <huawei.libin@huawei.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Christopher Li <sparse@chrisli.org>, Jiri Kosina <jikos@kernel.org>, andrew.wafaa@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org
Message-ID: <20160704091841.mXLIj3lV8LuEPzyP4NHrjN1aDqkz1CDEeI_G8tRGlUo@z>

On Fri, Jul 01, 2016 at 07:53:44AM -0500, Josh Poimboeuf wrote:
> On Mon, Jun 27, 2016 at 05:17:17PM +0200, Torsten Duwe wrote:
> > Once gcc is enhanced to optionally generate NOPs at the beginning
> > of each function, like the concept proven in
> > https://gcc.gnu.org/ml/gcc-patches/2016-04/msg01671.html
> > (sans the "fprintf (... pad_size);", which spoils the data structure
> > for kernel use), the generated pads can nicely be used to reroute
> > function calls for tracing/profiling, or live patching.

[...]

> > @@ -35,6 +35,10 @@ KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
> >  KBUILD_CFLAGS	+= $(call cc-option, -mpc-relative-literal-loads)
> >  KBUILD_AFLAGS	+= $(lseinstr)
> >  
> > +ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS), y)
> > +CC_FLAGS_FTRACE := -fprolog-pad=2 -DCC_USING_PROLOG_PAD
> > +endif
> > +
> 
> It would probably be good to print a warning for older gccs which don't
> support this option, so that when the build fails, there's at least a
> warning to indicate why.  Something like:
> 
>   ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>     CC_FLAGS_FTRACE := -fprolog-pad=2 -DCC_USING_PROLOG_PAD
>     ifeq ($(call cc-option,-fprolog-pad=2),)
>       $(warning Cannot use CONFIG_DYNAMIC_FTRACE_WITH_REGS: \
>                -fprolog-pad not supported by compiler)
>     endif
>   endif

Yes. Ideally, compiler support could be checked even before the option is
offered, but your explicit warning is better than just failing obscurely.

What do you think about prolog-pad in general? If we can convince the
gcc people to include it, it could become the default mechanism for all
architectures that do not require special treatment (e.g. like ABIv2
dual entry on ppc64le).

	Torsten

