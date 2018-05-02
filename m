From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH 3/5] kernel hacking: new config NO_AUTO_INLINE to disable
 compiler atuo-inline optimizations
Date: Wed, 2 May 2018 17:27:01 +0800
Message-ID: <20180502092700.i4tpyi7gbf7jz7ax@intel.com>
References: <1525179614-14571-1-git-send-email-changbin.du@intel.com>
 <1525179614-14571-4-git-send-email-changbin.du@intel.com>
 <20180501105420.07e41578@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180501105420.07e41578@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: changbin.du@intel.com, yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org, x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, May 01, 2018 at 10:54:20AM -0400, Steven Rostedt wrote:
> On Tue,  1 May 2018 21:00:12 +0800
> changbin.du@intel.com wrote:
> 
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
> > this option will make compiler not auto-inline kernel functions. By
> > enabling this option, all the kernel functions (including static ones)
> > will not be optimized out except those marked as inline or always_inline.
> > This is useful when you are using ftrace to understand the control flow
> > of kernel code or tracing some static functions.
> 
> I'm not against this patch, but it's up to others if this gets included
> or not.
> 
> > 
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > ---
> >  Makefile          |  6 ++++++
> >  lib/Kconfig.debug | 13 +++++++++++++
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/Makefile b/Makefile
> > index 619a85a..eb694f6 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -775,6 +775,12 @@ KBUILD_CFLAGS 	+= $(call cc-option, -femit-struct-debug-baseonly) \
> >  		   $(call cc-option,-fno-var-tracking)
> >  endif
> >  
> > +ifdef CONFIG_NO_AUTO_INLINE
> > +KBUILD_CFLAGS   += $(call cc-option, -fno-inline-functions) \
> > +		   $(call cc-option, -fno-inline-small-functions) \
> > +		   $(call cc-option, -fno-inline-functions-called-once)
> > +endif
> > +
> >  ifdef CONFIG_FUNCTION_TRACER
> >  ifndef CC_FLAGS_FTRACE
> >  CC_FLAGS_FTRACE := -pg
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index c40c7b7..90f35ad 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -198,6 +198,19 @@ config GDB_SCRIPTS
> >  	  instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
> >  	  for further details.
> >  
> > +config NO_AUTO_INLINE
> > +	bool "Disable compiler atuo-inline optimizations"
> 
> typo: s/atuo/auto/
> 
> > +	default n
> > +	help
> > +	  This will make compiler not auto-inline kernel functions for
> > +	  optimization. By enabling this option, all the kernel functions
> > +	  (including static ones) will not be optimized out except those
> > +	  marked as inline or always_inline. This is useful when you are
> > +	  using ftrace to understand the control flow of kernel code or
> > +	  tracing some static functions.
> 
> Some grammar updates:
> 
> 	  This will prevent the compiler from optimizing the kernel by
> 	  auto-inlining functions not marked with the inline keyword.
> 	  With this option, only functions explicitly marked with
> 	  "inline" will be inlined. This will allow the function tracer
> 	  to trace more functions because it only traces functions that
> 	  the compiler has not inlined.
> 
> 	  Enabling this function can help debugging a kernel if using
> 	  the function tracer. But it can also change how the kernel
> 	  works, because inlining functions may change the timing,
> 	  which could make it difficult while debugging race conditions.
> 

Thanks for your kind grammar updates. I will update them. :)

> > +
> > +	  Use only if you want to debug the kernel.
> 
> The proper way to say the above is:
> 
> 	  If unsure, select N
>
Agree.

> -- Steve
> 
> > +
> >  config ENABLE_WARN_DEPRECATED
> >  	bool "Enable __deprecated logic"
> >  	default y
> 


-- 
Thanks,
Changbin Du
