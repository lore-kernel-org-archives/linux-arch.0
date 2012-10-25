Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:46327 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759830Ab2JYOZH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Oct 2012 10:25:07 -0400
Date: Thu, 25 Oct 2012 15:25:05 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] tile: support GENERIC_KERNEL_THREAD and
 GENERIC_KERNEL_EXECVE
Message-ID: <20121025142505.GK2616@ZenIV.linux.org.uk>
References: <201210192041.q9JKf7jD003998@farm-0010.internal.tilera.com>
 <20121019213548.GR2616@ZenIV.linux.org.uk>
 <5082A1F1.3080303@tilera.com>
 <20121020153401.GT2616@ZenIV.linux.org.uk>
 <20121020171643.GU2616@ZenIV.linux.org.uk>
 <5086D432.4070008@tilera.com>
 <20121023184122.GZ2616@ZenIV.linux.org.uk>
 <5086EE7C.2080608@tilera.com>
 <20121023203620.GA2616@ZenIV.linux.org.uk>
 <50893F33.10700@tilera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50893F33.10700@tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>
Message-ID: <20121025142505.iS8JvSYOKlnUPiCODJKSTXpIa4PvcknL6LPlg4wxqeQ@z>

On Thu, Oct 25, 2012 at 09:31:31AM -0400, Chris Metcalf wrote:
> On 10/23/2012 4:36 PM, Al Viro wrote:
> > Could you test the following on top of your patch?  It gets rid of
> > regs use in sys_clone() *and* of the regs argument in copy_thread().
> > If that work (including SMP - note that it changes the path taken
> > by copy_thread() when called by fork_idle()), that should be all
> > we'll need in arch/tile for killing idle_regs() and killing the pt_regs
> > passing to do_fork()/copy_process()/copy_thread().
> 
> It seems to work fine.  Thanks!

Thanks.  Put into no-rebase mode.
