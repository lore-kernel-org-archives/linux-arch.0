Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38098 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfEKAvb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 May 2019 20:51:31 -0400
MIME-Version: 1.0
References: <20190412143538.11780-1-hch@lst.de> <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com>
 <fd59e6e22594f740eaf86abad76ee04d@mailhost.ics.forth.gr> <CACT4Y+aKGKm9Wbc1owBr51adkbesHP_Z81pBAoZ5HmJ+uZdsaw@mail.gmail.com>
In-Reply-To: <CACT4Y+aKGKm9Wbc1owBr51adkbesHP_Z81pBAoZ5HmJ+uZdsaw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 10 May 2019 20:51:12 -0400
Message-ID: <CAK8P3a3xRBZrgv16sSigJhY0vGmb=qF9o=6dC_5DqAJtW3qPGQ@mail.gmail.com>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel endianess
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Nick Kossifidis <mick@ics.forth.gr>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20190511005112.sEVh2meS4cv8aJzmmfB7vByFBjs4Y0mCOX_XfDnHW_M@z>

On Fri, May 10, 2019 at 6:53 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > I think it's good to have a sanity check in-place for consistency.
>
>
> Hi,
>
> This broke our cross-builds from x86. I am using:
>
> $ powerpc64le-linux-gnu-gcc --version
> powerpc64le-linux-gnu-gcc (Debian 7.2.0-7) 7.2.0
>
> and it says that it's little-endian somehow:
>
> $ powerpc64le-linux-gnu-gcc -dM -E - < /dev/null | grep BYTE_ORDER
> #define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
>
> Is it broke compiler? Or I always hold it wrong? Is there some
> additional flag I need to add?

It looks like a bug in the kernel Makefiles to me. powerpc32 is always
big-endian,
powerpc64 used to be big-endian but is now usually little-endian. There are
often three separate toolchains that default to the respective user
space targets
(ppc32be, ppc64be, ppc64le), but generally you should be able to build
any of the
three kernel configurations with any of those compilers, and have the Makefile
pass the correct -m32/-m64/-mbig-endian/-mlittle-endian command line options
depending on the kernel configuration. It seems that this is not happening
here. I have not checked why, but if this is the problem, it should be
easy enough
to figure out.

       Arnd
