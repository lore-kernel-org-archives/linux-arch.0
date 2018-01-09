From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 30/36] arm64: Implement thread_struct whitelist for hardened
 usercopy
Date: Tue,  9 Jan 2018 12:55:59 -0800
Message-ID: <1515531365-37423-31-git-send-email-keescook@chromium.org>
References: <1515531365-37423-1-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1515531365-37423-1-git-send-email-keescook@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Jan Kara <jack@suse.cz>, kernel-hardening@lists.openwall.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rik van Riel <riel@redhat.com>, linux-mm@kvack.org, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, zijun_hu <zijun_hu@htc.com>, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Laura Abbott <labbott@redhat.com>, Dave Martin <Dave.Martin@arm.com>, David Windsor <dave@nullcore.net>, Kees Cook <keescook@chromium.org>, Marc Zyngier <marc.zyngier@arm.com>, Dave Kleikamp <dave.kleikamp@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, linux-arm-kernel@lists.infradead.org, Luis de Bethencourt <luisbg@kernel.org>, Martin K. Peters
List-Id: linux-arch.vger.kernel.org

This whitelists the FPU register state portion of the thread_struct for
copying to userspace, instead of the default entire structure.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: zijun_hu <zijun_hu@htc.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig                 | 1 +
 arch/arm64/include/asm/processor.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a93339f5178f..c84477e6a884 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -90,6 +90,7 @@ config ARM64
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_VMAP_STACK
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 023cacb946c3..e58a5864ec89 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -113,6 +113,14 @@ struct thread_struct {
 	struct debug_info	debug;		/* debugging */
 };
 
+/* Whitelist the fpsimd_state for copying to userspace. */
+static inline void arch_thread_struct_whitelist(unsigned long *offset,
+						unsigned long *size)
+{
+	*offset = offsetof(struct thread_struct, fpsimd_state);
+	*size = sizeof(struct fpsimd_state);
+}
+
 #ifdef CONFIG_COMPAT
 #define task_user_tls(t)						\
 ({									\
-- 
2.7.4
