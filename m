Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42484 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933430AbXDBF7F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Apr 2007 01:59:05 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: missing syscalls
Date: Mon, 2 Apr 2007 07:58:51 +0200
References: <20070401160123.GA9178@uranus.ravnborg.org> <200704012254.53224.ak@suse.de> <20070401211026.GD10761@uranus.ravnborg.org>
In-Reply-To: <20070401211026.GD10761@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704020758.51196.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sunday 01 April 2007 23:10, Sam Ravnborg wrote:
> On Sun, Apr 01, 2007 at 10:54:53PM +0200, Andi Kleen wrote:
> > 
> > > ============== x86_64 ================
> > >   CALL    /home/sam/kernel/kbuild.git/scripts/checksyscalls.sh
> > > <stdin>:1356:2: warning: #warning syscall getcpu not implemented
> > 
> > It's implemented as a vsyscall.
> 
> Can I assume you take care of silence the warning?
> A dummy entry in unistd will do the trick.

As Arnd points out that would break reasonable user space checks.

-Andi
