From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFC][PATCH 19/24] s390: Provide atomic_{or,xor,and}
Date: Fri, 10 Jul 2015 12:52:02 +0200
Message-ID: <20150710105202.GB3905@osiris>
References: <20150709172855.564686637@infradead.org>
 <20150709175309.831326362@infradead.org>
 <20150710071709.GA3905@osiris>
 <20150710102210.GF19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:53597 "EHLO
	e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947AbbGJKwK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2015 06:52:10 -0400
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Fri, 10 Jul 2015 11:52:08 +0100
Content-Disposition: inline
In-Reply-To: <20150710102210.GF19282@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org

On Fri, Jul 10, 2015 at 12:22:10PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 10, 2015 at 09:17:09AM +0200, Heiko Carstens wrote:
> > > +static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
> > >  {
> > > -	__ATOMIC_LOOP(v, mask, __ATOMIC_OR, __ATOMIC_NO_BARRIER);
> > > +	atomic_or(mask, v);
> > >  }
> > 
> > If you insist on the __deprecated (no problem with that), I'd like to apply
> > your patch to the s390 tree so I can convert all users.
> > I would like to avoid to see tons of warnings.
> 
> See the last patch in this series, it does that conversion. Although I
> might need to double check I got them all, its been a while since I did
> that patch.

Ah right, I missed that. Then I'm happy with all the changes.
Thanks for doing this nice cleanup!
