From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC][PATCH 04/24] arm64: Provide atomic_{or,xor,and}
Date: Mon, 13 Jul 2015 10:29:55 +0100
Message-ID: <20150713092955.GA1612@arm.com>
References: <20150709172855.564686637@infradead.org>
 <20150709175308.361407648@infradead.org>
 <20150710084258.GA29323@arm.com>
 <20150710162356.GM19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56709 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbbGMJaE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Jul 2015 05:30:04 -0400
Content-Disposition: inline
In-Reply-To: <20150710162356.GM19282@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "vgupta@synopsys.com" <vgupta@synopsys.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>, "realmz6@gmail.com" <realmz6@gmail.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "rkuo@codeaurora.org" <rkuo@codeaurora.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "james.hogan@imgtec.com" <james.hogan@imgtec.com>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "jejb@parisc-linux.org" <jejb@parisc-linux.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "davem@davemloft.net" <davem@davemloft.net>, "cmetcalf@ezchip.com" <cmetcalf@ezchip.com>, min

On Fri, Jul 10, 2015 at 05:23:56PM +0100, Peter Zijlstra wrote:
> On Fri, Jul 10, 2015 at 09:42:59AM +0100, Will Deacon wrote:
> > On Thu, Jul 09, 2015 at 06:28:59PM +0100, Peter Zijlstra wrote:
> > > Implement atomic logic ops -- atomic_{or,xor,and}.
> > > 
> > > These will replace the atomic_{set,clear}_mask functions that are
> > > available on some archs.
> > > 
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > 
> > Whilst this is pretty straight-foward, I have some serious rework on arm64
> > atomic.h pending, so do you mind if I take this via the arm64 tree and
> > resolve the conflicts myself?
> 
> Are those public anywhere.. The thing is, at the end of this series I
> pretty much assume all archs will have these ops available, so whatever
> tree I stick the rest in woudl have to pull in your branch too.

Spammed you with the series now. Not sure you'd want to pull all that lot
via -tip, though.

> Also, IF you apply locally, do not forget to s/or/orr/ on the 64bit
> versions, I seem to have missed updating those, just like I did on 32bit
> arm.

Ok, thanks for the heads up.

Will
