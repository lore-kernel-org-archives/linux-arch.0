From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH lkmm tip/core/rcu 06/10] MAINTAINERS: Update maintainers
 for new Documentaion/litmus-tests/
Date: Wed, 15 Apr 2020 18:46:21 -0700
Message-ID: <9cd5b3c0a9a0f55d799a3d3ebd68ba8ff5f907d8.camel@perches.com>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
         <20200415184945.16487-6-paulmck@kernel.org>
         <1288d0e231eb61566fefc8a9c0510fc123528da2.camel@perches.com>
         <20200416001741.GJ17661@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0171.hostedemail.com ([216.40.44.171]:47966 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387838AbgDPBsh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 21:48:37 -0400
In-Reply-To: <20200416001741.GJ17661@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Joel Fernandes (Google)" <joel@joelfernandes.org>

On Wed, 2020-04-15 at 17:17 -0700, Paul E. McKenney wrote:
> On Wed, Apr 15, 2020 at 02:39:59PM -0700, Joe Perches wrote:
> > On Wed, 2020-04-15 at 11:49 -0700, paulmck@kernel.org wrote:
> > > Also add me as Reviewer for LKMM. Previously a patch to do this was
> > > Acked but somewhere along the line got lost. Add myself in this patch.
> > []
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > []
> > > @@ -9806,6 +9806,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
> > >  M:	"Paul E. McKenney" <paulmck@kernel.org>
> > >  R:	Akira Yokosawa <akiyks@gmail.com>
> > >  R:	Daniel Lustig <dlustig@nvidia.com>
> > > +R:	Joel Fernandes <joel@joelfernandes.org>
> > >  L:	linux-kernel@vger.kernel.org
> > >  L:	linux-arch@vger.kernel.org
> > >  S:	Supported
> > > @@ -9816,6 +9817,7 @@ F:	Documentation/core-api/atomic_ops.rst
> > >  F:	Documentation/core-api/refcount-vs-atomic.rst
> > >  F:	Documentation/memory-barriers.txt
> > >  F:	tools/memory-model/
> > > +F:	Documentation/litmus-tests/
> > 
> > trivia:
> > 
> > Alphabetic ordering of F: entries please.
> > This should be between core-api and memory-barriers.
> > 
> > >  LIS3LV02D ACCELEROMETER DRIVER
> > >  M:	Eric Piel <eric.piel@tremplin-utc.net>
> 
> New one on me, but it does make a lot of sense, especially for cases
> with lots of scattered paths.  How about the following?

Thanks Paul.

If the recent commits that Linus did just before v5.7-rc1:

3b50142d8528 ("MAINTAINERS: sort field names for all entries")
4400b7d68f6e ("MAINTAINERS: sort entries by entry name")

don't create too many problems I suppose

$ scripts/parse-maintainers.pl --order --input=MAINTAINERS --output=MAINTAINERS

could be run just before every -rc1 to keep all this stuff organized.

We'll see.
