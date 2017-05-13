From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 20:56:59 +0100
Message-ID: <20170513195659.GE390@ZenIV.linux.org.uk>
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
Received: from zeniv.linux.org.uk ([195.92.253.2]:42568 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758366AbdEMT5B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 15:57:01 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFw8RHphGi7kAZdot_PikJGaB=FthHn8Q=1EuCVz=0gd_g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, May 13, 2017 at 12:00:10PM -0700, Linus Torvalds wrote:
> > We should probably even consider looking at __get_user/__put_user().
> > Few of them are actually performance-critical.
> 
> Look at that date. It's over two years ago. In the intervening two
> years, how many of those conversions have happened?
> 
> Here's a hint: it's a very very round number.

FWIW, just this cycle (this one I remembered off-hand, there might be
more):

commit edb88cef0570914375d461107759cf0d6d677ed5
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Sat Apr 22 00:02:31 2017 +0200

    scsi: pmcraid: use normal copy_from_user
    
    As pointed out by Al Viro for my previous series, the driver has no need
    to call access_ok() and __copy_from_user()/__copy_to_user(). Changing
    it to regular copy_from_user()/copy_to_user() simplifies the code without
    any real downsides, making it less error-prone at best.
    
    This patch by itself also addresses the warning about the access_ok()
    macro on MIPS, but both fixes improve the code, so ideally we apply
    them both.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    Reviewed-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
