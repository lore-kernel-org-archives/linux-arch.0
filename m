Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726972AbeIAVVk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Sep 2018 17:21:40 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w81Gx3ZZ058529
        for <linux-arch@vger.kernel.org>; Sat, 1 Sep 2018 13:09:01 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m7qaev9qa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sat, 01 Sep 2018 13:09:01 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 1 Sep 2018 13:08:59 -0400
Date: Sat, 1 Sep 2018 10:08:54 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC LKMM 7/7] EXP tools/memory-model: Add .cfg and .cat
 files for s390
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180829211018.GA19646@linux.vnet.ibm.com>
 <20180829211053.20531-7-paulmck@linux.vnet.ibm.com>
 <20180831160630.GF30626@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831160630.GF30626@arm.com>
Message-ID: <20180901170854.GM4225@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180901170854.GcyhjgGTHT2POqfZgYCOPrzgeHy-ir9oP638hHtoRKk@z>

On Fri, Aug 31, 2018 at 05:06:30PM +0100, Will Deacon wrote:
> Hi Paul,
> 
> On Wed, Aug 29, 2018 at 02:10:53PM -0700, Paul E. McKenney wrote:
> > This commit adds s390.cat and s390.cfg files to allow users to check
> > litmus tests for s390-specific code.  Note that this change only enables
> > herd7 checking of C-language litmus tests.  Larger changes are required
> > to enable the litmus7 and klitmus7 tools to check litmus tests on real
> > hardare.
> > 
> > Suggested-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > [ paulmck: Add fixes suggested by Alan Stern. ]
> > ---
> >  tools/memory-model/s390.cat | 18 ++++++++++++++++++
> >  tools/memory-model/s390.cfg | 21 +++++++++++++++++++++
> >  2 files changed, 39 insertions(+)
> >  create mode 100644 tools/memory-model/s390.cat
> >  create mode 100644 tools/memory-model/s390.cfg
> 
> As I said before, I'd *much* prefer this to be part of the upstream
> herdtools7 repository. It's not really anything to do with the Linux
> kernel, so I don't think it belongs in the source tree.

Agreed.  As the cover letter says, "Add .cfg and .cat files for s390,
which is a not-for-mainline placeholder."

							Thanx, Paul
