From: Roland Dreier <rdreier@cisco.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Mon, 26 May 2008 21:08:10 -0700
Message-ID: <adad4n82xud.fsf@cisco.com>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117]:61694 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbYE0EIM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 27 May 2008 00:08:12 -0400
In-Reply-To: <20080526204233.75b71bb8@infradead.org> (Arjan van de Ven's
	message of "Mon, 26 May 2008 20:42:33 -0700")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Miller <davem@davemloft.net>, benh@kernel.crashing.org, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, tpiepho@freescale.com

 > either via sparse or some fancy lockdep like "device store" thing?
 > If we can't test for it and it doesn't show up on x86 ... it'll just be
 > an eterrnal chase.

Ben's point is that it will start showing up on x86 because newer
compilers are reordering things...

 - R.
