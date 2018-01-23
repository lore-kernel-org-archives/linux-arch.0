From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 02/10] signal/arm64: Better isolate the COMPAT_TASK portion of ptrace_hbptriggered
Date: Tue, 23 Jan 2018 15:07:11 -0600
Message-ID: <20180123210719.10456-2-ebiederm@xmission.com>
References: <87607s5lra.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87607s5lra.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Instead of jumpping while !is_compat_task placee all of the code
inside of an if (is_compat_task) block.  This allows the int i
variable to be properly limited to the compat block no matter how the
rest of ptrace_hbptriggered changes.

In a following change a non-variable declaration will preceed
was made independent to ensure the code is easy to review.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/kernel/ptrace.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 7c44658b316d..0a1cf830e4b3 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -188,26 +188,23 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 	};
 
 #ifdef CONFIG_COMPAT
-	int i;
-
-	if (!is_compat_task())
-		goto send_sig;
+	if (is_compat_task()) {
+		int i;
 
-	for (i = 0; i < ARM_MAX_BRP; ++i) {
-		if (current->thread.debug.hbp_break[i] == bp) {
-			info.si_errno = (i << 1) + 1;
-			break;
+		for (i = 0; i < ARM_MAX_BRP; ++i) {
+			if (current->thread.debug.hbp_break[i] == bp) {
+				info.si_errno = (i << 1) + 1;
+				break;
+			}
 		}
-	}
 
-	for (i = 0; i < ARM_MAX_WRP; ++i) {
-		if (current->thread.debug.hbp_watch[i] == bp) {
-			info.si_errno = -((i << 1) + 1);
-			break;
+		for (i = 0; i < ARM_MAX_WRP; ++i) {
+			if (current->thread.debug.hbp_watch[i] == bp) {
+				info.si_errno = -((i << 1) + 1);
+				break;
+			}
 		}
 	}
-
-send_sig:
 #endif
 	force_sig_info(SIGTRAP, &info, current);
 }
-- 
2.14.1
