From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 3/5] frv: avoid infinite loop of SIGSEGV delivery
Date: Sat, 18 Sep 2010 20:41:55 +0100
Message-ID: <E1Ox3IJ-0006RR-BZ@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


force_sigsegv() exists for a good reason...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/frv/kernel/signal.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/frv/kernel/signal.c b/arch/frv/kernel/signal.c
index d06226b..fa40d54 100644
--- a/arch/frv/kernel/signal.c
+++ b/arch/frv/kernel/signal.c
@@ -329,7 +329,7 @@ static int setup_frame(int sig, struct k_sigaction *ka, sigset_t *set)
 	return 0;
 
 give_sigsegv:
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 	return -EFAULT;
 
 } /* end setup_frame() */
@@ -431,7 +431,7 @@ static int setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
 	return 0;
 
 give_sigsegv:
-	force_sig(SIGSEGV, current);
+	force_sigsegv(sig, current);
 	return -EFAULT;
 
 } /* end setup_rt_frame() */
-- 
1.5.6.5
