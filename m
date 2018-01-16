From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 02/22] signal: Document the strange si_codes used by ptrace event stops
Date: Mon, 15 Jan 2018 18:39:49 -0600
Message-ID: <20180116004009.31036-2-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/uapi/asm-generic/siginfo.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index cbe1b0cc7a6a..7158421ac911 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -225,6 +225,11 @@ typedef struct siginfo {
 #define TRAP_HWBKPT     4	/* hardware breakpoint/watchpoint */
 #define NSIGTRAP	4
 
+/*
+ * There are an additional set of SIGTRAP si_codes used by ptrace
+ * that of the form: ((PTRACE_EVENT_XXX << 8) | SIGTRAP)
+ */
+
 /*
  * SIGCHLD si_codes
  */
-- 
2.14.1
