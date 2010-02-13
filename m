From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] parisc: fix tracing of signals
Date: Sat, 13 Feb 2010 20:03:03 +0900
Message-ID: <20100213110302.GA18636@linux-sh.org>
References: <20100212155306.GI24051@bombadil.infradead.org> <alpine.LFD.2.00.1002120816100.7792@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:53814 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436Ab0BMLDN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 13 Feb 2010 06:03:13 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002120816100.7792@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kyle McMartin <kyle@mcmartin.ca>, vapier@gentoo.org, linux-parisc@vger.kernel.org, roland@redhat.com, "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org

On Fri, Feb 12, 2010 at 08:21:33AM -0800, Linus Torvalds wrote:
> On Fri, 12 Feb 2010, Kyle McMartin wrote:
> > Mike Frysinger pointed out that calling tracehook_signal_handler with
> > stepping=0 missed testing the thread flags, resulting in not calling
> > ptrace_notify. Fix this by testing if we're single stepping or branch
> > stepping and setting the flag accordingly.
> > 
> > Tested, seems to work.
> 
> Hmm. All other architectures either pass in zero, or test TIF_SINGLESTEP. 
> 
> I guess TIF_BLOCKSTEP is a parisc addition, so now parisc matches x86 and 
> power etc, but it still makes me wonder about all those other 
> architectures that pass in zero.
> 
> For the curious, that seems to be at least sparc and 64-bit (but not 
> 32-bit) sh.
> 
> David? Paul?
> 
It's a legitimate bug on sh64. We support hardware single stepping there
but never tied in the thread flags when the code was merged with 32-bit,
so this behaviour has existed for some time. I'll fix it up and send out
patches as soon as I get a chance to test it.
