Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39713 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeHLBDT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Aug 2018 21:03:19 -0400
MIME-Version: 1.0
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
 <1531736638-15294-2-git-send-email-firoz.khan@linaro.org> <20180811192804.GI6515@ZenIV.linux.org.uk>
 <20180811205901.gxbcn5vf4z36cozi@tower>
In-Reply-To: <20180811205901.gxbcn5vf4z36cozi@tower>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 12 Aug 2018 00:27:23 +0200
Message-ID: <CAK8P3a1mfnM6qTuxAqJ3_cUv4bZHNScS+VTytyU9oqmo00r7Kg@mail.gmail.com>
Subject: Re: [PATCH 1/6] alpha: Move __IGNORE* entries to non uapi header
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mcree@orcon.net.nz, Al Viro <viro@zeniv.linux.org.uk>, Firoz Khan <firoz.khan@linaro.org>, linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>
Message-ID: <20180811222723.tzlTci7UU77m-g2NIouwzyIhxg3sYaRn6S_5nwuFibg@z>

On Sat, Aug 11, 2018 at 10:59 PM Michael Cree <mcree@orcon.net.nz> wrote:
>
> On Sat, Aug 11, 2018 at 08:28:04PM +0100, Al Viro wrote:
> > On Mon, Jul 16, 2018 at 03:53:53PM +0530, Firoz Khan wrote:
> > > It is correct to keep __IGNORE* entry in non uapi header
> > > asm/unistd.h while uapi/asm/unistd.h must hold information
> > > only useful for user space applications.
> >
> > > diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
> > > index e153ca6..3bb6ac1 100644
> > > --- a/arch/alpha/include/uapi/asm/unistd.h
> > > +++ b/arch/alpha/include/uapi/asm/unistd.h
> > > @@ -481,9 +481,4 @@
> > >  #define __NR_pwritev2                      521
> > >  #define __NR_statx                 522
> > >
> > > -/* Alpha doesn't have protection keys. */
> > > -#define __IGNORE_pkey_mprotect
> > > -#define __IGNORE_pkey_alloc
> > > -#define __IGNORE_pkey_free
> > > -
> > >  #endif /* _UAPI_ALPHA_UNISTD_H */
> >
> > Hmm...  There's also
> >
> > #define __IGNORE_alarm
> > #define __IGNORE_creat
>
> Tell you what, I wouldn't mind if the following ones were actually
> implemented as syscalls in the kernel on Alpha:
>
> > #define __IGNORE_getegid
> > #define __IGNORE_geteuid
> > #define __IGNORE_getgid
> > #define __IGNORE_getpid
> > #define __IGNORE_getppid
> > #define __IGNORE_getuid
>
> There's a growing number of software packages that are deciding
> to sideskip glibc and call these syscalls directly.  Supporting
> OSF's C ABI incompliant getxpid, etc., in such packages is not
> easy and rather intrusive.

That sounds like a good idea to me. It would also help simplify libc
implementations in the long run, as we will probably soon have a
new baseline kernel header version once the y2038 syscalls
are added, with glibc (and maybe others) requiring at leat that
new version as a build time dependency rather than requiring
linux-3.2+ for both headers and runtime.

In a number of years, the latest glibc might then use that same
version again for both the header version and the kernel runtime,
and at that point, it can drop the alpha specific wrapper.

For the other __IGNORE_ entries, I think we can just drop the ones
for alarm, creat, pause, time and utime, as they are already present
in scripts/checksyscalls.sh. __IGNORE_mount2 is still required here,
since alpha calls it __NR_mount rather than __NR_mount2.

    Arnd
