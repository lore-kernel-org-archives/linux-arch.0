Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3012 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933921AbXDATPU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Apr 2007 15:15:20 -0400
Date: Sun, 1 Apr 2007 20:15:12 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: missing syscalls
Message-ID: <20070401191511.GA24987@flint.arm.linux.org.uk>
References: <20070401160123.GA9178@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070401160123.GA9178@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Apr 01, 2007 at 06:01:23PM +0200, Sam Ravnborg wrote:
> ============== arm ================
>   CALL    /home/sam/kernel/kbuild.git/scripts/checksyscalls.sh
> <stdin>:1092:2: warning: #warning syscall fadvise64 not implemented

and probably never will be.

> <stdin>:1220:2: warning: #warning syscall kexec_load not implemented

For the ARM kexec-using folk to decide.

> <stdin>:1260:2: warning: #warning syscall migrate_pages not implemented

Does this make sense for ARM?  I've no idea.

> <stdin>:1176:2: warning: #warning syscall fadvise64_64 not implemented
> <stdin>:1340:2: warning: #warning syscall sync_file_range not implemented

These two are replaced by a special ARM version which sane argument
ordering.  My patch for a previous version of the syscall check stuff
shut these warnings up.

> <stdin>:1316:2: warning: #warning syscall pselect6 not implemented
> <stdin>:1320:2: warning: #warning syscall ppoll not implemented
> <stdin>:1360:2: warning: #warning syscall epoll_pwait not implemented

Maybe sometime in the future.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
