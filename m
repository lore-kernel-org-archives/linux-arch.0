Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:14532 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S932186AbWJERc0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 5 Oct 2006 13:32:26 -0400
Date: Thu, 5 Oct 2006 11:32:25 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] Centralise definitions of sector_t and blkcnt_t
Message-ID: <20061005173225.GC2563@parisc-linux.org>
References: <11600678512429-git-send-email-matthew@wil.cx> <45253F27.7080707@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45253F27.7080707@garzik.org>
Sender: linux-arch-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Oct 05, 2006 at 01:21:43PM -0400, Jeff Garzik wrote:
> Matthew Wilcox wrote:
> >CONFIG_LBD and CONFIG_LSF are spread into asm/types.h for no particularly
> >good reason.  Centralising the definition in linux/types.h means that arch
> >maintainers don't need to bother adding it, as well as fixing the problem
> >with x86-64 users being asked to make a decision that has absolutely no
> >effect.  The H8/300 porters seem particularly confused since I'm not aware
> >of any microcontrollers that need to support 2TB filesystems these days.
> >
> >Signed-off-by: Matthew Wilcox <matthew@wil.cx>
> 
> Doesn't look like 2.6.19-rc1 material to me...
> 
> The only apparently "problem" has no real effect, according to you.

Huh?  It adds LBD/LSF support to a bunch of architectures that haven't
noticed that they needed to do anything.  It stops annoying X86_64 users
with a question that has no effect.  It reduces memory consumption for
the h8/300 port.

It's been submitted before.  I had thought it was in a tree that Linus
had pulled, but upon reviewing the diff, found out it was one of the
patches that got left out.  It was even in -mm for a while, but got
chucked out due to rejects.

Why are you opposed to it going in after -rc1?  This seems like the
ideal time to make this kind of change -- the mad merge rush is over and
patches which touch a lot of files and have a high probability of
causing rejects should go in at this point, IMO.  See also the
discussion around the pt_regs removal from interrupt handlers.
