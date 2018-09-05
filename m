Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbeIETXy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Sep 2018 15:23:54 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85Eou7M048907
        for <linux-arch@vger.kernel.org>; Wed, 5 Sep 2018 10:53:20 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2magp9stwh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 05 Sep 2018 10:53:20 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 10:53:19 -0400
Date: Wed, 5 Sep 2018 07:53:12 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180904081144.GA4137@andrea>
 <Pine.LNX.4.44L0.1809041503470.17060-100000@netrider.rowland.org>
 <20180905072151.GA3185@andrea>
 <50f0a7a7-0521-f833-34c3-132ce57dd777@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50f0a7a7-0521-f833-34c3-132ce57dd777@gmail.com>
Message-ID: <20180905145312.GI4225@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr
Message-ID: <20180905145312.AMSkYfE1ngmmnFUH-pNBjYl9ZYW9b88qsyZ3DpybkeE@z>

On Wed, Sep 05, 2018 at 11:33:08PM +0900, Akira Yokosawa wrote:
> On 2018/09/05 09:21:51 +0200, Andrea Parri wrote:
> > On Tue, Sep 04, 2018 at 03:09:49PM -0400, Alan Stern wrote:
> >> On Tue, 4 Sep 2018, Andrea Parri wrote:
> >>> Heh, your confusion might be the reflection of mine... ;-)  That was
> >>> indeed a long and not conclusive discussion (meaning there're pending
> >>> issues); and I cannot claim to find "arguments" such as:
> >>>
> >>>   "More than one kernel developer has expressed the opinion that
> >>>    the LKMM should enforce ordering of writes by locking."
> >>>
> >>> particularly helpful (I do tend to be convinced by arguments rather
> >>> than by opinions).  In fact, you can take the following as my only
> >>> current "constructive argument" against the patch [1,2]:
> >>>
> >>>   THE COMMIT MESSAGE IS RIDICULOUS; PLEASE EXPAND ON IT, AND DO
> >>>   SO BY LEVERAGING BOTH PROS AND CONS OF THE APPLIED CHANGES
> >>
> >> Do you have any concrete suggestions (i.e., some actual text) for 
> >> improvements to the patch description?  Earlier in your message you 
> >> mentioned that Will's comment:
> >>
> >> 	LKMM offers stronger guarantees that can portably be relied upon
> >> 	in the codebase.
> >>
> >> would make a good addition.  Suitably edited, it could be added to the
> >> description.  I can think of a few other things myself, but I'd like to 
> >> hear your thoughts.  Anything else?
> > 
> > Yes: I do sometimes have the impression that your "rules" for trimming
> > text in emails/replies are too aggressive...
> 
> Andrea, by saying "Yes:", do you mean you have something else to be added?
> I don't think you do, but want to make sure.
> 
> I'm a bit surprised to see all you wanted was the amendment of the
> commit log...

My guess is that Andrea would prefer that locking acquire/release and
load-store-RMW acquire/release to have the same ordering rules (which
Will has argued against), and that Andrea's "Yes" above is expressing
irritation that some point he wished to reiterate was trimmed somewhere
in the exchange.  And yes, both the act of replying to emails and
of establishing multi-architecture ordering rules can be a bit messy
at times.

Andrea's patch had no Signed-off-by and does not apply to the -rcu tree's
dev branch, so I am guessing that he was thinking in terms of replacing
some subset of the patches that are currently queued, presumably including
Alan's patch that Will reviewed and Peter acked.  (I don't yet have a
new lkmm branch because I need to sort out a few of the commits first.)

If replacement is the intent, the people Andrea needs to convince include
Alan, Peter, and Will.

							Thanx, Paul
