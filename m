From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH RFC] locking: Add volatile to arch_spinlock_t structures
Date: Thu, 4 Dec 2014 21:45:46 +0000
Message-ID: <20141204214546.76b7b7cd@lxorguk.ukuu.org.uk>
References: <20141204062005.GA2553@linux.vnet.ibm.com>
	<CA+55aFzn-6asfWHB8SAvz4GJWz7uEriujgVLfaqoo_VPtNBLuA@mail.gmail.com>
	<CA+55aFxGCxQNE4HzRP_Uk2FmFDn_+Hfm6GBz75S+5+SDeODVJQ@mail.gmail.com>
	<20141204070248.GJ25340@linux.vnet.ibm.com>
	<CA+55aFxDmaA2D37Zz1Zc7y6iD6gVs=wskP5wgJb37R98aN-qmg@mail.gmail.com>
	<20141204183628.GT25340@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:58660 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbaLDVrR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Dec 2014 16:47:17 -0500
In-Reply-To: <20141204183628.GT25340@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dmitry Vyukov <dvyukov@google.com>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>

> anywhere in that translation unit.  After all, any non-static function
> in that translation unit might be called from some other translation
> unit that -did- use locking or whatever.
> 
> I will let you know how it goes.  ;-)

It breaks DEC10 ;-)

If there is kickback over things like optimisation perhaps the gcc
maintainers could at least consider something like

	int __attribute((threadsafe)) fred;

??

Alan
