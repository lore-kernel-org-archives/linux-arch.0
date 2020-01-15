From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 1/4] asm-generic/uaccess: don't define inline functions if
 noinline lib/* in use
Date: Wed, 15 Jan 2020 15:21:52 +0100
Message-ID: <CAK8P3a0eu-2ov-Y0EEuv_XSGUTWoyiScf5z5P=kn5S+ORhxF-A@mail.gmail.com>
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-2-vgupta@synopsys.com>
 <CAHk-=wjChjfOaDnGygOJpC36R6mtT7=Xf6wWTzD_wLJm=quu0Q@mail.gmail.com>
 <CAK8P3a2ao=xBuy3XHBkdo03KEjpMHGe9ahwj-uogtkZBXsMkGw@mail.gmail.com> <20200115141224.GH8904@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:59397 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgAOOWL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jan 2020 09:22:11 -0500
In-Reply-To: <20200115141224.GH8904@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Wed, Jan 15, 2020 at 3:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Jan 15, 2020 at 10:08:31AM +0100, Arnd Bergmann wrote:
>
> > > I would suggest that anybody who uses asm-generic/uaccess.h needs to
> > > simply use the generic library version.
> >
> > Or possibly just everybody altogether: the remaining architectures that
> > have a custom implementation don't seem to be doing any better either.
>
> No go for s390.  There you really want to access userland memory in
> larger chunks - it's oriented for block transfers.  IIRC, the insn
> they are using has a costly setup phase, independent of the amount
> to copy, followed by reasonably fast transfer more or less linear
> by the size.

Right, I missed that one while looking through the remaining
implementations.

     Arnd
