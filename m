From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] arm64: remove no-op macro VMLINUX_SYMBOL()
Date: Wed,  9 May 2018 16:46:26 +0900
Message-ID: <1525851986-28631-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Steve Capper <steve.capper@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Olof Johansson <olof@lixom.net>
List-Id: linux-arch.vger.kernel.org

VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
is defined.  It has ever been selected only by BLACKFIN and METAG.
VMLINUX_SYMBOL() is unneeded for ARM64-specific code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/kernel/vmlinux.lds.S | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 0221aca..605d1b6 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -34,25 +34,25 @@ jiffies = jiffies_64;
 	 *    4 KB (see related ASSERT() below)		\
 	 */						\
 	. = ALIGN(SZ_4K);				\
-	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;	\
+	__hyp_idmap_text_start = .;			\
 	*(.hyp.idmap.text)				\
-	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;	\
-	VMLINUX_SYMBOL(__hyp_text_start) = .;		\
+	__hyp_idmap_text_end = .;			\
+	__hyp_text_start = .;				\
 	*(.hyp.text)					\
-	VMLINUX_SYMBOL(__hyp_text_end) = .;
+	__hyp_text_end = .;
 
 #define IDMAP_TEXT					\
 	. = ALIGN(SZ_4K);				\
-	VMLINUX_SYMBOL(__idmap_text_start) = .;		\
+	__idmap_text_start = .;				\
 	*(.idmap.text)					\
-	VMLINUX_SYMBOL(__idmap_text_end) = .;
+	__idmap_text_end = .;
 
 #ifdef CONFIG_HIBERNATION
 #define HIBERNATE_TEXT					\
 	. = ALIGN(SZ_4K);				\
-	VMLINUX_SYMBOL(__hibernate_exit_text_start) = .;\
+	__hibernate_exit_text_start = .;		\
 	*(.hibernate_exit.text)				\
-	VMLINUX_SYMBOL(__hibernate_exit_text_end) = .;
+	__hibernate_exit_text_end = .;
 #else
 #define HIBERNATE_TEXT
 #endif
@@ -60,10 +60,10 @@ jiffies = jiffies_64;
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 #define TRAMP_TEXT					\
 	. = ALIGN(PAGE_SIZE);				\
-	VMLINUX_SYMBOL(__entry_tramp_text_start) = .;	\
+	__entry_tramp_text_start = .;			\
 	*(.entry.tramp.text)				\
 	. = ALIGN(PAGE_SIZE);				\
-	VMLINUX_SYMBOL(__entry_tramp_text_end) = .;
+	__entry_tramp_text_end = .;
 #else
 #define TRAMP_TEXT
 #endif
-- 
2.7.4
