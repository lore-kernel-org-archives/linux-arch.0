Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:56222 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933925AbXDATXK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 1 Apr 2007 15:23:10 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id EF240800E79
	for <linux-arch@vger.kernel.org>; Sun,  1 Apr 2007 21:23:09 +0200 (CEST)
Date: Sun, 1 Apr 2007 21:23:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: missing syscalls
Message-ID: <20070401192355.GA10208@uranus.ravnborg.org>
References: <20070401160123.GA9178@uranus.ravnborg.org> <20070401191511.GA24987@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070401191511.GA24987@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Apr 01, 2007 at 08:15:12PM +0100, Russell King wrote:
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
> 
> > <stdin>:1176:2: warning: #warning syscall fadvise64_64 not implemented
> > <stdin>:1340:2: warning: #warning syscall sync_file_range not implemented
> 
> These two are replaced by a special ARM version which sane argument
> ordering.  My patch for a previous version of the syscall check stuff
> shut these warnings up.
Should they be ignored only for arm (and arm26?) or in general?

	Sam
