From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 1/4] asm-generic/uaccess: don't define inline functions if
 noinline lib/* in use
Date: Wed, 15 Jan 2020 10:08:31 +0100
Message-ID: <CAK8P3a2ao=xBuy3XHBkdo03KEjpMHGe9ahwj-uogtkZBXsMkGw@mail.gmail.com>
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-2-vgupta@synopsys.com>
 <CAHk-=wjChjfOaDnGygOJpC36R6mtT7=Xf6wWTzD_wLJm=quu0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wjChjfOaDnGygOJpC36R6mtT7=Xf6wWTzD_wLJm=quu0Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 14, 2020 at 10:33 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jan 14, 2020 at 12:09 PM Vineet Gupta
> <Vineet.Gupta1@synopsys.com> wrote:
> >
> > There are 2 generic varaints of strncpy_from_user() / strnlen_user()
> >  (1). inline version in asm-generic/uaccess.h
>
> I think we should get rid of this entirely. It's just a buggy garbage
> implementation that nobody should ever actually use.
>
> It does just about everything wrong that you *can* do, wrong,
> including doing the NUL-filling termination of standard strncpy() that
> "strncpy_from_user()" doesn't actually do.
>
> So:
>
>  - the asm-generic/uaccess.h __strncpy_from_user() function is just
> horribly wrong

I checked who is actually using it, and the only ones I found
are c6x and rv32-nommu. It shouldn't be hard to move them over
to the generic version.

>  - the generic/uaccess.h version of strncpy_from_user() shouldn't be
> an inline function either, since the only thing it can do inline is
> the bogus one-byte access check that _barely_ makes security work (you
> also need to have a guard page to _actually_ make it work, and I'm not
> atr all convinced that people do).

That would be arc, hexagon, unicore32, and um. Hexagon already has
the same bug in strncpy_from_user and should be converted to the
generic version as you say. For unicore32 the existing asm imlpementation
may be fine, but it's clearly easier to use the generic code than moving
the range check in there.

I don't know what the arch/um implementation needs, but since it's in C,
moving the access_ok() in there is easy enough.

> I would suggest that anybody who uses asm-generic/uaccess.h needs to
> simply use the generic library version.

Or possibly just everybody altogether: the remaining architectures that
have a custom implementation don't seem to be doing any better either.

     Arnd
