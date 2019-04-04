Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727398AbfDDUue (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Apr 2019 16:50:34 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34Km4Zs053034
        for <linux-arch@vger.kernel.org>; Thu, 4 Apr 2019 16:50:33 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rnqfycy2m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 04 Apr 2019 16:50:32 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 4 Apr 2019 21:50:31 +0100
Date: Thu, 4 Apr 2019 13:50:27 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH tip/core/rcu 08/21] tools/memory-model: Add support for
 synchronize_srcu_expedited()
Reply-To: paulmck@linux.ibm.com
References: <20190326234114.GA23843@linux.ibm.com>
 <20190326234133.24962-8-paulmck@linux.ibm.com>
 <20190402144911.GA10044@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402144911.GA10044@andrea>
Message-ID: <20190404205027.GM14111@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20190404205027.vmlf0uebhSEuLYI8aXRoUI1Wfc2sMc-SmRNZJuTOKPg@z>

On Tue, Apr 02, 2019 at 04:49:11PM +0200, Andrea Parri wrote:
> On Tue, Mar 26, 2019 at 04:41:20PM -0700, Paul E. McKenney wrote:
> > Given that synchronize_rcu_expedited() is supported, this commit adds
> > support for synchronize_srcu_expedited().
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > ---
> >  tools/memory-model/linux-kernel.def | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> > index 0c3f0ef486f4..551eeaa389d4 100644
> > --- a/tools/memory-model/linux-kernel.def
> > +++ b/tools/memory-model/linux-kernel.def
> > @@ -51,6 +51,7 @@ synchronize_rcu_expedited() { __fence{sync-rcu}; }
> >  srcu_read_lock(X)  __srcu{srcu-lock}(X)
> >  srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
> >  synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
> > +synchronize_srcu_expedited(X)  { __srcu{sync-srcu}(X); }
> 
> This and the other patches from the series do not apply to "tip/core/rcu"

Ah, that is instead their hoped-for destination within the -tip tree.
They are included in -rcu branch "dev".

> (from the Subject), but this seems straightforward enough:
> 
> Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Applied, thank you!

							Thanx, Paul

>   Andrea
> 
> 
> >  
> >  // Atomic
> >  atomic_read(X) READ_ONCE(*X)
> > -- 
> > 2.17.1
> > 
> 
