From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH lkmm tip/core/rcu 06/10] MAINTAINERS: Update maintainers
 for new Documentaion/litmus-tests/
Date: Wed, 15 Apr 2020 17:17:41 -0700
Message-ID: <20200416001741.GJ17661@paulmck-ThinkPad-P72>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
 <20200415184945.16487-6-paulmck@kernel.org>
 <1288d0e231eb61566fefc8a9c0510fc123528da2.camel@perches.com>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729625AbgDPARm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 20:17:42 -0400
Content-Disposition: inline
In-Reply-To: <1288d0e231eb61566fefc8a9c0510fc123528da2.camel@perches.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Joel Fernandes (Google)" <joel@joelfernandes.org>

On Wed, Apr 15, 2020 at 02:39:59PM -0700, Joe Perches wrote:
> On Wed, 2020-04-15 at 11:49 -0700, paulmck@kernel.org wrote:
> > Also add me as Reviewer for LKMM. Previously a patch to do this was
> > Acked but somewhere along the line got lost. Add myself in this patch.
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -9806,6 +9806,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
> >  M:	"Paul E. McKenney" <paulmck@kernel.org>
> >  R:	Akira Yokosawa <akiyks@gmail.com>
> >  R:	Daniel Lustig <dlustig@nvidia.com>
> > +R:	Joel Fernandes <joel@joelfernandes.org>
> >  L:	linux-kernel@vger.kernel.org
> >  L:	linux-arch@vger.kernel.org
> >  S:	Supported
> > @@ -9816,6 +9817,7 @@ F:	Documentation/core-api/atomic_ops.rst
> >  F:	Documentation/core-api/refcount-vs-atomic.rst
> >  F:	Documentation/memory-barriers.txt
> >  F:	tools/memory-model/
> > +F:	Documentation/litmus-tests/
> 
> trivia:
> 
> Alphabetic ordering of F: entries please.
> This should be between core-api and memory-barriers.
> 
> >  LIS3LV02D ACCELEROMETER DRIVER
> >  M:	Eric Piel <eric.piel@tremplin-utc.net>

New one on me, but it does make a lot of sense, especially for cases
with lots of scattered paths.  How about the following?

							Thanx, Paul

------------------------------------------------------------------------

commit e3b73adbd732e13e7e9f42c9adc95e7b9439426c
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Sun Mar 22 21:57:35 2020 -0400

    MAINTAINERS: Update maintainers for new Documentation/litmus-tests
    
    This commit adds Joel Fernandes as official LKMM reviewer.
    
    Acked-by: Boqun Feng <boqun.feng@gmail.com>
    Acked-by: Andrea Parri <parri.andrea@gmail.com>
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    [ paulmck: Apply Joe Perches alphabetization feedback. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db..15eb800 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9806,6 +9806,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 R:	Akira Yokosawa <akiyks@gmail.com>
 R:	Daniel Lustig <dlustig@nvidia.com>
+R:	Joel Fernandes <joel@joelfernandes.org>
 L:	linux-kernel@vger.kernel.org
 L:	linux-arch@vger.kernel.org
 S:	Supported
@@ -9814,6 +9815,7 @@ F:	Documentation/atomic_bitops.txt
 F:	Documentation/atomic_t.txt
 F:	Documentation/core-api/atomic_ops.rst
 F:	Documentation/core-api/refcount-vs-atomic.rst
+F:	Documentation/litmus-tests/
 F:	Documentation/memory-barriers.txt
 F:	tools/memory-model/
 
