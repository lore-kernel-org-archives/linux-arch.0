From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH v2] Add preadv and pwritev system calls.
Date: Fri, 12 Dec 2008 19:07:28 +0000
Message-ID: <20081212190728.GC5774@flint.arm.linux.org.uk>
References: <1229090440-32120-1-git-send-email-kraxel@redhat.com> <20081212152929.GM26095@parisc-linux.org> <494287D4.2070909@redhat.com> <20081212155113.GO26095@parisc-linux.org> <49428AFD.5090009@redhat.com> <20081212182929.GA9631@pendragon.3leafnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38081 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbYLLTNG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Dec 2008 14:13:06 -0500
Content-Disposition: inline
In-Reply-To: <20081212182929.GA9631@pendragon.3leafnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Scott Lurndal <scott.lurndal@3leafsystems.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>

On Fri, Dec 12, 2008 at 10:29:29AM -0800, Scott Lurndal wrote:
> On Fri, Dec 12, 2008 at 05:02:05PM +0100, Gerd Hoffmann wrote:
> > Matthew Wilcox wrote:
> > > On the other hand, NetBSD have approximately 0% market share.
> > > We shouldn't let them lock us into making a bad decision.  Is there
> > > anyone other than NetBSD who has added these syscalls?
> > 
> > Free- and OpenBSD have it too.  For Solaris I've found a feature request
> > only.  Dunno about MacOS/Darwin.  Other un*xes which are important these
> > days?
> > 
> > I'd *really* hate it to have the same system call with different
> > argument ordering on different systems though.  Especially when swapping
> > two integer values, so gcc wouldn't error out on wrong usage.
> 
> I would suggest that from the end-users perspective, the user-mode API
> should be similar to pread/pwrite, e.g:
> 
>     int preadv(fd, iovec, iovec_size, offset)

Yes, and that's easy for glibc to achieve.

What's hard is that the user <-> kernel API firstly has a limited number
of registers available to it for passing arguments without indirection
from user space into kernel space.

Secondly, the user <-> kernel argument register allocation can vary
depending on the ABI version which user space or kernel space is built
for.  On ARM we have two ABIs, one where 64-bit arguments can be placed
in any two consecutive registers, and one where 64-bit arguments must
be placed in an even,odd register pair (not an odd,even pair.)

That leads to the above being:

fd	r0	r0
iovec	r1	r1
vecsz	r2	r2
offset	r3,r4	r4,r5

Notice the different register allocation for the 64-bit offset.

This problem of register-aligned argument placement is not limited
to just ARM, but several other Linux supported architectures.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
