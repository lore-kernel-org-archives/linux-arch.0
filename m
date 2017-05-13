From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 21:45:46 +0100
Message-ID: <20170513204546.GI390@ZenIV.linux.org.uk>
References: <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk>
 <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
 <20170513170056.GX390@ZenIV.linux.org.uk>
 <CA+55aFwD+qC7MqSJVt4q91YEJ7CSzAZazWAJ-NpSz=B1k95AuA@mail.gmail.com>
 <20170513180413.GZ390@ZenIV.linux.org.uk>
 <CA+55aFw8RHphGi7kAZdot_PikJGaB=FthHn8Q=1EuCVz=0gd_g@mail.gmail.com>
 <20170513195659.GE390@ZenIV.linux.org.uk>
 <20170513200816.GF390@ZenIV.linux.org.uk>
 <CAMuHMdWOFci-VY6nAdgmRs+U92aoAdNakHzBNC2NBEY_W7uX6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43220 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbdEMUps (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 16:45:48 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdWOFci-VY6nAdgmRs+U92aoAdNakHzBNC2NBEY_W7uX6Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, May 13, 2017 at 10:32:31PM +0200, Geert Uytterhoeven wrote:

> You better run that one through linux-spi, to avoid conflicts, cfr.
> https://patchwork.kernel.org/patch/9714993/

What I'm going to do is never-rebased #for-spi (well, never after -rc1)
merged into #work.uaccess and proposed for pull to linux-spi.

The local tree is a mess right now - bloody lot of branches, huge unsorted
pile, etc.  This was from #unsorted, actually - should've picked the one
from #for-spi (a couple of brainos fixed in the version there)...
