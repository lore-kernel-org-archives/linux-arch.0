Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-4.orcon.net.nz ([60.234.4.59]:39399 "EHLO
        smtp-4.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbeHKXxA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Aug 2018 19:53:00 -0400
Date: Sun, 12 Aug 2018 08:59:01 +1200
From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: [PATCH 1/6] alpha: Move __IGNORE* entries to non uapi header
Message-ID: <20180811205901.gxbcn5vf4z36cozi@tower>
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
 <1531736638-15294-2-git-send-email-firoz.khan@linaro.org>
 <20180811192804.GI6515@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180811192804.GI6515@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Firoz Khan <firoz.khan@linaro.org>, linux-alpha@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com
Message-ID: <20180811205901.UnzhLi9D1uoLQtZPDiZnqTwP8vZITFO7CCpnAadeopA@z>

On Sat, Aug 11, 2018 at 08:28:04PM +0100, Al Viro wrote:
> On Mon, Jul 16, 2018 at 03:53:53PM +0530, Firoz Khan wrote:
> > It is correct to keep __IGNORE* entry in non uapi header
> > asm/unistd.h while uapi/asm/unistd.h must hold information
> > only useful for user space applications.
> 
> > diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
> > index e153ca6..3bb6ac1 100644
> > --- a/arch/alpha/include/uapi/asm/unistd.h
> > +++ b/arch/alpha/include/uapi/asm/unistd.h
> > @@ -481,9 +481,4 @@
> >  #define __NR_pwritev2			521
> >  #define __NR_statx			522
> >  
> > -/* Alpha doesn't have protection keys. */
> > -#define __IGNORE_pkey_mprotect
> > -#define __IGNORE_pkey_alloc
> > -#define __IGNORE_pkey_free
> > -
> >  #endif /* _UAPI_ALPHA_UNISTD_H */
> 
> Hmm...  There's also
> 
> #define __IGNORE_alarm
> #define __IGNORE_creat

Tell you what, I wouldn't mind if the following ones were actually
implemented as syscalls in the kernel on Alpha:

> #define __IGNORE_getegid
> #define __IGNORE_geteuid
> #define __IGNORE_getgid
> #define __IGNORE_getpid
> #define __IGNORE_getppid
> #define __IGNORE_getuid

There's a growing number of software packages that are deciding
to sideskip glibc and call these syscalls directly.  Supporting
OSF's C ABI incompliant getxpid, etc., in such packages is not
easy and rather intrusive.

Cheers,
Michael.
