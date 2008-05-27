From: Roland Dreier <rdreier@cisco.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 27 May 2008 15:39:07 -0700
Message-ID: <adaabibs778.fsf@cisco.com>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<20080526204233.75b71bb8@infradead.org>
	<1211872130.3286.64.camel@pasglop> <adaprr721c6.fsf@cisco.com>
	<1211922696.3286.82.camel@pasglop> <adaiqwzsa83.fsf@cisco.com>
	<1211926410.3286.95.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sj-iport-5.cisco.com ([171.68.10.87]:9725 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756969AbYE0WjJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 27 May 2008 18:39:09 -0400
In-Reply-To: <1211926410.3286.95.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Wed, 28 May 2008 08:13:30 +1000")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: Arjan van de Ven <arjan@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com, torvalds@linux-foundation.org, David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk

 > > Cool... I assume you do this for mutex_unlock() etc?

 > That's a good point... I don't think we do. Maybe we should.

I think it's needed -- take a look at 76d7cc03, which came from a real
bug seen on Altix boxes.
