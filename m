Return-Path: <ink@jurassic.park.msu.ru>
Received: from jurassic.park.msu.ru ([195.208.223.243]:62850 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263185AbUFFJzP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 6 Jun 2004 05:55:15 -0400
Date: Sun, 6 Jun 2004 13:55:12 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [patch 2.6] __ARCH_WANT_SYS_RT_SIGACTION
Message-ID: <20040606135512.A12219@jurassic.park.msu.ru>
References: <20040604131926.A791@jurassic.park.msu.ru> <16576.65181.551817.333709@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16576.65181.551817.333709@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Fri, Jun 04, 2004 at 03:58:37PM -0700
To: davidm@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Jun 04, 2004 at 03:58:37PM -0700, David Mosberger wrote:
> Sorry, that was my bad (obviously).  I think the real problem is that
> the closing #endif for __ARCH_WANT_SYS_SIGPROCMASK came too late (by
> one function), so that sys_rt_sigaction() was accidentally left out if
> this macro wasn't defined.  The problem was fixed in Linus' tree
> yesterday.  Can you confirm that it builds on Alpha again as well?

No, it doesn't.
In fact, it was the very change that broke Alpha - we have
alpha-specific versions of *both* sys_sigprocmask() and
sys_rt_sigaction().
The patch still applies to today's bk tree.

Ivan.
