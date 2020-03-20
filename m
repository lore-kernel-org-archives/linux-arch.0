Return-Path: <SRS0=zDlA=5F=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38111 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgCTQ7x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 12:59:53 -0400
Received: by mail-qk1-f194.google.com with SMTP id h14so7589139qke.5
        for <linux-arch@vger.kernel.org>; Fri, 20 Mar 2020 09:59:50 -0700 (PDT)
Date: Fri, 20 Mar 2020 12:59:48 -0400
From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/3] LKMM: Add litmus test for RCU GP guarantee where
 reader stores
Message-ID: <20200320165948.GB155212@google.com>
References: <20200320065552.253696-2-joel@joelfernandes.org>
 <Pine.LNX.4.44L0.2003201101060.27303-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2003201101060.27303-100000@netrider.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
Message-ID: <20200320165948.UXzdIkpZxc3Tx5Wbcsp6IfildMzaaTRgNAEuP1X_lJE@z>

On Fri, Mar 20, 2020 at 11:03:30AM -0400, Alan Stern wrote:
> On Fri, 20 Mar 2020, Joel Fernandes (Google) wrote:
> 
> > This adds an example for the important RCU grace period guarantee, which
> > shows an RCU reader can never span a grace period.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  .../litmus-tests/RCU+sync+read.litmus         | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > 
> > diff --git a/tools/memory-model/litmus-tests/RCU+sync+read.litmus b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > new file mode 100644
> > index 0000000000000..73557772e2a32
> > --- /dev/null
> > +++ b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> 
> Do these new tests really belong here?  I thought we were adding a new 
> directory under Documentation/ for litmus tests that illustrate parts 
> of the LKMM or memory-barriers.txt.
> 
> By contrast, the tests under tools/memory-model are merely to show 
> people what litmus tests look like and how they should be written.

I could add it to tools/memory-model/Documentation/ under a new
'examples' directory there. We could also create an 'rcu' directory in
tools/memory-model/litmus-tests/ and add these there. Thoughts?

thanks,

 - Joel
