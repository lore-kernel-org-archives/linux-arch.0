From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 13/19] rcutorture: formal: Prepare for ACCESS_ONCE() removal
Date: Mon, 23 Oct 2017 14:07:23 -0700
Message-ID: <1508792849-3115-13-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751524AbdJWVHl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Oct 2017 17:07:41 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9NL6ABL064093
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:41 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dsj2trm2k-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:40 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 23 Oct 2017 17:07:39 -0400
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

From: Mark Rutland <mark.rutland@arm.com>

For several reasons, it is desirable to use {READ,WRITE}_ONCE() in
preference to ACCESS_ONCE(), and new code is expected to use one of the
former. So far, there's been no reason to change most existing uses of
ACCESS_ONCE(), as these aren't currently harmful.

However, for some features it is necessary to instrument reads and
writes separately, which is not possible with ACCESS_ONCE(). This
distinction is critical to correct operation.

The bulk of the kernel code can be transformed via Coccinelle to use
{READ,WRITE}_ONCE(), though this only modifies users of ACCESS_ONCE(),
and not the implementation itself. As such, it has the potential to
break homebrew ACCESS_ONCE() macros seen in some user code in the kernel
tree (e.g. the virtio code, as fixed in commit ea9156fb3b71d9f7).

To avoid fragility if/when that transformation occurs, this patch
reworks the definitions of {READ,WRITE}_ONCE() in the rcutorture formal
tests, and removes the unused ACCESS_ONCE() helper. There should be no
functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/barriers.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/barriers.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/barriers.h
index 6687acc08e6d..cc27b9ebcf20 100644
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/barriers.h
+++ b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/barriers.h
@@ -34,8 +34,7 @@
 #define rs_smp_mb() do {} while (0)
 #endif
 
-#define ACCESS_ONCE(x) (*(volatile typeof(x) *) &(x))
-#define READ_ONCE(x) ACCESS_ONCE(x)
-#define WRITE_ONCE(x, val) (ACCESS_ONCE(x) = (val))
+#define READ_ONCE(x) (*(volatile typeof(x) *) &(x))
+#define WRITE_ONCE(x) ((*(volatile typeof(x) *) &(x)) = (val))
 
 #endif
-- 
2.5.2
