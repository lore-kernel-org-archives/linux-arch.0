Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932294AbdJJPax (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Oct 2017 11:30:53 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9AFSDi1098175
        for <linux-arch@vger.kernel.org>; Tue, 10 Oct 2017 11:30:52 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dh0dr1ffj-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 10 Oct 2017 11:30:52 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 10 Oct 2017 11:30:52 -0400
Date: Tue, 10 Oct 2017 08:30:47 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 05/15] percpu: READ_ONCE() now implies
 smp_read_barrier_depends()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20171010001951.GA6476@linux.vnet.ibm.com>
 <1507594969-8347-5-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010140813.GK3301751@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010140813.GK3301751@devbig577.frc2.facebook.com>
Message-ID: <20171010153047.GB3521@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, Christoph Lameter <cl@linux.com>
Message-ID: <20171010153047.nH95yGFu50kSB-pWKsXaoiu9S5G_XgTT2AfjQ0lSzNw@z>

On Tue, Oct 10, 2017 at 07:08:13AM -0700, Tejun Heo wrote:
> On Mon, Oct 09, 2017 at 05:22:39PM -0700, Paul E. McKenney wrote:
> > Because READ_ONCE() now implies smp_read_barrier_depends(), this commit
> > removes the now-redundant smp_read_barrier_depends() following the
> > READ_ONCE() in __ref_is_percpu().
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Christoph Lameter <cl@linux.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Thank you, applied!

> Please feel free to route with other patches.  If this should be
> routed through the percpu tree, please let me know.

This depends on some other not-yet-finalized patch series, so if you
are OK with it, I will route them with that group of serieses.

							Thanx, Paul
