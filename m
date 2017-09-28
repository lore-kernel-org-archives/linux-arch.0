From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: [RFC PATCH 1/2] arm64: mm: Use READ_ONCE/WRITE_ONCE when
 accessing page tables
Date: Fri, 29 Sep 2017 07:59:09 +1300
Message-ID: <20170928185909.kgwy36hkoqxqgyc3@tower>
References: <1506527369-19535-1-git-send-email-will.deacon@arm.com>
 <1506527369-19535-2-git-send-email-will.deacon@arm.com>
 <20170928083801.m6rb4frbbgzgam2o@hirez.programming.kicks-ass.net>
 <20170928084535.GA19060@arm.com>
 <20170928154354.GK3521@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170928154354.GK3521@linux.vnet.ibm.com>
Sender: linux-alpha-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org, ynorov@caviumnetworks.com, rruigrok@codeaurora.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, linux-alpha@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 28, 2017 at 08:43:54AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 28, 2017 at 09:45:35AM +0100, Will Deacon wrote:
> > On Thu, Sep 28, 2017 at 10:38:01AM +0200, Peter Zijlstra wrote:
> > > On Wed, Sep 27, 2017 at 04:49:28PM +0100, Will Deacon wrote:
> > > > In many cases, page tables can be accessed concurrently by either another
> > > > CPU (due to things like fast gup) or by the hardware page table walker
> > > > itself, which may set access/dirty bits. In such cases, it is important
> > > > to use READ_ONCE/WRITE_ONCE when accessing page table entries so that
> > > > entries cannot be torn, merged or subject to apparent loss of coherence.
> > > 
> > > In fact, we should use lockless_dereference() for many of them. Yes
> > > Alpha is the only one that cares about the difference between that and
> > > READ_ONCE() and they do have the extra barrier, but if we're going to do
> > > this, we might as well do it 'right' :-)
> > 
> > I know this sounds daft, but I think one of the big reasons why
> > lockless_dereference() doesn't get an awful lot of use is because it's
> > such a mouthful! Why don't we just move the smp_read_barrier_depends()
> > into READ_ONCE? Would anybody actually care about the potential impact on
> > Alpha (which, frankly, is treading on thin ice given the low adoption of
> > lockless_dereference())?
> 
> This is my cue to ask my usual question...  ;-)
> 
> Are people still running mainline kernels on Alpha?  (Added Alpha folks.)

Yes.  I run two Alpha build daemons that build the unofficial
debian-alpha port.  Debian popcon reports nine machines running
Alpha, which are likely to be running the 4.12.y kernel which
is currently in debian-alpha, (and presumably soon to be 4.13.y
which is now built on Alpha in experimental).

Cheers
Michael
