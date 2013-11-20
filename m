From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND] asm/types.h: Remove include/asm-generic/int-l64.h
Date: Wed, 20 Nov 2013 01:37:20 +0100
Message-ID: <201311200137.20917.arnd@arndb.de>
References: <1376996476-12027-2-git-send-email-geert@linux-m68k.org> <201311191335.40506.arnd@arndb.de> <CAMuHMdXvn2GigpnH020XA1JvtF=4ZxwrOF4T=ocGgjhrcbWkgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:62883 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab3KTAh4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Nov 2013 19:37:56 -0500
In-Reply-To: <CAMuHMdXvn2GigpnH020XA1JvtF=4ZxwrOF4T=ocGgjhrcbWkgg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Randy Dunlap <rdunlap@xenotime.net>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tuesday 19 November 2013, Geert Uytterhoeven wrote:
> On Tue, Nov 19, 2013 at 1:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> > I'm pretty sure you are right with this, but I don't remember at all
> > what I suggested and don't understand what the problem (if any) is.
> > Can you remind me?
> 
> Me neither :-(
> You said https://lkml.org/lkml/2011/8/13/109, and Al's umode_t
> consolidation has been completed.
> 
> I think it had to do with include/uapi/asm-generic/types.h including
> <asm-generic/int-ll64.h>. Let's try...
> 
> In userspace, it will include <asm-generic/int-ll64.h> from uapi to get
> e.g. __u32.
> In kernelspace, it will include plain <asm-generic/int-ll64.h> (to get e.g.
> u32), which will in turn include <uapi/asm-generic/int-ll64.h> (to also
> get e.g. __u32).
> 
> As there's only include/uapi/asm-generic/types.h, but not
> include/asm-generic/types.h (the individual architectures still have their
> own asm/types.h), you cannot easily move (the contents of) int-ll64.h
> to asm-generic/types.h for both the normal and uapi headers.
> 
> Does this make sense?

I'm pretty sure I was not talking about include/uapi/asm-generic/types.h
there, and I still think we can just move include/asm-generic/int-ll64.h
to include/asm-generic/types.h but leave the uapi logic in place.

All architectures that do nothing but #include <asm-generic/int-ll64.h>
from asm/types.h at the moment can then remove their private file and
use the generic version, the others need to change to #include 
<asm-generic/types.h>.

You can no longer #include <uapi/asm-generic/types.h> from kernel space
after this change, since it refers to <asm-generic/int-ll64.h> which
now only exists in user space, but that's ok because it would be a bug
to include already (it defines the wrong types), and we don't.

> Note that this discussion is about what to do with the remaining int-ll64.h,
> not about removing int-l64.h, which is what this patch is really about.
> So _this_ patch can just go in.

Right.

	Arnd
