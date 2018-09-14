Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726900AbeINVwN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Sep 2018 17:52:13 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8EGYZ2k098129
        for <linux-arch@vger.kernel.org>; Fri, 14 Sep 2018 12:36:57 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mgfmjts9j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 14 Sep 2018 12:36:56 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 14 Sep 2018 12:36:56 -0400
Date: Fri, 14 Sep 2018 09:36:49 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH RFC memory-model 0/7] Memory-model changes
Reply-To: paulmck@linux.ibm.com
References: <20180829211018.GA19646@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829211018.GA19646@linux.vnet.ibm.com>
Message-ID: <20180914163649.GA13942@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180914163649.5la2asgT9IJ35QemWa_5F3SgKEcLiU-dS6s-KEZHHZE@z>

On Wed, Aug 29, 2018 at 02:10:18PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This series contains memory-model updates, not yet ready for inclusion:

Summarizing my current state for the week after next's planned
for-inclusion series:

	ccc8b5139f65 tools/memory-model: Add litmus-test naming scheme
	c8c5779c854f tools/memory-model: Add extra ordering for locks and remove it for ordinary release/acquire
	a5109023cf9e tools/memory-model: Fix a README typo
	abdb4ce79ba3 tools/memory-model: Add more LKMM limitations

		I have these queued for the next merge window.	There has
		been some discussion of c8c5779c854f, and it would be
		good to resolve issues.  However, the patch is supported
		by Peter Zijlstra (x86) and Will Deacon (ARM), so I
		am OK sending it as-is if needed.  We always have the
		opportunity of adding other patches as needed.

		The latest email from Andrea indicated some concerns about
		the commit log, which cannot be changed after acceptance,
		so resolving those concerns is the highest priority.

	bf36a3124d04 doc: Replace smp_cond_acquire() with smp_cond_load_acquire()

		Small change, needs an ack.  Looks to me like is is
		just aligning the documentation with the code, so
		should not be controversial (famous last words).

		Please take a look and consider giving feedback
		and/or a review/ack.

	f3625642c96d EXP tools/memory-model: Add scripts to check github litmus tests
	eaaac2854b75 EXP tools/memory-model: Make scripts take "-j" abbreviation for "--jobs"

		These add regression-test capability and need a review
		and/or ack before they can be submitted.  I do not
		consider them to be particularly urgent.

							Thanx, Paul
