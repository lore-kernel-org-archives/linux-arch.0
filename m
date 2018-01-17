From: David Howells <dhowells@redhat.com>
Subject: [PATCH 8/8] Expand INIT_STRUCT_PID and remove
Date: Wed, 17 Jan 2018 15:26:24 +0000
Message-ID: <151620278443.22429.11548467651869929899.stgit@warthog.procyon.org.uk>
References: <151620268761.22429.14193525405303696385.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753942AbeAQP0d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jan 2018 10:26:33 -0500
In-Reply-To: <151620268761.22429.14193525405303696385.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Expand INIT_STRUCT_PID in the single place that uses it and then remove it.
There doesn't seem any point in the macro.

Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Tested-by: Will Deacon <will.deacon@arm.com> (arm64)
Tested-by: Palmer Dabbelt <palmer@sifive.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---

 include/linux/init_task.h |   15 ---------------
 kernel/pid.c              |   14 +++++++++++++-
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 5b5f41328115..a454b8aeb938 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -46,21 +46,6 @@ extern struct cred init_cred;
 #define INIT_CPU_TIMERS(s)
 #endif
 
-
-#define INIT_STRUCT_PID {						\
-	.count 		= ATOMIC_INIT(1),				\
-	.tasks		= {						\
-		{ .first = NULL },					\
-		{ .first = NULL },					\
-		{ .first = NULL },					\
-	},								\
-	.level		= 0,						\
-	.numbers	= { {						\
-		.nr		= 0,					\
-		.ns		= &init_pid_ns,				\
-	}, }								\
-}
-
 #define INIT_PID_LINK(type) 					\
 {								\
 	.node = {						\
diff --git a/kernel/pid.c b/kernel/pid.c
index b13b624e2c49..161af2eda943 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -41,7 +41,19 @@
 #include <linux/sched/task.h>
 #include <linux/idr.h>
 
-struct pid init_struct_pid = INIT_STRUCT_PID;
+struct pid init_struct_pid = {
+	.count 		= ATOMIC_INIT(1),
+	.tasks		= {
+		{ .first = NULL },
+		{ .first = NULL },
+		{ .first = NULL },
+	},
+	.level		= 0,
+	.numbers	= { {
+		.nr		= 0,
+		.ns		= &init_pid_ns,
+	}, }
+};
 
 int pid_max = PID_MAX_DEFAULT;
 
