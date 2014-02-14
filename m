From: Torvald Riegel <triegel@redhat.com>
Subject: Re: [RFC][PATCH 0/5] arch: atomic rework
Date: Fri, 14 Feb 2014 11:21:59 -0800
Message-ID: <1392405719.18779.4380.camel@triegel.csb>
References: <20140207180216.GP4250@linux.vnet.ibm.com>	 <1391992071.18779.99.camel@triegel.csb>	 <CA+55aFwTwCPMpYTL_vCgNNP0hE8s2sgB0iw-79=xoj99V0JUNA@mail.gmail.com>	 <1392183564.18779.2187.camel@triegel.csb>	 <20140212180739.GB4250@linux.vnet.ibm.com>	 <CA+55aFw3S82GYdtnV2nJCvBGcuZf6kXdF5b7Vp9yb21QKr49Jw@mail.gmail.com>	 <20140213002355.GI4250@linux.vnet.ibm.com>	 <1392321837.18779.3249.camel@triegel.csb>	 <20140214020144.GO4250@linux.vnet.ibm.com>	 <1392352981.18779.3800.camel@triegel.csb>	 <20140214172920.GQ4250@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <gcc-return-182038-gcc=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
In-Reply-To: <20140214172920.GQ4250@linux.vnet.ibm.com>
To: paulmck@linux.vnet.ibm.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
List-Id: linux-arch.vger.kernel.org

On Fri, 2014-02-14 at 09:29 -0800, Paul E. McKenney wrote:
> On Thu, Feb 13, 2014 at 08:43:01PM -0800, Torvald Riegel wrote:
> > On Thu, 2014-02-13 at 18:01 -0800, Paul E. McKenney wrote:
> 
> [ . . . ]
> 
> > > Another option would be to flag the conditional expression, prohibiting
> > > the compiler from optimizing out any conditional branches.  Perhaps
> > > something like this:
> > > 
> > > 	r1 = atomic_load(x, memory_order_control);
> > > 	if (control_dependency(r1))
> > > 		atomic_store(y, memory_order_relaxed);
> > 
> > That's the one I had in mind and talked to you about earlier today.  My
> > gut feeling is that this is preferably over the other because it "marks"
> > the if-statement, so the compiler knows exactly which branches matter.
> > I'm not sure one would need the other memory order for that, if indeed
> > all you want is relaxed -> branch -> relaxed.  But maybe there are
> > corner cases (see the weaker-than-relaxed discussion in SG1 today).
> 
> Linus, Peter, any objections to marking places where we are relying on
> ordering from control dependencies against later stores?  This approach
> seems to me to have significant documentation benefits.

Let me note that at least as I'm concerned, that's just a quick idea.
At least I haven't looked at (1) how to properly specify the semantics
of this, (2) whether it has any bad effects on unrelated code, (3) and
whether there are pitfalls for compiler implementations.  It looks not
too bad at first glance, though.
