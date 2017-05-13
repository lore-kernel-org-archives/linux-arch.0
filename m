From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 21:37:03 +0100
Message-ID: <20170513203703.GG390@ZenIV.linux.org.uk>
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
Received: from zeniv.linux.org.uk ([195.92.253.2]:43114 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754533AbdEMUhF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 16:37:05 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFw8RHphGi7kAZdot_PikJGaB=FthHn8Q=1EuCVz=0gd_g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, May 13, 2017 at 12:00:10PM -0700, Linus Torvalds wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Tue, 24 Mar 2015 10:42:18 -0700
> >
> > So I'd suggest we should just do a wholesale replacement of
> > __copy_to/from_user() with the non-underlined cases. Then, we could
> > switch insividual ones back - with reasoning of why they matter, and
> > with pointers to how it does access_ok() two lines before.
> >
> > We should probably even consider looking at __get_user/__put_user().
> > Few of them are actually performance-critical.
> 
> Look at that date. It's over two years ago. In the intervening two
> years, how many of those conversions have happened?

Speaking of killing that kind of crap off: there was a question left from the
last cycle that hadn't been sorted out.

SCTP does this in a couple of places:
        /* Check the user passed a healthy pointer.  */
        if (unlikely(!access_ok(VERIFY_READ, addrs, addrs_size)))
                return -EFAULT;

        /* Alloc space for the address array in kernel memory.  */
        kaddrs = kmalloc(addrs_size, GFP_USER | __GFP_NOWARN);
        if (unlikely(!kaddrs))
                return -ENOMEM;

        if (__copy_from_user(kaddrs, addrs, addrs_size)) {
                kfree(kaddrs);
                return -EFAULT;
        }
instead of memdup_user().  Part of the rationale is pretty weak (access_ok()
as sanity check to prevent user-triggerable attempts to allocate too much -
it still can trivially trigger 2G, so it's not worth much), part is more
interesting.  Namely, that whining into the syslog shouldn't be that easy
to trigger.

That's a valid point and it might apply to memdup_user() callers out there.
Potential variants:
	* add an explicit upper bound on the size and turn that into
memdup_user() (and check that all memdup_user() callers are bounded).
	* have memdup_user() itself pass __GFP_NOWARN.
	* add kvmemdup_user() that would use kvmalloc() (with its callers
expected to use kvfree()); see who else might benefit from conversion.

Preferences?
