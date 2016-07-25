From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 2/5] ARM: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
Date: Mon, 25 Jul 2016 16:59:51 +0100
Message-ID: <1469462394-8970-3-git-send-email-james.hogan@imgtec.com>
References: <1469462394-8970-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1469462394-8970-1-git-send-email-james.hogan@imgtec.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>, Nathan Lynch <nathan_lynch@mentor.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-arch.vger.kernel.org

AT_VECTOR_SIZE_ARCH should be defined with the maximum number of
NEW_AUX_ENT entries that ARCH_DLINFO can contain, but it wasn't defined
for ARM at all even though ARCH_DLINFO can contain one NEW_AUX_ENT when
VDSO is enabled.

This shouldn't be a problem as AT_VECTOR_SIZE_BASE includes space for
AT_BASE_PLATFORM which ARM doesn't use, but lets define it now and add
the comment above ARCH_DLINFO as found in several other architectures to
remind future modifiers of ARCH_DLINFO to keep AT_VECTOR_SIZE_ARCH up to
date.

Fixes: 1713ce7c4375 ("ARM: 8329/1: miscellaneous vdso infrastructure, preparation")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Nathan Lynch <nathan_lynch@mentor.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/elf.h         | 1 +
 arch/arm/include/uapi/asm/auxvec.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index d2315ffd8f12..dc58133e33f1 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -129,6 +129,7 @@ extern void elf_set_personality(const struct elf32_hdr *);
 
 #ifdef CONFIG_MMU
 #ifdef CONFIG_VDSO
+/* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
 #define ARCH_DLINFO						\
 do {								\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
diff --git a/arch/arm/include/uapi/asm/auxvec.h b/arch/arm/include/uapi/asm/auxvec.h
index cb02a767a500..5ab9090356df 100644
--- a/arch/arm/include/uapi/asm/auxvec.h
+++ b/arch/arm/include/uapi/asm/auxvec.h
@@ -4,4 +4,6 @@
 /* VDSO location */
 #define AT_SYSINFO_EHDR	33
 
+#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+
 #endif
-- 
2.4.10
