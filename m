Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:32983 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751416AbWIDUHH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Sep 2006 16:07:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Revert [i386/x86_64]: Remove __KERNEL__ ifdef around _syscall*()
Date: Mon, 4 Sep 2006 22:07:53 +0200
References: <200608302359.k7UNxIZW027536@hera.kernel.org> <1157398050.2473.137.camel@shinybook.infradead.org>
In-Reply-To: <1157398050.2473.137.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609042207.53588.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, akpm@osdl.org, ak@suse.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Am Monday 04 September 2006 21:27 schrieb David Woodhouse:
> 1. C libraries have their own syscall(); there's no _need_ for these
>    macros to be exported by the kernel.
>
> 2. These macros work in-kernel but they are _not_ designed to work in
>    the general case in userspace. The i386 version is broken for PIC
>    code, for example.

In -mm, they are no longer used in the kernel, and it's hard to even
try to use them since the 'errno' variable is gone as well.

> 3. We should be consistent about what we provide in kernel headers.
>    Since we don't provide these macros on other architectures, we should
>    not do so on i386 and x86_64

Yes, fully agreed.

> I see three possible ways to fix this. The first, and the sanest, is
> just to put the ifdefs back and remove these macros from user view, as
> in the patch below.

Putting #ifdef __KERNEL__ back in makes it consistently wrong on all
architectures, which is better than the current wrong on all architectures
but inconsistent state.

After merging my patches in early 2.6.19, the consequence of this should
be to remove the macros entirely so we don't get any new users.

> The second option, if the consensus really is that we should ignore
> reason #1 above and export these unneeded macros, is that we can apply
> the patch below and then also add generic versions of _syscall*() in
> linux/unistd.h which just invoke libc's syscall(), instead of trying to
> use the in-kernel assembly versions. That would at least address #2 and
> #3 -- and in fact some distributions have been shipping with that
> in /usr/include/linux/unistd.h for a long time already.

I'd rather have them in include/asm-generic/unistd.h and include that
from every <asm/unistd.h> to cause the least breakage in existing
user space applications.

> The third, and least sensible, option would be to accept what Andi has
> done and then attempt to address #2 and #3 above by _fixing_ the macros
> so that they work in the general case -- in all types of code and on all
> architectures. Even in that case, the patch below should be applied to
> remove these macros from user view as an interim measure until they are
> actually fixed and consistent across architectures and code models.

That should also follow by a change in 2.6.19 -- put all the macros in
#ifndef __KERNEL__, so they can /only/ be used in user space.

	Arnd <><
