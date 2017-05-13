From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 20:17:04 +0100
Message-ID: <20170513191704.GC390@ZenIV.linux.org.uk>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk>
 <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk>
 <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
 <20170513170056.GX390@ZenIV.linux.org.uk>
 <CA+55aFwD+qC7MqSJVt4q91YEJ7CSzAZazWAJ-NpSz=B1k95AuA@mail.gmail.com>
 <20170513180413.GZ390@ZenIV.linux.org.uk>
 <CA+55aFw8RHphGi7kAZdot_PikJGaB=FthHn8Q=1EuCVz=0gd_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:42002 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbdEMTRG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 15:17:06 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFw8RHphGi7kAZdot_PikJGaB=FthHn8Q=1EuCVz=0gd_g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, May 13, 2017 at 12:00:10PM -0700, Linus Torvalds wrote:
> On Sat, May 13, 2017 at 11:04 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >
> > My point is, this stuff needs looking at.
> 
> No.
> 
> You don't have a point. I've tried to explain that there's no
> performance difference, and there is no way in hell that the current
> "__" versions are better.
> 
> So what's the point in looking? All you are ever going to come up with
> is theoretical "this might" cases.

Umm...  Just during this subthread - a couple of likely breakages in
xen (which would need looking into, right?) and "oopsen on alpha would
stop actually printing code", which is better to spot early.  The first
one might be theoretical, but it's worth giving heads-up to xen folks;
I'm fairly sure that this spot will break.  The second is not theoretical
at all - it *will* break.
