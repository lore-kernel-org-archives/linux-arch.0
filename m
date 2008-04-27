Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.183]:57755 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763404AbYD0UPo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 Apr 2008 16:15:44 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: microblaze syscall list
Date: Sun, 27 Apr 2008 22:15:31 +0200
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <4813DF3E.6080800@itee.uq.edu.au> <4814A153.3040600@seznam.cz>
In-Reply-To: <4814A153.3040600@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-ID: <200804272215.32862.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: microblaze-uclinux@itee.uq.edu.au, Matthew Wilcox <matthew@wil.cx>, Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, git@xilinx.com, John Williams <john.williams@petalogix.com>, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, John Linn <John.Linn@xilinx.com>
Message-ID: <20080427201531.78ksP5_UzdSAoou0zHzo4xvnxkzOr6Sas0LsqeAbJ1A@z>

On Sunday 27 April 2008, Michal Simek wrote:
> Arnd commented current syscall table and send me long email about(Thanks again).
> On the base on this email I did converted table for future use - for porting old
> application to new version. Below is my table with syscalls and there is a short
> description. (or http://www.monstr.eu/wiki/doku.php?id=kernel:syscall)
> 
> I counted how big impact will be syscall change to programs which are in John W
> distribution
> all programs
> mknod - 174
> rmdir - 488
> mkdir - 1128
> symlink - 404
> rename - 1536
> access - 1664
> chmod -  1122
> open - 22583 (crazy)
> ipc - 26
> 
> Only busybox
> open - 667
> chmod 44
> access 52
> rename 32
> symlink 8
> mkdir 19
> rmdir 9
> mknod 16
> 
> I thing you understand that we can't change all application per night. This is
> not possible. But we have to start with change this.

Note that the only thing you should need to change is the libc implementation
(any version of it: glibc, uclibc, klibc, ...), but not any application source
code, as the applications just call the functions that are defined in the libc.
If you have binaries that are statically linked with their libc, you'd have
to recompile or at least relink them. If you redefine data structures or
types that are used in application code, like struct stat or off_t, you
also need to recompile all user code.

Of course, as Alan and others have mentioned, even without changing any
application source code, the amount of work for that is significantly more 
than just changing the kernel.

I think you have three options here:

1. Keep the old syscall interface and just add new syscalls for the stuff
that you are currently missing. Don't change userspace at all, but live
with somewhat bloated kernels and libc forever and maintain a larger
code base in the kernel.

2. Change the syscall interface in the kernel in the way we have discussed,
and adapt the libc code along with it. Break all backwards compatibility
and start out with a new leaner ABI. Old applications can still use
your old out-of-tree kernels, or forks of that.

3. Merge only the ABI as in 2. into the mainline kernel, but use new
syscall numbers for that. Maintain an out-of-tree patch that adds the
old ABI for backwards compatibility so you can run old and new code
on one kernel if you build with that patch, but eventually phase
out the old ABI.

I won't try to force you to go either route, it's your own decision,
but you should understand the tradeoffs. I don't think there is any
value in trying to deprecate just part of the ABI and break some
binaries but not others, this will only cause hard to find bugs. Make
sure that if you decide to break backwards compatibility, you break it
in an obvious way and get the most benefit out of it.

	Arnd <><
