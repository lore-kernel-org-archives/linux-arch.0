Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel12.hp.com ([156.153.255.237]:18591 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262960AbUCXG7r (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Mar 2004 01:59:47 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16481.12767.890321.511223@napali.hpl.hp.com>
Date: Tue, 23 Mar 2004 22:59:43 -0800
Subject: Re: signal-race-fix.patch
In-Reply-To: <200403240358.i2O3wc1n013905@magilla.sf.frob.com>
References: <16480.60017.732846.886711@napali.hpl.hp.com>
	<200403240358.i2O3wc1n013905@magilla.sf.frob.com>
Reply-To: davidm@hpl.hp.com
To: Roland McGrath <roland@redhat.com>
Cc: davidm@hpl.hp.com, Andrew Morton <akpm@osdl.org>, Corey Minyard <minyard@acm.org>, davem@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Tue, 23 Mar 2004 19:58:38 -0800, Roland McGrath <roland@redhat.com> said:

  >> Yeah, it only preseves the status quo (updating sa_handler
  >> without holding the lock) and it's presumably only a single-word
  >> store which is atomic, but it's not all that hard to imagine code
  >> that would break if sa_handler were to change underneath someone
  >> holding the sighand-> siglock.

  Roland> I can't really imagine the code that would make anything
  Roland> untoward happen in the situation where the process is being
  Roland> forced to exit with SIGSEGV anyway.

I'm not sure I can either.  The current code in kernel/signal.c
certainly looks pretty safe in that regard.  Still, if this were to
bite, it would be a nightmare to debug.  Plus the resetting of
sa_handler to SIG_DFL only happens in the exceptional case of a bad
stack frame, so it's not exactly performance-critical.

	--david
