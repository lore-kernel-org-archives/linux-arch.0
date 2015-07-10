From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 19/24] s390: Provide atomic_{or,xor,and}
Date: Fri, 10 Jul 2015 13:28:42 +0200
Message-ID: <20150710112842.GW18673@twins.programming.kicks-ass.net>
References: <20150709172855.564686637@infradead.org>
 <20150709175309.831326362@infradead.org>
 <20150710071709.GA3905@osiris>
 <20150710102210.GF19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:39682 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393AbbGJL2w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2015 07:28:52 -0400
Content-Disposition: inline
In-Reply-To: <20150710102210.GF19282@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org

On Fri, Jul 10, 2015 at 12:22:10PM +0200, Peter Zijlstra wrote:
> > If you insist on the __deprecated (no problem with that), I'd like to apply
> > your patch to the s390 tree so I can convert all users.
> > I would like to avoid to see tons of warnings.
> 
> See the last patch in this series, it does that conversion. Although I
> might need to double check I got them all, its been a while since I did
> that patch.

There were indeed a few stray ones, cleaned them up too.

That grep also found a whole new architecture... somehow I missed h8300,
sorted that too.
