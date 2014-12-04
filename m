From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC] locking: Add volatile to arch_spinlock_t structures
Date: Thu, 4 Dec 2014 12:12:05 -0800
Message-ID: <20141204201205.GA27787@linux.vnet.ibm.com>
References: <20141204062005.GA2553@linux.vnet.ibm.com>
 <CA+55aFzn-6asfWHB8SAvz4GJWz7uEriujgVLfaqoo_VPtNBLuA@mail.gmail.com>
 <CA+55aFxGCxQNE4HzRP_Uk2FmFDn_+Hfm6GBz75S+5+SDeODVJQ@mail.gmail.com>
 <20141204070248.GJ25340@linux.vnet.ibm.com>
 <CA+55aFxDmaA2D37Zz1Zc7y6iD6gVs=wskP5wgJb37R98aN-qmg@mail.gmail.com>
 <20141204183628.GT25340@linux.vnet.ibm.com>
 <CA+55aFzPZdk5F2q7HjTnjFq673xpZGWUtkMZFx24q8RWQE0-dg@mail.gmail.com>
 <20141204200052.GY25340@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:53721 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053AbaLDUMM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Dec 2014 15:12:12 -0500
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 4 Dec 2014 13:12:12 -0700
Content-Disposition: inline
In-Reply-To: <20141204200052.GY25340@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dmitry Vyukov <dvyukov@google.com>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>

On Thu, Dec 04, 2014 at 12:00:52PM -0800, Paul E. McKenney wrote:

[ . . . ]

> So any compiler that clobbers some adjacent non-bitfield variable or
> field that is accessible by other threads is not just despicable, it
> fails to conform to the standard.
> 
> Whew!  ;-)

And part of the reason for my confusion is that I am using an old version
of gcc, 4.6.3.  Apparently this aspect of gcc wasn't fixed until 4.7
or thereabouts.

							Thanx, Paul
