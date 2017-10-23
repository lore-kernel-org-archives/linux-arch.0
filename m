From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 08/19] net/ipv4/tcp_input.c: Kill off ACCESS_ONCE()
Date: Mon, 23 Oct 2017 14:07:18 -0700
Message-ID: <1508792849-3115-8-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

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
