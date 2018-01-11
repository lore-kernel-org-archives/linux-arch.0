From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 34/38] arm: Implement thread_struct whitelist for hardened
 usercopy
Date: Wed, 10 Jan 2018 18:03:06 -0800
Message-ID: <1515636190-24061-35-git-send-email-keescook@chromium.org>
References: <1515636190-24061-1-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1515636190-24061-1-git-send-email-keescook@chromium.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Jan Kara <jack@suse.cz>, kernel-hardening@lists.openwall.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Rik van Riel <riel@redhat.com>, linux-mm@kvack.org, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Christoph Hellwig <hch@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Laura Abbott <labbott@redhat.com>, David Windsor <dave@nullcore.net>, Kees Cook <keescook@chromium.org>, Marc Zyngier <marc.zyngier@arm.com>, Dave Kleikamp <dave.kleikamp@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, linux-arm-kernel@lists.infradead.org, Luis de Bethencourt <luisbg@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org, Matthew Garrett <mjg59@google.com>, linux-fsde
List-Id: linux-arch.vger.kernel.org

ARM does not carry FPU state in the thread structure, so it can declare
no usercopy whitelist at all.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/Kconfig                 | 1 +
 arch/arm/include/asm/processor.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 51c8df561077..3ea00d65f35d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -50,6 +50,7 @@ config ARM
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_SECCOMP_FILTER if (AEABI && !OABI_COMPAT)
+	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARM_SMCCC if CPU_V7
 	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 338cbe0a18ef..01a41be58d43 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -45,6 +45,13 @@ struct thread_struct {
 	struct debug_info	debug;
 };
 
+/* Nothing needs to be usercopy-whitelisted from thread_struct. */
+static inline void arch_thread_struct_whitelist(unsigned long *offset,
+						unsigned long *size)
+{
+	*offset = *size = 0;
+}
+
 #define INIT_THREAD  {	}
 
 #define start_thread(regs,pc,sp)					\
-- 
2.7.4
