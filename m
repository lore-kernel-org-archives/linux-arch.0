Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:40209
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933929AbXDATXp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Apr 2007 15:23:45 -0400
Date: Sun, 01 Apr 2007 12:23:45 -0700 (PDT)
Message-Id: <20070401.122345.123969742.davem@davemloft.net>
Subject: Re: missing syscalls
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070401191511.GA24987@flint.arm.linux.org.uk>
References: <20070401160123.GA9178@uranus.ravnborg.org>
	<20070401191511.GA24987@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: rmk@arm.linux.org.uk
Cc: sam@ravnborg.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Russell King <rmk@arm.linux.org.uk>
Date: Sun, 1 Apr 2007 20:15:12 +0100

> On Sun, Apr 01, 2007 at 06:01:23PM +0200, Sam Ravnborg wrote:
> > ============== arm ================
> >   CALL    /home/sam/kernel/kbuild.git/scripts/checksyscalls.sh
> > <stdin>:1092:2: warning: #warning syscall fadvise64 not implemented
> 
> and probably never will be.
> 
> > <stdin>:1220:2: warning: #warning syscall kexec_load not implemented
> 
> For the ARM kexec-using folk to decide.
> 
> > <stdin>:1260:2: warning: #warning syscall migrate_pages not implemented
> 
> Does this make sense for ARM?  I've no idea.

You should hook both of these syscalls up even if the config option
that enables them usually is not, or cannot currently be, enabled.

The cond_syscall()'s will make sure they always link properly and
provide a -ENOSYS implementation.

Hooking them up makes it easier to check future missed cases without
us having to add a plethora of ifdefs to the missing syscall checks
for each platform.
