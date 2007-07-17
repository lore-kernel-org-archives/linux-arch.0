Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:51346 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757368AbXGQSKc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jul 2007 14:10:32 -0400
Date: Tue, 17 Jul 2007 19:10:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch 041/234] Report that kernel is tainted if there was an OOPS
Message-ID: <20070717181003.GA16147@flint.arm.linux.org.uk>
References: <200707171103.l6HB3gDf013411@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200707171103.l6HB3gDf013411@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, xemul@openvz.org, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jul 17, 2007 at 04:03:42AM -0700, akpm@linux-foundation.org wrote:
> From: Pavel Emelianov <xemul@openvz.org>
> 
> If the kernel OOPSed or BUGed then it probably should be considered as
> tainted.  Thus, all subsequent OOPSes and SysRq dumps will report the
> tainted kernel.  This saves a lot of time explaining oddities in the
> calltraces.

A bug causes an oops.  Oops are counted.  So, why do we need this
additional complexity when we already have the '#' counter in oops
dumps?

For instance, on ARM:

Unable to handle kernel NULL pointer dereference at virtual address 00000090
pgd = c0004000
[00000090] *pgd=00000000
Internal error: Oops: 817 [#1]
                          ^^^^
This is the oops counter.  Anything oops report from anyone other than the
first should always be questioned.  Also note that this counter is not
re-settable at run time, unlike the taint flags.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
