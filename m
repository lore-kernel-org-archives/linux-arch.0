Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725948AbeKPJG2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Nov 2018 04:06:28 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAFMtbAv084502
        for <linux-arch@vger.kernel.org>; Thu, 15 Nov 2018 17:56:38 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nsentapcm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 15 Nov 2018 17:56:38 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 15 Nov 2018 22:56:37 -0000
Date: Thu, 15 Nov 2018 14:56:30 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Q&A from "Concurrency with tools/memory-model"
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20181115225630.GA30917@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20181115225630.x8rqM43tnvNpqKlMxKVm4tg8pbcA8Hy4rfpKHAD6Sj4@z>

Hello!

Good turnout and some good questions here in Vancouver BC, please see
below for rough notes.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

"Concurrency with tools/memory-model"

Andrea Parri presenting.

Rough notes of Q&A.

o	Want atomic bit operation.

o	But smp_read_barrier_depends() not there, so how to note pairing?
	A:  Note the dependency as the other end of the pairing.

o	Speculation barriers, as in Spectre and Meltdown?  A: This would
	require adding timing, not in the immediate future.

o	What ordering does system calls provide?  A: None that we know of.
	Boqun: Userspace needs to explicitly provide the needed ordering
	when interacting with the kernel.  Some architectures do provide
	full barriers, but not to be counted on.

o	Why herd7?  A: Based on other formalizations -- note that herd7
	had a number of hardware models.  Paul: Plus the founder of the
	LKMM project is a co-author of herd, which might have had some
	effect.

o	Why not also model interrupts and NMIs?  Promela and spin have
	been used for this.  A: Cannot currently model them.  You can
	emulated them with additional threads and locks, if you wish.
	Vincent Nimal and Lihao Liang have done some academic work on
	these topics.
