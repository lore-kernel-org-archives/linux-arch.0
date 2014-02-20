From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 0/5] arch: atomic rework
Date: Thu, 20 Feb 2014 10:56:42 -0800
Message-ID: <20140220185642.GY4250@linux.vnet.ibm.com>
References: <1392740258.18779.7732.camel@triegel.csb>
 <CA+55aFw7QYEMFs0BCxqRJW3Cz=tLbaku-tmN6hLXPKP9jbom7Q@mail.gmail.com>
 <1392752867.18779.8120.camel@triegel.csb>
 <CA+55aFxQPxQ8WOaZL8yAqBA=Y4k2gDn4r4oepMyi0uL6XLzv3w@mail.gmail.com>
 <20140220040102.GM4250@linux.vnet.ibm.com>
 <CA+55aFwwscSzwTr+xRdirtTx7HzugmMY9HrDe0GBqNhn=AuNVA@mail.gmail.com>
 <20140220083032.GN4250@linux.vnet.ibm.com>
 <CA+55aFwfx==u7o1NZ66aPbkOgsvGqW3UscGqrQkGuzOkjSpm6Q@mail.gmail.com>
 <20140220181116.GT4250@linux.vnet.ibm.com>
 <1392921872.18779.10287.camel@triegel.csb>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:50492 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbaBTS4r (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2014 13:56:47 -0500
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 20 Feb 2014 11:56:47 -0700
Content-Disposition: inline
In-Reply-To: <1392921872.18779.10287.camel@triegel.csb>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Torvald Riegel <triegel@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>

On Thu, Feb 20, 2014 at 07:44:32PM +0100, Torvald Riegel wrote:
> xagsmtp3.20140220184514.1789@bldgate.vnet.ibm.com
> X-Xagent-Gateway: bldgate.vnet.ibm.com (XAGSMTP3 at BLDGATE)
> 
> On Thu, 2014-02-20 at 10:11 -0800, Paul E. McKenney wrote:
> > But yes, the compiler guys would be extremely happy to simply drop
> > memory_order_consume from the standard, as it is the memory order
> > that they most love to hate.
> > 
> > Getting them to agree to any sort of peep-hole optimization semantics
> > for memory_order_consume is likely problematic.  
> 
> I wouldn't be so pessimistic about that.  If the transformations can be
> shown to be always correct in terms of the semantics specified in the
> standard, and if the performance win is sufficiently large, why not?  Of
> course, somebody has to volunteer to actually implement it :)

I guess that there is only one way to find out.  ;-)

							Thanx, Paul
