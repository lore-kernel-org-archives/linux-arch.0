Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:49314 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbaBZS1w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2014 13:27:52 -0500
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 26 Feb 2014 11:27:51 -0700
Date: Wed, 26 Feb 2014 10:27:47 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 0/5] arch: atomic rework
Message-ID: <20140226182747.GM8264@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <CA+55aFwfx==u7o1NZ66aPbkOgsvGqW3UscGqrQkGuzOkjSpm6Q@mail.gmail.com>
 <20140220181116.GT4250@linux.vnet.ibm.com>
 <CA+55aFwn9gXWVq_GL=tPPP63vsqs-9QB4ii4s06xqG4UscCV5w@mail.gmail.com>
 <20140220185608.GX4250@linux.vnet.ibm.com>
 <CA+55aFw4inow5B-JAg-NtZigJ90yDbksddr00RoMKytzDAEa8A@mail.gmail.com>
 <20140220221027.GC4250@linux.vnet.ibm.com>
 <CA+55aFxp7U67R0PARaUfj94y5dJ8q6_HQ2pnbQ6=JD=XR-bTOw@mail.gmail.com>
 <alpine.LNX.2.00.1402211847290.7694@wotan.suse.de>
 <20140221191318.GK4250@linux.vnet.ibm.com>
 <1393419870.28840.8680.camel@triegel.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1393419870.28840.8680.camel@triegel.csb>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Torvald Riegel <triegel@redhat.com>
Cc: Michael Matz <matz@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
Message-ID: <20140226182747.vRd_ooMl1_ih-KR199La2Xigj8Dmi5814_RypWj8jt8@z>

On Wed, Feb 26, 2014 at 02:04:30PM +0100, Torvald Riegel wrote:
> xagsmtp2.20140226130517.3625@vmsdvma.vnet.ibm.com
> X-Xagent-Gateway: vmsdvma.vnet.ibm.com (XAGSMTP2 at VMSDVMA)
> 
> On Fri, 2014-02-21 at 11:13 -0800, Paul E. McKenney wrote:
> > On Fri, Feb 21, 2014 at 07:35:37PM +0100, Michael Matz wrote:
> > > Hi,
> > > 
> > > On Thu, 20 Feb 2014, Linus Torvalds wrote:
> > > 
> > > > But I'm pretty sure that any compiler guy must *hate* that current odd
> > > > dependency-generation part, and if I was a gcc person, seeing that
> > > > bugzilla entry Torvald pointed at, I would personally want to
> > > > dismember somebody with a rusty spoon..
> > > 
> > > Yes.  Defining dependency chains in the way the standard currently seems 
> > > to do must come from people not writing compilers.  There's simply no 
> > > sensible way to implement it without being really conservative, because 
> > > the depchains can contain arbitrary constructs including stores, 
> > > loads and function calls but must still be observed.  
> > > 
> > > And with conservative I mean "everything is a source of a dependency, and 
> > > hence can't be removed, reordered or otherwise fiddled with", and that 
> > > includes code sequences where no atomic objects are anywhere in sight [1].
> > > In the light of that the only realistic way (meaning to not have to 
> > > disable optimization everywhere) to implement consume as currently 
> > > specified is to map it to acquire.  At which point it becomes pointless.
> > 
> > No, only memory_order_consume loads and [[carries_dependency]]
> > function arguments are sources of dependency chains.
> 
> However, that is, given how the standard specifies things, just one of
> the possible ways for how an implementation can handle this.  Treating
> [[carries_dependency]] as a "necessary" annotation to make exploiting
> mo_consume work in practice is possible, but it's not required by the
> standard.
> 
> Also, dependencies are specified to flow through loads and stores
> (restricted to scalar objects and bitfields), so any load that might
> load from a dependency-carrying store can also be a source (and that
> doesn't seem to be restricted by [[carries_dependency]]).

OK, this last is clearly totally unacceptable.  :-/

Leaving aside the option of dropping the whole thing for the moment,
the only thing that suggests itself is having all dependencies die at
a specific point in the code, corresponding to the rcu_read_unlock().
But as far as I can see, that absolutely requires "necessary" parameter
and return marking in order to correctly handle nested RCU read-side
critical sections in different functions.

							Thanx, Paul

