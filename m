Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel12.hp.com ([156.153.255.237]:64998 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264983AbUFGSdE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2004 14:33:04 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16580.46291.263003.920018@napali.hpl.hp.com>
Date: Mon, 7 Jun 2004 11:32:51 -0700
Subject: Re: [patch 2.6] __ARCH_WANT_SYS_RT_SIGACTION
In-Reply-To: <20040606135512.A12219@jurassic.park.msu.ru>
References: <20040604131926.A791@jurassic.park.msu.ru>
	<16576.65181.551817.333709@napali.hpl.hp.com>
	<20040606135512.A12219@jurassic.park.msu.ru>
Reply-To: davidm@hpl.hp.com
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: davidm@hpl.hp.com, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Sun, 6 Jun 2004 13:55:12 +0400, Ivan Kokshaysky <ink@jurassic.park.msu.ru> said:

  Ivan> On Fri, Jun 04, 2004 at 03:58:37PM -0700, David Mosberger wrote:

  >> Can you confirm that it builds on Alpha again as well?

  Ivan> No, it doesn't.
  Ivan> In fact, it was the very change that broke Alpha - we have
  Ivan> alpha-specific versions of *both* sys_sigprocmask() and
  Ivan> sys_rt_sigaction().
  Ivan> The patch still applies to today's bk tree.

Ah, I misunderstood the problem---the patch seems fine to me, then.

	--david
