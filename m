Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel10.hp.com ([156.153.255.245]:24526 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S266044AbUFDW6o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2004 18:58:44 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16576.65181.551817.333709@napali.hpl.hp.com>
Date: Fri, 4 Jun 2004 15:58:37 -0700
Subject: Re: [patch 2.6] __ARCH_WANT_SYS_RT_SIGACTION
In-Reply-To: <20040604131926.A791@jurassic.park.msu.ru>
References: <20040604131926.A791@jurassic.park.msu.ru>
Reply-To: davidm@hpl.hp.com
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Fri, 4 Jun 2004 13:19:26 +0400, Ivan Kokshaysky <ink@jurassic.park.msu.ru> said:

  Ivan> Recent syscall stubs cleanup broke alpha, as it has its own
  Ivan> version of sys_rt_sigaction().  This defines
  Ivan> __ARCH_WANT_SYS_RT_SIGACTION for all architectures except
  Ivan> alpha, sparc and sparc64.

Sorry, that was my bad (obviously).  I think the real problem is that
the closing #endif for __ARCH_WANT_SYS_SIGPROCMASK came too late (by
one function), so that sys_rt_sigaction() was accidentally left out if
this macro wasn't defined.  The problem was fixed in Linus' tree
yesterday.  Can you confirm that it builds on Alpha again as well?

Thanks,

	--david
