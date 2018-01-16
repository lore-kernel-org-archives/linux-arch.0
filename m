From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 14/22] signal/powerpc: Remove redefinition of NSIGTRAP on powerpc
Date: Mon, 15 Jan 2018 18:40:01 -0600
Message-ID: <20180116004009.31036-14-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

NSIGTRAP is 4 in the generic siginfo and powerpc just undefines
NSGTRAP and redefine it as 4.  That accomplishes nothing so remove
the duplication.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/include/uapi/asm/siginfo.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/siginfo.h b/arch/powerpc/include/uapi/asm/siginfo.h
index 444ca6c9989a..9f142451a01f 100644
--- a/arch/powerpc/include/uapi/asm/siginfo.h
+++ b/arch/powerpc/include/uapi/asm/siginfo.h
@@ -15,9 +15,6 @@
 
 #include <asm-generic/siginfo.h>
 
-#undef NSIGTRAP
-#define NSIGTRAP	4
-
 /*
  * SIGFPE si_codes
  */
-- 
2.14.1
