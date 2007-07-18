Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:59553 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbXGRHRR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jul 2007 03:17:17 -0400
Date: Wed, 18 Jul 2007 08:16:58 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch 041/234] Report that kernel is tainted if there was an OOPS
Message-ID: <20070718071658.GA30270@flint.arm.linux.org.uk>
References: <200707171103.l6HB3gDf013411@imap1.linux-foundation.org> <20070717181003.GA16147@flint.arm.linux.org.uk> <469DA543.2030601@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469DA543.2030601@openvz.org>
Sender: linux-arch-owner@vger.kernel.org
To: Pavel Emelianov <xemul@openvz.org>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, Jul 18, 2007 at 09:29:39AM +0400, Pavel Emelianov wrote:
> Russell King wrote:
> >On Tue, Jul 17, 2007 at 04:03:42AM -0700, akpm@linux-foundation.org wrote:
> >>From: Pavel Emelianov <xemul@openvz.org>
> >>
> >>If the kernel OOPSed or BUGed then it probably should be considered as
> >>tainted.  Thus, all subsequent OOPSes and SysRq dumps will report the
> >>tainted kernel.  This saves a lot of time explaining oddities in the
> >>calltraces.
> >
> >A bug causes an oops.  Oops are counted.  So, why do we need this
> >additional complexity when we already have the '#' counter in oops
> >dumps?
> >
> >For instance, on ARM:
> >
> >Unable to handle kernel NULL pointer dereference at virtual address 
> >00000090
> >pgd = c0004000
> >[00000090] *pgd=00000000
> >Internal error: Oops: 817 [#1]
> >                          ^^^^
> >This is the oops counter.  Anything oops report from anyone other than the
> >first should always be questioned.  Also note that this counter is not
> >re-settable at run time, unlike the taint flags.
> >
> 
> Press SysRq-P and you won't see any oops-counters, but just the info that 
> the kernel is tainted. This is helpful to know that kernel oopsed when
> observing the SysRq-p output. This is just one of the reasons.

Maybe it'd make more sense to print the oops counter in places where
the tainted status is printed?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
