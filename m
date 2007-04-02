Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:55783 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934008AbXDBMbT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Apr 2007 08:31:19 -0400
Date: Mon, 2 Apr 2007 06:31:16 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: missing syscalls
Message-ID: <20070402123116.GE826@parisc-linux.org>
References: <20070401160123.GA9178@uranus.ravnborg.org> <200704012254.53224.ak@suse.de> <20070401211026.GD10761@uranus.ravnborg.org> <200704020758.51196.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200704020758.51196.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Apr 02, 2007 at 07:58:51AM +0200, Andi Kleen wrote:
> On Sunday 01 April 2007 23:10, Sam Ravnborg wrote:
> > On Sun, Apr 01, 2007 at 10:54:53PM +0200, Andi Kleen wrote:
> > > 
> > > > ============== x86_64 ================
> > > >   CALL    /home/sam/kernel/kbuild.git/scripts/checksyscalls.sh
> > > > <stdin>:1356:2: warning: #warning syscall getcpu not implemented
> > > 
> > > It's implemented as a vsyscall.
> > 
> > Can I assume you take care of silence the warning?
> > A dummy entry in unistd will do the trick.
> 
> As Arnd points out that would break reasonable user space checks.

Actually, this specific case would also be wrong -- you wouldn't want
programs to return -1, you'd want them to call the vsyscall.
