From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 03/22] signal: Document glibc's si_code of SI_ASYNCNL
Date: Mon, 15 Jan 2018 18:39:50 -0600
Message-ID: <20180116004009.31036-3-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

The header uapi/asm-generic/siginfo.h appears to the the repository of
all of these definitions in linux so collect up glibcs additions as
well.  Just to prevent someone from accidentally creating a conflict
in the future.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/uapi/asm-generic/siginfo.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 7158421ac911..2d3348afb2f0 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -165,6 +165,7 @@ typedef struct siginfo {
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
 #define SI_TKILL	-6		/* sent by tkill system call */
 #define SI_DETHREAD	-7		/* sent by execve() killing subsidiary threads */
+#define SI_ASYNCNL	-60		/* sent by glibc async name lookup completion */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
-- 
2.14.1
