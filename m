Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754396AbeDBTbF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Apr 2018 15:31:05 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w32JUwd4099986
        for <linux-arch@vger.kernel.org>; Mon, 2 Apr 2018 15:31:04 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2h3sgm2vcx-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 02 Apr 2018 15:31:04 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 2 Apr 2018 15:31:03 -0400
Date: Mon, 2 Apr 2018 12:31:54 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180329021812.GV3675@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1803291021500.1292-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1803291021500.1292-100000@iolanthe.rowland.org>
Message-ID: <20180402193154.GA3948@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180402193154._VwNIRqSOEcCIQ7lQYppmcuJXirv9ck_JeqyWpr-6FA@z>

On Thu, Mar 29, 2018 at 10:40:43AM -0400, Alan Stern wrote:
> On Wed, 28 Mar 2018, Paul E. McKenney wrote:
> 
> > > > In the meantime, does the cat file look to you like it correctly
> > > > models the combination of TSO and multicopy atomicity?  Do the
> > > > fences really work, or did I just get lucky with my choice of
> > > > litmus tests?
> > > 
> > > You got lucky.  Try creating an SB litmus test where, instead of an
> > > smp_mb() fence between the write and the read, each thread executes
> > > some other kind of fence.
> > 
> > Ah, it does indeed get "Never" in that case, which I do not believe
> > to e correct.
> > 
> > > The acyclicity condition should have been written more like this:
> > > 
> > > let po_ghb = ([R] ; po ; [M]) | ([M] ; po ; [W])
> > > 
> > > acyclic mfence | po_ghb | rf | fr | co as tso-mca
> > > 
> > > I don't know what the fence instruction is on s390; change the "mfence"
> > > above accordingly.  The main difference between this and the
> > > corresponding expression in x86tso.cat is that I replaced rfe with rf.
> > 
> > The s390 fence instruction is "bcr 14,0" or "bcr 15,0", depending on
> > how recent of hardware you are running.  The latter works everywhere,
> > if I recall correctly.  But I do not believe that herd knows about either
> > instruction yet.
> 
> Herd does not need to understand s390 assembly in order to handle the 
> things defined in linux.def, such as "smp_mb()".  linux.def doesn't 
> contain any x86 assembly language stuff either (or PPC or ARM).
> 
> >  Ah, and I need to lose the "empty rmw & (fre;coe)".
> > That appears to be where my spurious ordering was coming from, strange
> > though that seems to me.
> 
> No, don't drop it; it was not the source of your spurious ordering.  
> The extra ordering came from your "(po \ (W * R))" term, which 
> unintentionally matches fences as well as memory accesses.
> 
> > And your use of "rf" instead of "rfe" makes sense, as that is what makes
> > the read-from-write provide ordering, correct?  And that should also cover
> > the "Uniproc check" that would otherwise be required, right?
> 
> I don't think so...
> 
> > Except that I get "Sometimes" on CoWR+poonceonce+Once.litmus...
> 
> Exactly.
> 
> > Which I can fix by unioning po-loc into po-ghb.  Or is there some
> > better way to do this?
> 
> You could just keep the "uniproc" check.  These two approaches accept 
> the same set of litmus tests.
> 
> Logically, I think of these as two distinct categories of ordering.  
> po_ghb and tso-mca have to do with the order in which stores reach the 
> cache, whereas "uniproc" (AKA sequential consistency per variable) has 
> to do with enforcement of the cache coherence requirements.  Clearly 
> they are related, but they aren't the same thing.
> 
> > > This doesn't account for atomic operations properly; see the "implied" 
> > > term in x86tso.cat.
> > 
> > I will look at this more later, reaching end of both battery and useful
> > attention span...

Like the following, perhaps?

							Thanx, Paul

------------------------------------------------------------------------

s390

include "fences.cat"
include "cos.cat"

(* Fundamental coherence ordering *)
let com = rf | co | fr
acyclic po-loc | com as coherence

(* Atomic *)
empty rmw & (fre;coe) as atom 

(* Fences *)
let mb = [M] ; fencerel(Mb) ; [M]

(* TSO with multicopy atomicity *)
let po-ghb = ([R] ; po ; [M]) | ([M] ; po ; [W]) 
acyclic mb | po-ghb | fr | rf | co as sc
