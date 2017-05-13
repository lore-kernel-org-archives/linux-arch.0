From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 18:00:56 +0100
Message-ID: <20170513170056.GX390@ZenIV.linux.org.uk>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk>
 <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk>
 <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:39926 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755393AbdEMRA6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 13:00:58 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, May 13, 2017 at 09:15:07AM -0700, Linus Torvalds wrote:
> > IOW, we have
> >         * most of users in arch/* (heavily dominated by signal-related code,
> > both loads and stores).  Those need careful massage; maybe unsafe-based
> > solution, maybe something else, but it's obviously per-architecture work
> > and these paths are sensitive.
> 
> Why are they sensitive?

Because there we do have tons of back-to-back __get_user() (on sigreturn())
or __put_user() (on signal setup).

> Why not just do this:
> 
>   git grep -l '\<__\(\(get\)\|\(put\)\)_user(' -- arch/x86
> :^arch/x86/include/asm/uaccess.h
>         | xargs sed -i 's/__\(\(\(get\)\|\(put\)\)_user(\)/\1/g'
> 
> which converts all the x86 uses in one go.

x86 actually tends to use get_user_ex/put_user_ex instead.

> Anybody who *relies* on not checking the address_limit is so broken as
> to be not even funny.

Except for open-coded probe_kernel_read() somewhere in arch/*; I have not
read through those 700+ callers, so I don't know if there's any such.
Sure, those won't be performance-sensitive.

> And anything that is so performance-sensitive
> that anybody can even measure the effect of the above we can convert
> later.

> Sure, do it in pieces (eg each architecture separately, then
> "drivers", then "networking", then whatever, until all done), just so
> that *if* something actually depends on semantics (and that really
> shouldn't be the case), we have at least some information from a
> bisect.
>
> But I don't see the excuse for not just doing it. If nobody notices,
> it's an obvious improvement. And if somebody *does* notice, we know
> how to do it properly with unsafe_xyz_user(), because "__xyz_user()"
> most definitely isn't it.

I think we ought to actually look through those places - there are few
enough of them (outside of arch/, that is) and stac/clac overhead is
not the only problem they tend to have.
