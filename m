From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Date: Fri, 10 May 2019 14:07:09 +0900
Message-ID: <20190510050709.GA1831@jagdpanzerIV>
References: <20190509121923.8339-1-pmladek@suse.com>
 <20190510043200.GC15652@jagdpanzerIV>
 <CAHk-=wiP+hwSqEW0dM6AYNWUR7jXDkeueq69et6ahfUgV7hC3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wiP+hwSqEW0dM6AYNWUR7jXDkeueq69et6ahfUgV7hC3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>, Christophe Leroy <christophe.leroy@c-s.fr>, Stephen Rothwell <sfr@ozlabs.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On (05/09/19 21:47), Linus Torvalds wrote:
>    [ Sorry about html and mobile crud, I'm not at the computer right now ]
>    How about we just undo the whole misguided probe_kernel_address() thing?

But the problem will remain - %pS/%pF on PPC (and some other arch-s)
do dereference_function_descriptor(), which calls probe_kernel_address().
So if probe_kernel_address() starts to dump_stack(), then we are heading
towards stack overflow. Unless I'm totally missing something.

	-ss
