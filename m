From: Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH v2 4/6] seccomp: Get compat syscalls from asm-generic header
Date: Tue, 29 Mar 2016 09:35:32 +0100
Message-ID: <1459240534-8658-5-git-send-email-matt.redfearn@imgtec.com>
References: <1459240534-8658-1-git-send-email-matt.redfearn@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459240534-8658-1-git-send-email-matt.redfearn@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: IMG-MIPSLinuxKerneldevelopers@imgtec.com
Cc: Matt Redfearn <matt.redfearn@imgtec.com>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>
List-Id: linux-arch.vger.kernel.org

Move retrieval of compat syscall numbers into inline function defined in
asm-generic header so that arches may override it.

Suggested-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

Changes in v2: None

 include/asm-generic/seccomp.h | 14 ++++++++++++++
 kernel/seccomp.c              |  9 +--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/seccomp.h b/include/asm-generic/seccomp.h
index c9ccafa0d99a..e74072d23e69 100644
--- a/include/asm-generic/seccomp.h
+++ b/include/asm-generic/seccomp.h
@@ -29,4 +29,18 @@
 #define __NR_seccomp_sigreturn		__NR_rt_sigreturn
 #endif
 
+#ifdef CONFIG_COMPAT
+#ifndef get_compat_mode1_syscalls
+static inline const int *get_compat_mode1_syscalls(void)
+{
+	static const int mode1_syscalls_32[] = {
+		__NR_seccomp_read_32, __NR_seccomp_write_32,
+		__NR_seccomp_exit_32, __NR_seccomp_sigreturn_32,
+		0, /* null terminated */
+	};
+	return mode1_syscalls_32;
+}
+#endif
+#endif /* CONFIG_COMPAT */
+
 #endif /* _ASM_GENERIC_SECCOMP_H */
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 15a1795bbba1..b0082c14764f 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -518,19 +518,12 @@ static int mode1_syscalls[] = {
 	0, /* null terminated */
 };
 
-#ifdef CONFIG_COMPAT
-static int mode1_syscalls_32[] = {
-	__NR_seccomp_read_32, __NR_seccomp_write_32, __NR_seccomp_exit_32, __NR_seccomp_sigreturn_32,
-	0, /* null terminated */
-};
-#endif
-
 static void __secure_computing_strict(int this_syscall)
 {
 	int *syscall_whitelist = mode1_syscalls;
 #ifdef CONFIG_COMPAT
 	if (is_compat_task())
-		syscall_whitelist = mode1_syscalls_32;
+		syscall_whitelist = get_compat_mode1_syscalls();
 #endif
 	do {
 		if (*syscall_whitelist == this_syscall)
-- 
2.5.0
