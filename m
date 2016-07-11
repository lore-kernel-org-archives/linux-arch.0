From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v5 22/32] kdb: Use task_cpu() instead of task_thread_info()->cpu
Date: Mon, 11 Jul 2016 13:53:55 -0700
Message-ID: <c72cd2d7896c80f4398f685af5a78f2111fbda78.1468270393.git.luto@kernel.org>
References: <cover.1468270393.git.luto@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1468270393.git.luto@kernel.org>
In-Reply-To: <cover.1468270393.git.luto@kernel.org>
References: <cover.1468270393.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Jason Wessel <jason.wessel@windriver.com>
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
