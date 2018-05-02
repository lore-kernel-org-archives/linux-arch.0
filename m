From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH 4/5] kernel hacking: new config DEBUG_EXPERIENCE to apply
 GCC -Og optimization
Date: Wed, 2 May 2018 17:24:58 +0800
Message-ID: <20180502092458.zss44oqy7fqsyszp@intel.com>
References: <1525179614-14571-1-git-send-email-changbin.du@intel.com>
 <1525179614-14571-5-git-send-email-changbin.du@intel.com>
 <f19eae29-3b94-5151-04c5-6fb620bd28e9@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f19eae29-3b94-5151-04c5-6fb620bd28e9@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: changbin.du@intel.com, yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org, x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, May 01, 2018 at 08:25:27AM -0700, Randy Dunlap wrote:
> Good morning.
> 
> On 05/01/2018 06:00 AM, changbin.du@intel.com wrote:
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > 
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > ---
> >  Makefile                     |  4 ++++
> >  include/linux/compiler-gcc.h |  2 +-
> >  include/linux/compiler.h     |  2 +-
> >  lib/Kconfig.debug            | 21 +++++++++++++++++++++
> >  4 files changed, 27 insertions(+), 2 deletions(-)
> > 
> 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 90f35ad..2432e77d 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -211,6 +211,27 @@ config NO_AUTO_INLINE
> >  
> >  	  Use only if you want to debug the kernel.
> >  
> > +config DEBUG_EXPERIENCE
> > +	bool "Optimize for better debugging experience (-Og)"
> > +	default n
> > +	select NO_AUTO_INLINE
> > +	depends on !CC_OPTIMIZE_FOR_SIZE
> > +	help
> > +	  This will apply GCC '-Og' optimization level get supported from
> 
> 	                                               which is supported since
> 
> > +	  GCC 4.8. This optimization level offers a reasonable level of
> > +	  optimization while maintaining fast compilation and a good
> > +	  debugging experience. It is similar to '-O1' while perfer keeping
> 
> 	                                               while preferring to keep
> 
> > +	  debug ability over runtime speed. The overall performance will
> > +	  drop a bit.
> > +
> > +	  If enabling this option break your kernel, you should either
> 
> 	                          breaks
> 
> > +	  disable this or find a fix (mostly in the arch code). Currently
> > +	  this option has only be tested in qemu x86_64 guest.
> > +
> > +	  Use only if you want to debug the kernel, especially if you want
> > +	  to have better kernel debugging experience with gdb facilities
> > +	  like kgdb and qemu.
> > +
> >  config ENABLE_WARN_DEPRECATED
> >  	bool "Enable __deprecated logic"
> >  	default y
> > 
> 
> thanks,
> -- 
> ~Randy

Thanks for your correction, I will update.

-- 
Thanks,
Changbin Du
