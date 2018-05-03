From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH v2 0/5] kernel hacking: GCC optimization for debug
 experience (-Og)
Date: Thu, 3 May 2018 21:49:26 +0800
Message-ID: <20180503134925.eyqna4ydogtkmvph@intel.com>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
 <20180502145631.bzfqpw4izlrqhda6@holly.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180502145631.bzfqpw4izlrqhda6@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: changbin.du@intel.com, yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org, rostedt@goodmis.org, rdunlap@infradead.org, x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, May 02, 2018 at 03:56:31PM +0100, Daniel Thompson wrote:
> On Wed, May 02, 2018 at 09:44:55PM +0800, changbin.du@intel.com wrote:
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > Hi all,
> > I know some kernel developers was searching for a method to dissable GCC
> > optimizations, probably they want to apply GCC '-O0' option. But since Linux
> > kernel replys on GCC optimization to remove some dead code, so '-O0' just
> > breaks the build. They do need this because they want to debug kernel with
> > qemu, simics, kgtp or kgdb.
> > 
> > Thanks for the GCC '-Og' optimization level introduced in GCC 4.8, which
> > offers a reasonable level of optimization while maintaining fast compilation
> > and a good debugging experience. It is similar to '-O1' while perfer keeping
> > debug ability over runtime speed. With '-Og', we can build a kernel with
> > better debug ability and little performance drop after some simple change.
> > 
> > In this series, firstly introduce a new config CONFIG_NO_AUTO_INLINE after two
> > fixes for this new option. With this option, only functions explicitly marked
> > with "inline" will  be inlined. This will allow the function tracer to trace
> > more functions because it only traces functions that the compiler has not
> > inlined.
> > 
> > Then introduce new config CONFIG_DEBUG_EXPERIENCE which apply '-Og'
> > optimization level for whole kernel, with a simple fix in fix_to_virt().
> > Currently this option is only tested on a QEMU gust and it works fine.
> > 
> > 
> > Comparison of vmlinux size: a bit smaller.
> > 
> >     w/o CONFIG_DEBUG_EXPERIENCE
> >     $ size vmlinux
> >        text    data     bss     dec     hex filename
> >     22665554   9709674  2920908 35296136        21a9388 vmlinux
> > 
> >     w/ CONFIG_DEBUG_EXPERIENCE
> >     $ size vmlinux
> >        text    data     bss     dec     hex filename
> >     21499032   10102758 2920908 34522698        20ec64a vmlinux
> > 
> > 
> > Comparison of system performance: a bit drop (~6%).
> >     This benchmark of kernel compilation is suggested by Ingo Molnar.
> >     https://lkml.org/lkml/2018/5/2/74
> 
> In my mind was the opposite question. When running on the same kernel
> does a kernel whose config contains CONFIG_DEBUG_EXPERIENCE build faster
> than one without (due to the disabled optimization passes).
> 
> To be honest this is more curiosity than a review comment though... if
> you have the figures please share, if not then don't sweat it on my
> account!
> 
> 
> Daniel.
>
Sorry I don't have the data yet. Per the comment in GCC, I think it should be a
little faster but not obviously.

> 
-- 
Thanks,
Changbin Du
