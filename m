From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 13:52:29 -0700
Message-ID: <CA+55aFyozYzFGoW4gg=7xMquY3T7us9MEn7Nu4-SMwUfMZ3-gQ@mail.gmail.com>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk> <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk> <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
 <20170513170056.GX390@ZenIV.linux.org.uk> <CA+55aFwD+qC7MqSJVt4q91YEJ7CSzAZazWAJ-NpSz=B1k95AuA@mail.gmail.com>
 <20170513180413.GZ390@ZenIV.linux.org.uk> <CA+55aFw8RHphGi7kAZdot_PikJGaB=FthHn8Q=1EuCVz=0gd_g@mail.gmail.com>
 <20170513203703.GG390@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36008 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758426AbdEMUwa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 16:52:30 -0400
In-Reply-To: <20170513203703.GG390@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, May 13, 2017 at 1:37 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> That's a valid point and it might apply to memdup_user() callers out there.
> Potential variants:
>         * add an explicit upper bound on the size and turn that into
> memdup_user() (and check that all memdup_user() callers are bounded).
>         * have memdup_user() itself pass __GFP_NOWARN.
>         * add kvmemdup_user() that would use kvmalloc() (with its callers
> expected to use kvfree()); see who else might benefit from conversion.

All of the above sound reasonable.

I wouldn't change the existing "memdup_user()" interface itself, but
if there really are users that can validly pass in a maxbyte value,
why not add a new helper:

  void *memdup_user_limit(userptr, nmember, nsize, maxsize);

and then have

  #define memdup_user(ptr,size) memdup_user_limit(ptr, size, 1, -1)

or something. I definitely see a couple of memdup_user() people who do
that "num*size" multiplication by hand, and it's very easy to get
wrong and have an overflow.

And for a kvmalloc/kvfree() interface, you *definitely* want that
maxsize thing, since it absolutely needs an upper limit.

             Linus
