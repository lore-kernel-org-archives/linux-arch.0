Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751233AbeDCPPy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Apr 2018 11:15:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w33FE2kN095199
        for <linux-arch@vger.kernel.org>; Tue, 3 Apr 2018 11:15:54 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2h4ahnx7cy-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 03 Apr 2018 11:15:51 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 3 Apr 2018 11:15:50 -0400
Date: Tue, 3 Apr 2018 08:16:42 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180402193154.GA3948@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1804030946400.1399-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1804030946400.1399-100000@iolanthe.rowland.org>
Message-ID: <20180403151642.GK3948@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180403151642.OsXZ5OaHQOPOm0C1-BlekMw_Wg770T-dnxNo1c2uVE0@z>

On Tue, Apr 03, 2018 at 09:50:19AM -0400, Alan Stern wrote:
> On Mon, 2 Apr 2018, Paul E. McKenney wrote:
> 
> > > > I will look at this more later, reaching end of both battery and useful
> > > > attention span...
> > 
> > Like the following, perhaps?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > s390
> > 
> > include "fences.cat"
> > include "cos.cat"
> > 
> > (* Fundamental coherence ordering *)
> > let com = rf | co | fr
> > acyclic po-loc | com as coherence
> > 
> > (* Atomic *)
> > empty rmw & (fre;coe) as atom 
> > 
> > (* Fences *)
> > let mb = [M] ; fencerel(Mb) ; [M]
> > 
> > (* TSO with multicopy atomicity *)
> > let po-ghb = ([R] ; po ; [M]) | ([M] ; po ; [W]) 
> > acyclic mb | po-ghb | fr | rf | co as sc
> 
> Yes, that should work okay (apart from issues related to ordering of
> atomic accesses).
> 
> By the way, what does that last "sc" stand for?  Surely not Sequential
> Consistency!  You might consider renaming it to "tso-mca".

Good point, fixed.

But it is the closest to SC in commercial computing systems, for whatever
that is worth.  ;-)

							Thanx, Paul
