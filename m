From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH v2 3/5] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Date: Thu, 3 May 2018 21:00:13 +0800
Message-ID: <20180503130013.lcsem2xubk5jqmcg@intel.com>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
 <1525268700-10631-4-git-send-email-changbin.du@intel.com>
 <CAK8P3a01sgKSYKmzptkNn4xfoGzV=k+uHu0+wco_-x-iMFtVYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a01sgKSYKmzptkNn4xfoGzV=k+uHu0+wco_-x-iMFtVYQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: changbin.du@intel.com, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Randy Dunlap <rdunlap@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, May 02, 2018 at 04:27:47PM -0400, Arnd Bergmann wrote:
> On Wed, May 2, 2018 at 9:44 AM,  <changbin.du@intel.com> wrote:
> > From: Changbin Du <changbin.du@intel.com>
> >
> > This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
> > this option will prevent the compiler from optimizing the kernel by
> > auto-inlining functions not marked with the inline keyword.
> >
> > With this option, only functions explicitly marked with "inline" will
> > be inlined. This will allow the function tracer to trace more functions
> > because it only traces functions that the compiler has not inlined.
> >
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> 
> Should this be closer to CONFIG_OPTIMIZE_INLINING or
> possibly mutually exclusive with it?
>
They are not related I think. CONFIG_OPTIMIZE_INLINING only has effect on
functions which are explicitly marked as inline.

>        Arnd

-- 
Thanks,
Changbin Du
