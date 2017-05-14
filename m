From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sun, 14 May 2017 20:13:56 +0200
Message-ID: <20170514181356.whn26wtc7aorpxvc@gmail.com>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk>
 <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk>
 <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36816 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbdENSOA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 May 2017 14:14:00 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, May 12, 2017 at 11:57 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > First, some stats: there's a thousand-odd callers of __get_user().  Out of
> > those, about 70% are in arch/, mostly in sigframe-related code.
> 
> Sure. And they can be trivially converted, and none of them should care at all.
> 
> > IOW, we have
> >         * most of users in arch/* (heavily dominated by signal-related code,
> > both loads and stores).  Those need careful massage; maybe unsafe-based
> > solution, maybe something else, but it's obviously per-architecture work
> > and these paths are sensitive.
> 
> Why are they sensitive?
> 
> Why not just do this:
> 
>   git grep -l '\<__\(\(get\)\|\(put\)\)_user(' -- arch/x86
> :^arch/x86/include/asm/uaccess.h
>         | xargs sed -i 's/__\(\(\(get\)\|\(put\)\)_user(\)/\1/g'
> 
> which converts all the x86 uses in one go.
> 
> Anybody who *relies* on not checking the address_limit is so broken as
> to be not even funny. And anything that is so performance-sensitive
> that anybody can even measure the effect of the above we can convert
> later.

I'd say that the CLAC/STAC addition pretty much killed any argument in favor of 
"optimized" __get_user() code, so I'd be very happy to see these interfaces gone 
altogether.

So as far as x86 usage goes:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
