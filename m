From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 3/5] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Date: Thu, 3 May 2018 10:16:06 -0400
Message-ID: <20180503101606.51b7a6a2@gandalf.local.home>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
        <1525268700-10631-4-git-send-email-changbin.du@intel.com>
        <CAK8P3a01sgKSYKmzptkNn4xfoGzV=k+uHu0+wco_-x-iMFtVYQ@mail.gmail.com>
        <20180503130013.lcsem2xubk5jqmcg@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180503130013.lcsem2xubk5jqmcg@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Du, Changbin" <changbin.du@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 3 May 2018 21:00:13 +0800
"Du, Changbin" <changbin.du@intel.com> wrote:

> On Wed, May 02, 2018 at 04:27:47PM -0400, Arnd Bergmann wrote:
> > On Wed, May 2, 2018 at 9:44 AM,  <changbin.du@intel.com> wrote:  
> > > From: Changbin Du <changbin.du@intel.com>
> > >
> > > This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
> > > this option will prevent the compiler from optimizing the kernel by
> > > auto-inlining functions not marked with the inline keyword.
> > >
> > > With this option, only functions explicitly marked with "inline" will
> > > be inlined. This will allow the function tracer to trace more functions
> > > because it only traces functions that the compiler has not inlined.
> > >
> > > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>  
> > 
> > Should this be closer to CONFIG_OPTIMIZE_INLINING or
> > possibly mutually exclusive with it?
> >  
> They are not related I think. CONFIG_OPTIMIZE_INLINING only has effect on
> functions which are explicitly marked as inline.
> 

Agreed, as OPTIMIZE_INLINING is to make functions marked inline not to
be inlined. And I just noticed (doing a git grep), that that config is
now only available in arch/x86. Maybe it always was, but sparc
undefines it for vclock_gettime.c.

$ git grep OPTIMIZE_INLIN
arch/sparc/vdso/vdso32/vclock_gettime.c:#undef  CONFIG_OPTIMIZE_INLINING
arch/x86/Kconfig.debug:config OPTIMIZE_INLINING
arch/x86/configs/i386_defconfig:CONFIG_OPTIMIZE_INLINING=y
arch/x86/configs/x86_64_defconfig:CONFIG_OPTIMIZE_INLINING=y
arch/x86/entry/vdso/vdso32/vclock_gettime.c:#undef CONFIG_OPTIMIZE_INLINING
include/linux/compiler-gcc.h:    !defined(CONFIG_OPTIMIZE_INLINING) || (__GNUC__ < 4)
kernel/configs/tiny.config:CONFIG_OPTIMIZE_INLINING=y

-- Steve
