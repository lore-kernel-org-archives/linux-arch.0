From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 1/4] asm-generic/uaccess: don't define inline functions if
 noinline lib/* in use
Date: Wed, 15 Jan 2020 14:12:24 +0000
Message-ID: <20200115141224.GH8904@ZenIV.linux.org.uk>
References: <20200114200846.29434-1-vgupta@synopsys.com>
 <20200114200846.29434-2-vgupta@synopsys.com>
 <CAHk-=wjChjfOaDnGygOJpC36R6mtT7=Xf6wWTzD_wLJm=quu0Q@mail.gmail.com>
 <CAK8P3a2ao=xBuy3XHBkdo03KEjpMHGe9ahwj-uogtkZBXsMkGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2ao=xBuy3XHBkdo03KEjpMHGe9ahwj-uogtkZBXsMkGw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 15, 2020 at 10:08:31AM +0100, Arnd Bergmann wrote:

> > I would suggest that anybody who uses asm-generic/uaccess.h needs to
> > simply use the generic library version.
> 
> Or possibly just everybody altogether: the remaining architectures that
> have a custom implementation don't seem to be doing any better either.

No go for s390.  There you really want to access userland memory in
larger chunks - it's oriented for block transfers.  IIRC, the insn
they are using has a costly setup phase, independent of the amount
to copy, followed by reasonably fast transfer more or less linear
by the size.
