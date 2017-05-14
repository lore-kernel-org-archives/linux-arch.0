From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sun, 14 May 2017 19:57:34 +0100
Message-ID: <20170514185734.GL390@ZenIV.linux.org.uk>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk>
 <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk>
 <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
 <20170514181356.whn26wtc7aorpxvc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:59276 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbdENS5g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 May 2017 14:57:36 -0400
Content-Disposition: inline
In-Reply-To: <20170514181356.whn26wtc7aorpxvc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sun, May 14, 2017 at 08:13:56PM +0200, Ingo Molnar wrote:

> I'd say that the CLAC/STAC addition pretty much killed any argument in favor of 
> "optimized" __get_user() code, so I'd be very happy to see these interfaces gone 
> altogether.

You and everybody else - these interfaces suck.  If anything, we want paired
brackets around a series of accesses instead of a single check in front of it.

> So as far as x86 usage goes:
> 
>   Acked-by: Ingo Molnar <mingo@kernel.org>

Umm...  Could you elaborate the situation with xen/page.h stuff?  I don't
see any obvious reasons that would guaratee that addresses passed to
__get_user() and __put_user() there would match the set_fs() state.

It might very well be true, but it's not obvious from that code...

BTW, does anybody have a suggestion regarding a test load that would hit
wait4/waitid as hard as possible?  I've turned sys_wait4/sys_waitid into
long kernel_wait4(pid_t upid, int *stat_addr, int options, struct rusage *ru)
and
static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
                int options, struct rusage *ru)
(with struct waitid_info {
        pid_t pid;
        uid_t uid;
        int status;   
        int why;
};), so that all copying to userland is done in sys_wait4() and friends.
It seems to survive testing without any noticable slowdowns, but that's
just LTP and xfstests - and a bug in my earlier version of that was _not_
caught by the LTP side; xfstests caught it...  So any extra tests (both
for correctness and timing) would be very much appreciated...
