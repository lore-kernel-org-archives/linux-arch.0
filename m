Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4124 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbXDAVdm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Apr 2007 17:33:42 -0400
Date: Sun, 1 Apr 2007 22:33:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: missing syscalls
Message-ID: <20070401213335.GD24987@flint.arm.linux.org.uk>
References: <20070401160123.GA9178@uranus.ravnborg.org> <20070401191511.GA24987@flint.arm.linux.org.uk> <20070401192355.GA10208@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070401192355.GA10208@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Apr 01, 2007 at 09:23:55PM +0200, Sam Ravnborg wrote:
> On Sun, Apr 01, 2007 at 08:15:12PM +0100, Russell King wrote:
> > On Sun, Apr 01, 2007 at 06:01:23PM +0200, Sam Ravnborg wrote:
> > > ============== arm ================
> > >   CALL    /home/sam/kernel/kbuild.git/scripts/checksyscalls.sh
> > > <stdin>:1092:2: warning: #warning syscall fadvise64 not implemented
> > 
> > and probably never will be.
> > 
> > > <stdin>:1220:2: warning: #warning syscall kexec_load not implemented
> > 
> > For the ARM kexec-using folk to decide.

Actually, this is the result of a typo, and should be fixed.

> > 
> > > <stdin>:1260:2: warning: #warning syscall migrate_pages not implemented
> > 
> > Does this make sense for ARM?  I've no idea.
> > 
> > > <stdin>:1176:2: warning: #warning syscall fadvise64_64 not implemented
> > > <stdin>:1340:2: warning: #warning syscall sync_file_range not implemented
> > 
> > These two are replaced by a special ARM version which sane argument
> > ordering.  My patch for a previous version of the syscall check stuff
> > shut these warnings up.
> Should they be ignored only for arm (and arm26?) or in general?

for ARM only, as per my original patch.

+#define __IGNORE_fadvise64_64          /* we provide our own - see above */
+#define __IGNORE_sync_file_range       /* we provide our own - see above */


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
