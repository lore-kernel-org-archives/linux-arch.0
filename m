From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/5] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Date: Wed, 2 May 2018 16:27:47 -0400
Message-ID: <CAK8P3a01sgKSYKmzptkNn4xfoGzV=k+uHu0+wco_-x-iMFtVYQ@mail.gmail.com>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com> <1525268700-10631-4-git-send-email-changbin.du@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525268700-10631-4-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: changbin.du@intel.com
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Randy Dunlap <rdunlap@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, May 2, 2018 at 9:44 AM,  <changbin.du@intel.com> wrote:
> From: Changbin Du <changbin.du@intel.com>
>
> This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
> this option will prevent the compiler from optimizing the kernel by
> auto-inlining functions not marked with the inline keyword.
>
> With this option, only functions explicitly marked with "inline" will
> be inlined. This will allow the function tracer to trace more functions
> because it only traces functions that the compiler has not inlined.
>
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Should this be closer to CONFIG_OPTIMIZE_INLINING or
possibly mutually exclusive with it?

       Arnd
