From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 14/15] netfilter: Remove now-redundant
 smp_read_barrier_depends()
Date: Tue, 10 Oct 2017 08:56:50 -0700
Message-ID: <20171010155650.GF3521@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
 <1507594969-8347-14-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010084334.nbyhryiwyrl6km4u@hirez.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932271AbdJJP45 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Oct 2017 11:56:57 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9AFu3Wk194396
        for <linux-arch@vger.kernel.org>; Tue, 10 Oct 2017 11:56:56 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dgwesewvu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 10 Oct 2017 11:56:56 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 10 Oct 2017 11:56:55 -0400
Content-Disposition: inline
In-Reply-To: <20171010084334.nbyhryiwyrl6km4u@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, will.deacon@arm.com, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org

On Tue, Oct 10, 2017 at 10:43:34AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 09, 2017 at 05:22:48PM -0700, Paul E. McKenney wrote:
> > READ_ONCE() now implies smp_read_barrier_depends(), which means that
> > the instances in arpt_do_table(), ipt_do_table(), and ip6t_do_table()
> > are now redundant.  This commit removes them and adjusts the comments.
> 
> Similar to the previous patch, the lack of READ_ONCE() in the original
> code is a pre-existing bug. It would allow the compiler to tear the load
> and observe a composite of two difference pointer values, or reload the
> private pointer and result in table_base and jumpstacl being part of
> different objects.
> 
> It would be good to point out this actually fixes a bug in the code.

Assuming that these changes actually fixed something, agreed.  ;-)

							Thanx, Paul
