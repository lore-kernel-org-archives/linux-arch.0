From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC 1/4] asm-generic/uaccess: don't define inline functions if
 noinline lib/* in use
Date: Tue, 14 Jan 2020 13:32:50 -0800
Message-ID: <CAHk-=wjChjfOaDnGygOJpC36R6mtT7=Xf6wWTzD_wLJm=quu0Q@mail.gmail.com>
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-2-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200114200846.29434-2-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, linux-snps-arc@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 14, 2020 at 12:09 PM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> There are 2 generic varaints of strncpy_from_user() / strnlen_user()
>  (1). inline version in asm-generic/uaccess.h

I think we should get rid of this entirely. It's just a buggy garbage
implementation that nobody should ever actually use.

It does just about everything wrong that you *can* do, wrong,
including doing the NUL-filling termination of standard strncpy() that
"strncpy_from_user()" doesn't actually do.

So:

 - the asm-generic/uaccess.h __strncpy_from_user() function is just
horribly wrong

 - the generic/uaccess.h version of strncpy_from_user() shouldn't be
an inline function either, since the only thing it can do inline is
the bogus one-byte access check that _barely_ makes security work (you
also need to have a guard page to _actually_ make it work, and I'm not
atr all convinced that people do).

the whole thing is just broken and should be removed from a header file.

>  (2). optimized word-at-a-time version in lib/*

That is - outside of the original x86 strncpy_from_user() - the only
copy of this function that historically gets all the corner cases
right. And even those we've gotten wrong occasionally.

I would suggest that anybody who uses asm-generic/uaccess.h needs to
simply use the generic library version.

             Linus
