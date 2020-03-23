From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/3] LKMM: Add litmus test for RCU GP guarantee where
 reader stores
Date: Sun, 22 Mar 2020 21:31:00 -0400
Message-ID: <20200323013100.GA207949@google.com>
References: <20200320165948.GB155212@google.com>
 <Pine.LNX.4.44L0.2003201643370.31761-100000@netrider.rowland.org>
 <20200320214432.GB129293@google.com>
 <20200321020501.GF105953@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200321020501.GF105953@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <parri.andrea@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sat, Mar 21, 2020 at 10:05:01AM +0800, Boqun Feng wrote:
> On Fri, Mar 20, 2020 at 05:44:32PM -0400, Joel Fernandes wrote:
> > On Fri, Mar 20, 2020 at 04:56:59PM -0400, Alan Stern wrote:
> > > On Fri, 20 Mar 2020, Joel Fernandes wrote:
> > > 
> > > > On Fri, Mar 20, 2020 at 11:03:30AM -0400, Alan Stern wrote:
> > > > > On Fri, 20 Mar 2020, Joel Fernandes (Google) wrote:
> > > > > 
> > > > > > This adds an example for the important RCU grace period guarantee, which
> > > > > > shows an RCU reader can never span a grace period.
> > > > > > 
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > ---
> > > > > >  .../litmus-tests/RCU+sync+read.litmus         | 37 +++++++++++++++++++
> > > > > >  1 file changed, 37 insertions(+)
> > > > > >  create mode 100644 tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > > > > 
> > > > > > diff --git a/tools/memory-model/litmus-tests/RCU+sync+read.litmus b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > > > > new file mode 100644
> > > > > > index 0000000000000..73557772e2a32
> > > > > > --- /dev/null
> > > > > > +++ b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > > > 
> > > > > Do these new tests really belong here?  I thought we were adding a new 
> > > > > directory under Documentation/ for litmus tests that illustrate parts 
> > > > > of the LKMM or memory-barriers.txt.
> > > > > 
> > > > > By contrast, the tests under tools/memory-model are merely to show 
> > > > > people what litmus tests look like and how they should be written.
> > > > 
> > > > I could add it to tools/memory-model/Documentation/ under a new
> > > > 'examples' directory there. We could also create an 'rcu' directory in
> > > > tools/memory-model/litmus-tests/ and add these there. Thoughts?
> > > 
> > > What happened was that about a month ago, Boqun Feng added
> > > Documentation/atomic-tests for litmus tests related to handling of
> > > atomic_t types (see
> > > <https://marc.info/?l=linux-kernel&m=158276408609029&w=2>.)  Should we
> > > interpose an extra directory level, making it
> > > Documentation/litmus-tests/atomic?  Or
> > > Documentation/LKMM-litmus-tests/atomic?
> > > 
> > > Then the new tests added here could go into
> > > Documentation/litmus-tests/rcu, or whatever.
> > 
> > That's fine with me. Unless anyone objects, I will add to
> > Documentation/litmus-tests/rcu and resend.
> > 
> 
> Seems good to me, I will resend my patchset with the new directory. And
> I assume in your patchset you will include the MAINTAINERS part for
> adding Documentation/litmus-tests/ as a diretory watched by LKMM group?
> In that case, I won't need to add any change to MAINTAINERS file in mine
> and we won't have any conflict. ;-)

Yes, will add to MAINTAINERS so that you don't have to :) About to send my
queue now.

thanks,

 - Joel
