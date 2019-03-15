Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41392 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfCOUap (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Mar 2019 16:30:45 -0400
MIME-Version: 1.0
References: <20190311153857.563743-1-arnd@arndb.de> <87k1h1fgkk.fsf@mid.deneb.enyo.de>
In-Reply-To: <87k1h1fgkk.fsf@mid.deneb.enyo.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Mar 2019 21:30:25 +0100
Message-ID: <CAK8P3a1r8GRC7GTHHqWY-PUn=9rWB-7+Qo=7txanbEjGZ-wppw@mail.gmail.com>
Subject: Re: [PATCH] y2038: fix socket.h header inclusion
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: "David S . Miller" <davem@davemloft.net>, Deepa Dinamani <deepa.kernel@gmail.com>, Willem de Bruijn <willemb@google.com>, alpha <linux-alpha@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-mips@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Laura Abbott <labbott@redhat.com>, Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>
Message-ID: <20190315203025.FLyJ2RcSiDlkXaF6_BFi26I38iKTu6tw61T9_oxHAZA@z>

On Thu, Mar 14, 2019 at 7:41 PM Florian Weimer <fw@deneb.enyo.de> wrote:
>
> * Arnd Bergmann:
>
> > diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> > index 0d0fddb7e738..976e89b116e5 100644
> > --- a/arch/alpha/include/uapi/asm/socket.h
> > +++ b/arch/alpha/include/uapi/asm/socket.h
> > @@ -2,8 +2,8 @@
> >  #ifndef _UAPI_ASM_SOCKET_H
> >  #define _UAPI_ASM_SOCKET_H
> >
> > +#include <linux/posix_types.h>
> >  #include <asm/sockios.h>
> > -#include <asm/bitsperlong.h>
>
> This breaks POSIX conformance in glibc because the
> <linux/posix_types.h> header is not namespace clean.  It contains the
> identifiers fds_bits and val:
>
>         unsigned long fds_bits[__FD_SETSIZE / (8 * sizeof(long))];
>
>         int     val[2];

What is problematic about the struct members here? I had thought that
only the struct names have to be in a namespace to be usable here,
but not the members.

The only part that might be problematic is

#undef __FD_SETSIZE
#define __FD_SETSIZE    1024

but we already get that from a number of other inclusions of
linux/posix_types.h. Is this what you mean?

> We could duplicate some of the SO_* constants for POSIX mode in glibc,
> but it would be nice to avoid that.
>
> Is there a different way of fixing this on the kernel side that avoids
> including <linux/posix_types.h>?

We could use asm/posix_types.h instead of linux/posix_types.h,
would that address your concern?

       Arnd
