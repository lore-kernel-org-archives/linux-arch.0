From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/memory-model] Add litmus-test naming scheme
Date: Tue, 29 May 2018 05:11:07 -0700
Message-ID: <20180529121107.GF3803@linux.vnet.ibm.com>
References: <20180525191020.GA5914@linux.vnet.ibm.com>
 <20180529093050.GB6533@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180529093050.GB6533@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, May 29, 2018 at 10:30:50AM +0100, Will Deacon wrote:
> Hi Paul,
> 
> On Fri, May 25, 2018 at 12:10:20PM -0700, Paul E. McKenney wrote:
> > This commit documents the scheme used to generate the names for the
> > litmus tests.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  README |  136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 135 insertions(+), 1 deletion(-)
> 
> Whilst I think documentation like this is extremely important for users,
> this feels like it's documenting how to drive parts of diy and I'm not
> convinced that it belongs in the kernel source tree as long as the projects
> remain separate.
> 
> Why not contribute this to the herdtools7 documentation, then just reference
> that from here? That would also be helpful for other people interested in
> memory models, but perhaps not interested in Linux (assuming such people
> exist ;).

We would still need at least a pointer from the Linux kernel to that
documentation, but I am happy either way.  We probably need examples of
the common cases, but probably not a full exposition of all the available
herd7 edges.

Should this be in the herdtools7 documentation, or as added detail
from a variation on the "diyone7 -bell linux-kernel.bell -show edges"
command?  If the latter, I suppose that the ones coming from the .bell
file might simply be labelled as such.

							Thanx, Paul
