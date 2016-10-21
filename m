From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 08/18] arm64: ilp32: add is_ilp32_compat_{task,
 thread} and TIF_32BIT_AARCH64
Date: Fri, 21 Oct 2016 23:33:07 +0300
Message-ID: <1477081997-4770-9-git-send-email-ynorov@caviumnetworks.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Cc: szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, ynorov@caviumnetworks.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

ILP32 tasks are needed to be distinguished from lp64 and aarch32.
This patch adds helper functions is_ilp32_compat_{task,thread} and
thread flag TIF_32BIT_AARCH64 to address it. This is a preparation
for following patches in ilp32 patchset.

For consistency, SET_PERSONALITY is changed here accordingly.

Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/arm64/include/asm/elf.h         | 13 +++++++++++--
 arch/arm64/include/asm/is_compat.h   | 30 ++++++++++++++++++++++++++++--
 arch/arm64/include/asm/thread_info.h |  2 ++
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 6a9049b..f259fe8 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -142,7 +142,11 @@ typedef struct user_fpsimd_state elf_fpregset_t;
  */
 #define ELF_PLAT_INIT(_r, load_addr)	(_r)->regs[0] = 0
 
-#define SET_PERSONALITY(ex)		clear_thread_flag(TIF_32BIT);
+#define SET_PERSONALITY(ex)		\
+do {						\
+	clear_thread_flag(TIF_32BIT_AARCH64);	\
+	clear_thread_flag(TIF_32BIT);		\
+} while (0)
 
 /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
 #define ARCH_DLINFO							\
@@ -183,7 +187,12 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 					 ((x)->e_flags & EF_ARM_EABI_MASK))
 
 #define compat_start_thread		compat_start_thread
-#define COMPAT_SET_PERSONALITY(ex)	set_thread_flag(TIF_32BIT);
+#define COMPAT_SET_PERSONALITY(ex)		\
+do {						\
+	clear_thread_flag(TIF_32BIT_AARCH64);	\
+	set_thread_flag(TIF_32BIT);		\
+} while (0)
+
 #define COMPAT_ARCH_DLINFO
 extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
 				      int uses_interp);
diff --git a/arch/arm64/include/asm/is_compat.h b/arch/arm64/include/asm/is_compat.h
index 8dba5ca..7726beb 100644
--- a/arch/arm64/include/asm/is_compat.h
+++ b/arch/arm64/include/asm/is_compat.h
@@ -45,18 +45,44 @@ static inline int is_a32_compat_thread(struct thread_info *thread)
 
 #endif /* CONFIG_AARCH32_EL0 */
 
+#ifdef CONFIG_ARM64_ILP32
+
+static inline int is_ilp32_compat_task(void)
+{
+	return test_thread_flag(TIF_32BIT_AARCH64);
+}
+
+static inline int is_ilp32_compat_thread(struct thread_info *thread)
+{
+	return test_ti_thread_flag(thread, TIF_32BIT_AARCH64);
+}
+
+#else
+
+static inline int is_ilp32_compat_task(void)
+{
+	return 0;
+}
+
+static inline int is_ilp32_compat_thread(struct thread_info *thread)
+{
+	return 0;
+}
+
+#endif /* CONFIG_ARM64_ILP32 */
+
 #ifdef CONFIG_COMPAT
 
 static inline int is_compat_task(void)
 {
-	return is_a32_compat_task();
+	return is_a32_compat_task() || is_ilp32_compat_task();
 }
 
 #endif /* CONFIG_COMPAT */
 
 static inline int is_compat_thread(struct thread_info *thread)
 {
-	return is_a32_compat_thread(thread);
+	return is_a32_compat_thread(thread) || is_ilp32_compat_thread(thread);
 }
 
 
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index e12411f..680aca5 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -122,6 +122,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_RESTORE_SIGMASK	20
 #define TIF_SINGLESTEP		21
 #define TIF_32BIT		22	/* AARCH32 process */
+#define TIF_32BIT_AARCH64	23	/* 32 bit process on AArch64(ILP32) */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
@@ -133,6 +134,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_32BIT		(1 << TIF_32BIT)
+#define _TIF_32BIT_AARCH64	(1 << TIF_32BIT_AARCH64)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE)
-- 
2.7.4
