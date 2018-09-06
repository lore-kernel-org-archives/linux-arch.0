From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/memory-model] Add litmus-test naming scheme
Date: Thu, 6 Sep 2018 08:13:36 -0700
Message-ID: <20180906151336.GR4225@linux.vnet.ibm.com>
References: <20180525191020.GA5914@linux.vnet.ibm.com>
 <20180529093050.GB6533@arm.com>
 <20180529121107.GF3803@linux.vnet.ibm.com>
 <20180529201713.GD591@arm.com>
 <20180906000117.GG4225@linux.vnet.ibm.com>
 <20180906135218.GA5212@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180906135218.GA5212@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 06, 2018 at 02:52:18PM +0100, Will Deacon wrote:
> On Wed, Sep 05, 2018 at 05:01:17PM -0700, Paul E. McKenney wrote:
> > On Tue, May 29, 2018 at 09:17:13PM +0100, Will Deacon wrote:
> > > On Tue, May 29, 2018 at 05:11:07AM -0700, Paul E. McKenney wrote:
> > > > On Tue, May 29, 2018 at 10:30:50AM +0100, Will Deacon wrote:
> > > > > Hi Paul,
> > > > > 
> > > > > On Fri, May 25, 2018 at 12:10:20PM -0700, Paul E. McKenney wrote:
> > > > > > This commit documents the scheme used to generate the names for the
> > > > > > litmus tests.
> > > > > > 
> > > > > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > > > ---
> > > > > >  README |  136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > > > > >  1 file changed, 135 insertions(+), 1 deletion(-)
> > > > > 
> > > > > Whilst I think documentation like this is extremely important for users,
> > > > > this feels like it's documenting how to drive parts of diy and I'm not
> > > > > convinced that it belongs in the kernel source tree as long as the projects
> > > > > remain separate.
> > > > > 
> > > > > Why not contribute this to the herdtools7 documentation, then just reference
> > > > > that from here? That would also be helpful for other people interested in
> > > > > memory models, but perhaps not interested in Linux (assuming such people
> > > > > exist ;).
> > > > 
> > > > We would still need at least a pointer from the Linux kernel to that
> > > > documentation, but I am happy either way.  We probably need examples of
> > > > the common cases, but probably not a full exposition of all the available
> > > > herd7 edges.
> > > 
> > > Completely agreed.
> > > 
> > > > Should this be in the herdtools7 documentation, or as added detail
> > > > from a variation on the "diyone7 -bell linux-kernel.bell -show edges"
> > > > command?  If the latter, I suppose that the ones coming from the .bell
> > > > file might simply be labelled as such.
> > > 
> > > Many of the edges aren't specific to the Linux kernel, so I think they
> > > should be part of the diyone7 documentation. We could then describe only
> > > the additional edges added by the kernel memory model (e.g. "Once") in
> > > the kernel documentation.
> > 
> > And there are a -lot- of them, and they are likely to change going
> > forward, both in herd7 and in linux-kernel.bell.  How about if I give
> > examples and say where they are from and how to get a list, as in the
> > following --squash commit to be merged with the orginal?
> 
> Sure, that looks much easier to maintain. With that, you can add my ack:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Applied, thank you!

And the lkmm branch has finally been updated to indicate the three
commits that have acks/reviews and thus that appear ready for the
next merge window, give or take the ongoing discussions.

							Thanx, Paul
