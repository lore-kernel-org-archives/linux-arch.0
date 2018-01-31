From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] vfs.git: poll annotations
Date: Tue, 30 Jan 2018 18:21:37 -0800
Message-ID: <CA+55aFz8UL883+rj0nYsU_gtX6jLhriPGncDb1XDteEu817HRQ@mail.gmail.com>
References: <20180130183939.GB29051@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180130183939.GB29051@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 30, 2018 at 10:39 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>         Introduces a __bitwise type for POLL... bitmap, propagates
> the annotations through the tree.

Ok, I'm not entirely happy with this.

I don't think the mangle/demangle_poll() stuff should be in the uapi
headers, and it really worries me that we use the same names - with
different values - for the kernel and user versions of the POLLxyz
macros.

So honestly, like the structure translations we do (ie termios <->
ktermios, stat <-> kstat), I really think we'd be better off having
explicit naming when some kernel data is different from user data.

That could make the mangling be automated too, ie assuming gcc gets it
right, maybe done with

   #define pollmask_to_kernel(uval, UMASK, KMASK) \
        ((force __poll_t)(((uval)&UMASK)/UMASK*KMASK))

   static inline __poll_t unmangle_poll(unsigned int uval)
   {
        return pollmask_to_kernel(uval, POLLIN, KPOLLIN) |
             pollmask_to_kernel(uval, POLLOUT, KPOLLOUT) |
             pollmask_to_kernel(uval, POLLERR, KPOLLERR) |
             ...

or similar. With no arch-specific hardcoded bit knowledge except for
the actual values of POLLIN/etc.

I dunno. Maybe it ends up being too painful.

So I've pulled this, but I just wanted to state that I'm not entirely
happy about it all.

                Linus
