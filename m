From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 09/22] arm64: mte: Tags-aware clear_page() implementation
Date: Wed, 11 Dec 2019 18:40:14 +0000
Message-ID: <20191211184027.20130-10-catalin.marinas@arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191211184027.20130-1-catalin.marinas@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Richard Earnshaw <Richard.Earnshaw@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Andrey Konovalov <andreyknvl@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

When the Memory Tagging Extension is enabled, the tags need to be set to
zero a page is cleared as they are visible to the user.

Introduce an MTE-aware clear_page() which clears the tags in addition to
data.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/lib/clear_page.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/lib/clear_page.S b/arch/arm64/lib/clear_page.S
index 78a9ef66288a..575cea03f68a 100644
--- a/arch/arm64/lib/clear_page.S
+++ b/arch/arm64/lib/clear_page.S
@@ -5,7 +5,9 @@
 
 #include <linux/linkage.h>
 #include <linux/const.h>
+#include <asm/alternative.h>
 #include <asm/assembler.h>
+#include <asm/cpufeature.h>
 #include <asm/page.h>
 
 /*
@@ -19,8 +21,9 @@ ENTRY(clear_page)
 	and	w1, w1, #0xf
 	mov	x2, #4
 	lsl	x1, x2, x1
-
-1:	dc	zva, x0
+1:
+alternative_insn "dc zva, x0", "stzgm xzr, [x0]", \
+			 ARM64_MTE, IS_ENABLED(CONFIG_ARM64_MTE), 1
 	add	x0, x0, x1
 	tst	x0, #(PAGE_SIZE - 1)
 	b.ne	1b
