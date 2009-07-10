From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/2] sched: INIT_PREEMPT_COUNT
Date: Fri, 10 Jul 2009 15:18:13 -0600
Message-ID: <200907101518.13894.bjorn.helgaas@hp.com>
References: <20090710125755.559739294@chello.nl> <20090710130125.037018244@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:46576 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbZGJVST (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2009 17:18:19 -0400
In-Reply-To: <20090710130125.037018244@chello.nl>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Matt Mackall <mpm@selenic.com>, Anton Vorontsov <avorontsov@ru.mvista.com>, Andrew Morton <akpm@linux-foundation.org>, oleg@redhat.com, mingo@elte.hu, tony.luck@intel.com, rth@twiddle.net, geert@linux-m68k.org

On Friday 10 July 2009 06:57:56 am Peter Zijlstra wrote:
> +#define INIT_PREEMPT_COUNT=A0=A0=A0=A0=A0(1)

If the parentheses are useful or necessary, I need to be
educated about why.  They look like superfluous paranoia to me.
