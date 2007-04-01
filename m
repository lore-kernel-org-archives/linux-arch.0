Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:43771 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964873AbXDAVJl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 1 Apr 2007 17:09:41 -0400
Date: Sun, 1 Apr 2007 23:10:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: missing syscalls
Message-ID: <20070401211026.GD10761@uranus.ravnborg.org>
References: <20070401160123.GA9178@uranus.ravnborg.org> <200704012254.53224.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200704012254.53224.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Apr 01, 2007 at 10:54:53PM +0200, Andi Kleen wrote:
> 
> > ============== x86_64 ================
> >   CALL    /home/sam/kernel/kbuild.git/scripts/checksyscalls.sh
> > <stdin>:1356:2: warning: #warning syscall getcpu not implemented
> 
> It's implemented as a vsyscall.

Can I assume you take care of silence the warning?
A dummy entry in unistd will do the trick.

	Sam

