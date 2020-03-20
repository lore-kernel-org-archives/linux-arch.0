From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/3] LKMM: Add litmus test for RCU GP guarantee where
 updater frees object
Date: Fri, 20 Mar 2020 16:15:16 -0400
Message-ID: <20200320201516.GA129293@google.com>
References: <20200320065552.253696-1-joel@joelfernandes.org>
 <Pine.LNX.4.44L0.2003201049230.27303-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41794 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTUPS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 16:15:18 -0400
Received: by mail-qt1-f196.google.com with SMTP id i3so2296332qtv.8
        for <linux-arch@vger.kernel.org>; Fri, 20 Mar 2020 13:15:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2003201049230.27303-100000@netrider.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>

On Fri, Mar 20, 2020 at 10:59:55AM -0400, Alan Stern wrote:
> On Fri, 20 Mar 2020, Joel Fernandes (Google) wrote:
> 
> > This adds an example for the important RCU grace period guarantee, which
> > shows an RCU reader can never span a grace period.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  .../litmus-tests/RCU+sync+free.litmus         | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 tools/memory-model/litmus-tests/RCU+sync+free.litmus
> > 
> > diff --git a/tools/memory-model/litmus-tests/RCU+sync+free.litmus b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
> > new file mode 100644
> > index 0000000000000..c4682502dd296
> > --- /dev/null
> > +++ b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
> > @@ -0,0 +1,40 @@
> > +C RCU+sync+free
> > +
> > +(*
> > + * Result: Never
> > + *
> 
> The following comment needs some rewriting.  The grammar is somewhat
> awkward and a very important "not" is missing.
> 
> > + * This litmus test demonstrates that an RCU reader can never see a write after
> > + * the grace period, if it saw writes that happen before the grace period.
> 
> An RCU reader can never see a write that follows a grace period if it
> did _not_ see writes that precede the grace period.

Yes, you are right. I will change your wording to 'did not see *all* writes
that precede'.

> >  This
> > + * is a typical pattern of RCU usage, where the write before the grace period
> > + * assigns a pointer, and the writes after destroy the object that the pointer
> > + * points to.
> 
> ... that the pointer used to point to.

Will fix.

> > + *
> > + * This guarantee also implies, an RCU reader can never span a grace period and
> > + * is an important RCU grace period memory ordering guarantee.
> 
> Unnecessary comma, and it is not clear what "This" refers to.  The 
> whole sentence should be phrased differently:
> 
> 	This is one implication of the RCU grace-period guarantee,
> 	which says (among other things) that an RCU reader cannot span 
> 	a grace period.

Your wording is better, will use that.

thanks,

 - Joel
