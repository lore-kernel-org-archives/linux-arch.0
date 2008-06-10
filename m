From: Roland Dreier <rdreier@cisco.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 10 Jun 2008 12:05:55 -0700
Message-ID: <adaskvl3yb0.fsf@cisco.com>
References: <1211852026.3286.36.camel@pasglop>
	<alpine.LFD.1.10.0806031153360.3473@woody.linux-foundation.org>
	<200806101656.51211.nickpiggin@yahoo.com.au>
	<200806101041.28829.jbarnes@virtuousgeek.org>
	<1213121426.8536.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sj-iport-2.cisco.com ([171.71.176.71]:44562 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbYFJTF5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jun 2008 15:05:57 -0400
In-Reply-To: <1213121426.8536.7.camel@localhost.localdomain> (James
	Bottomley's message of "Tue, 10 Jun 2008 13:10:26 -0500")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Nick Piggin <nickpiggin@yahoo.com.au>, Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <matthew@wil.cx>, Trent Piepho <tpiepho@freescale.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org

 > me too.  That's the whole basis for readX_relaxed() and its cohorts: we
 > make our weirdest machines (like altix) conform to the x86 norm.  Then
 > where it really kills us we introduce additional semantics to selected
 > drivers that enable us to recover I/O speed on the abnormal platforms.

Except as I pointed out before, Altix doesn't conform to the norm and
many (most?) drivers are missing mmiowb()s that are needed for Altix.
Just no one has plugged most devices into an Altix (or haven't stressed
the driver in a way that exposes problems of IO ordering between CPUs).

It would be a great thing to use the powerpc trick of setting a flag
that is tested by spin_unlock()/mutex_unlock() and automatically doing
the mmiowb() if needed, and then killing off mmiowb() entirely.

 - R.
