From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 20:34:25 +0100
Message-ID: <20170513193424.GD390@ZenIV.linux.org.uk>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk>
 <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk>
 <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
 <20170513170056.GX390@ZenIV.linux.org.uk>
 <CA+55aFwD+qC7MqSJVt4q91YEJ7CSzAZazWAJ-NpSz=B1k95AuA@mail.gmail.com>
 <20170513180413.GZ390@ZenIV.linux.org.uk>
 <20170513182656.GA390@ZenIV.linux.org.uk>
 <20170513191142.GB390@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:42266 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753502AbdEMTe0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 15:34:26 -0400
Content-Disposition: inline
In-Reply-To: <20170513191142.GB390@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, May 13, 2017 at 08:11:42PM +0100, Al Viro wrote:
> It's not impossible to review; the problem is in figuring out which codepaths
> are hot enough to worry about them.  And I'm even more convinced that
> bulk search-and-replace is the right approach here; we probably _can_ get
			    ^- not
apologies for sloppy editing...

> rid of that shit this cycle (or, at least, reduce its use to very few places
> in arch/*), but that'll require some cooperation from architecture maintainers.
