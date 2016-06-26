From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v4 23/29] kdb: Use task_cpu() instead of task_thread_info()->cpu
Date: Sun, 26 Jun 2016 14:55:45 -0700
Message-ID: <f3dcd6387b2c5fc1b2157a8e884f23307c571282.1466974736.git.luto@kernel.org>
References: <cover.1466974736.git.luto@kernel.org>
Reply-To: kernel-hardening@lists.openwall.com
Return-path: <kernel-hardening-return-3707-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <cover.1466974736.git.luto@kernel.org>
In-Reply-To: <cover.1466974736.git.luto@kernel.org>
References: <cover.1466974736.git.luto@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Jason Wessel <jason.wessel@windriver.com>
List-Id: linux-arch.vger.kernel.org

We'll need this cleanup to make the cpu field in thread_info be
optional.

Cc: Jason Wessel <jason.wessel@windriver.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 include/linux/kdb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kdb.h b/include/linux/kdb.h
index a19bcf9e762e..410decacff8f 100644
--- a/include/linux/kdb.h
+++ b/include/linux/kdb.h
@@ -177,7 +177,7 @@ extern int kdb_get_kbd_char(void);
 static inline
 int kdb_process_cpu(const struct task_struct *p)
 {
-	unsigned int cpu = task_thread_info(p)->cpu;
+	unsigned int cpu = task_cpu(p);
 	if (cpu > num_possible_cpus())
 		cpu = 0;
 	return cpu;
-- 
2.7.4
