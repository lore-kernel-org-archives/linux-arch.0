Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751399AbdJWVHk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Oct 2017 17:07:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9NL7J81031052
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:40 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dsjcg7eac-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:39 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 23 Oct 2017 17:07:38 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 08/19] net/ipv4/tcp_input.c: Kill off ACCESS_ONCE()
Date: Mon, 23 Oct 2017 14:07:18 -0700
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Message-ID: <1508792849-3115-8-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org
Message-ID: <20171023210718.XLDQUh7jDr7PVMP8U355aLXWqGY7gZZFNhvsMy5QWTY@z>

From: Mark Rutland <mark.rutland@arm.com>

For several reasons, it is desirable to use {READ,WRITE}_ONCE() in
preference to ACCESS_ONCE(), and new code is expected to use one of the
former. So far, there's been no reason to change most existing uses of
ACCESS_ONCE(), as these aren't currently harmful.

However, for some features it is necessary to instrument reads and
writes separately, which is not possible with ACCESS_ONCE(). This
distinction is critical to correct operation.

It's possible to transform the bulk of kernel code using the Coccinelle
script below. However, this doesn't handle comments, leaving references
to ACCESS_ONCE() instances which have been removed. As a preparatory
step, this patch converts the IPv4 TCP input code and comments to use
{READ,WRITE}_ONCE() consistently.

----
virtual patch

@ depends on patch @
expression E1, E2;
@@

- ACCESS_ONCE(E1) = E2
+ WRITE_ONCE(E1, E2)

@ depends on patch @
expression E;
@@

- ACCESS_ONCE(E)
+ READ_ONCE(E)
----

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: David S. Miller <davem@davemloft.net>
---
 net/ipv4/tcp_input.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c5d7656beeee..133e7e4d94b5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -815,12 +815,12 @@ static void tcp_update_pacing_rate(struct sock *sk)
 	if (likely(tp->srtt_us))
 		do_div(rate, tp->srtt_us);
 
-	/* ACCESS_ONCE() is needed because sch_fq fetches sk_pacing_rate
+	/* WRITE_ONCE() is needed because sch_fq fetches sk_pacing_rate
 	 * without any lock. We want to make sure compiler wont store
 	 * intermediate values in this location.
 	 */
-	ACCESS_ONCE(sk->sk_pacing_rate) = min_t(u64, rate,
-						sk->sk_max_pacing_rate);
+	WRITE_ONCE(sk->sk_pacing_rate, min_t(u64, rate,
+					     sk->sk_max_pacing_rate));
 }
 
 /* Calculate rto without backoff.  This is the second half of Van Jacobson's
-- 
2.5.2
