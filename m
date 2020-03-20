From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/3] LKMM: Add litmus test for RCU GP guarantee where
 reader stores
Date: Fri, 20 Mar 2020 16:56:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.2003201643370.31761-100000@netrider.rowland.org>
References: <20200320165948.GB155212@google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:59429 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726951AbgCTU5A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 16:57:00 -0400
In-Reply-To: <20200320165948.GB155212@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>

On Fri, 20 Mar 2020, Joel Fernandes wrote:

> On Fri, Mar 20, 2020 at 11:03:30AM -0400, Alan Stern wrote:
> > On Fri, 20 Mar 2020, Joel Fernandes (Google) wrote:
> > 
> > > This adds an example for the important RCU grace period guarantee, which
> > > shows an RCU reader can never span a grace period.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  .../litmus-tests/RCU+sync+read.litmus         | 37 +++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > >  create mode 100644 tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > 
> > > diff --git a/tools/memory-model/litmus-tests/RCU+sync+read.litmus b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > new file mode 100644
> > > index 0000000000000..73557772e2a32
> > > --- /dev/null
> > > +++ b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > 
> > Do these new tests really belong here?  I thought we were adding a new 
> > directory under Documentation/ for litmus tests that illustrate parts 
> > of the LKMM or memory-barriers.txt.
> > 
> > By contrast, the tests under tools/memory-model are merely to show 
> > people what litmus tests look like and how they should be written.
> 
> I could add it to tools/memory-model/Documentation/ under a new
> 'examples' directory there. We could also create an 'rcu' directory in
> tools/memory-model/litmus-tests/ and add these there. Thoughts?

What happened was that about a month ago, Boqun Feng added
Documentation/atomic-tests for litmus tests related to handling of
atomic_t types (see
<https://marc.info/?l=linux-kernel&m=158276408609029&w=2>.)  Should we
interpose an extra directory level, making it
Documentation/litmus-tests/atomic?  Or
Documentation/LKMM-litmus-tests/atomic?

Then the new tests added here could go into
Documentation/litmus-tests/rcu, or whatever.

Alan
