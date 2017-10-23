From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 11/19] selftests/powerpc: Kill off ACCESS_ONCE()
Date: Mon, 23 Oct 2017 14:07:21 -0700
Message-ID: <1508792849-3115-11-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
List-Id: linux-arch.vger.kernel.org

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

To avoid fragility if/when that transformation occurs, and to align with
the preferred usage of {READ,WRITE}_ONCE(), this patch updates the DSCR
selftest code to use READ_ONCE() rather than ACCESS_ONCE(). There should
be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/powerpc/dscr/dscr.h              | 2 +-
 tools/testing/selftests/powerpc/dscr/dscr_default_test.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/dscr/dscr.h b/tools/testing/selftests/powerpc/dscr/dscr.h
index 18ea223bd398..cdb840bc54f2 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr.h
+++ b/tools/testing/selftests/powerpc/dscr/dscr.h
@@ -39,7 +39,7 @@
 #define rmb()  asm volatile("lwsync":::"memory")
 #define wmb()  asm volatile("lwsync":::"memory")
 
-#define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
+#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
 
 /* Prilvilege state DSCR access */
 inline unsigned long get_dscr(void)
diff --git a/tools/testing/selftests/powerpc/dscr/dscr_default_test.c b/tools/testing/selftests/powerpc/dscr/dscr_default_test.c
index df17c3bab0a7..9e1a37e93b63 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr_default_test.c
+++ b/tools/testing/selftests/powerpc/dscr/dscr_default_test.c
@@ -27,7 +27,7 @@ static void *do_test(void *in)
 		unsigned long d, cur_dscr, cur_dscr_usr;
 		unsigned long s1, s2;
 
-		s1 = ACCESS_ONCE(sequence);
+		s1 = READ_ONCE(sequence);
 		if (s1 & 1)
 			continue;
 		rmb();
-- 
2.5.2
