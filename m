From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 12:00:10 -0700
Message-ID: <CA+55aFw8RHphGi7kAZdot_PikJGaB=FthHn8Q=1EuCVz=0gd_g@mail.gmail.com>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk> <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk> <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
 <20170513170056.GX390@ZenIV.linux.org.uk> <CA+55aFwD+qC7MqSJVt4q91YEJ7CSzAZazWAJ-NpSz=B1k95AuA@mail.gmail.com>
 <20170513180413.GZ390@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:36620 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757270AbdEMTAL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 15:00:11 -0400
In-Reply-To: <20170513180413.GZ390@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, May 13, 2017 at 11:04 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>
> My point is, this stuff needs looking at.

No.

You don't have a point. I've tried to explain that there's no
performance difference, and there is no way in hell that the current
"__" versions are better.

So what's the point in looking? All you are ever going to come up with
is theoretical "this might" cases.

The only sane forward is to just get rid of them. At that point, you
*may* end up actually noticing something, but if you do, it's not a
"you might" issue.

There's literally no upside to this "needs looking at". There are only
downsides.

And one major downside of your "needs looking at". is this one:

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Mar 2015 10:42:18 -0700
>
> So I'd suggest we should just do a wholesale replacement of
> __copy_to/from_user() with the non-underlined cases. Then, we could
> switch insividual ones back - with reasoning of why they matter, and
> with pointers to how it does access_ok() two lines before.
>
> We should probably even consider looking at __get_user/__put_user().
> Few of them are actually performance-critical.

Look at that date. It's over two years ago. In the intervening two
years, how many of those conversions have happened?

Here's a hint: it's a very very round number.

                 Linus
