From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH] riscv: enable sys_clone3 syscall for rv64
Date: Thu, 18 Jul 2019 21:20:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.9999.1907182118500.7083@viisi.sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: linux-riscv@lists.infradead.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, christian@brauner.io
List-Id: linux-arch.vger.kernel.org


Enable the sys_clone3 syscall for RV64.  We simply include the generic
version.

Tested by running the program from

   https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/

and verifying that it completes successfully.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Christian Brauner <christian@brauner.io>
---
 arch/riscv/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
index 0e2eeeb1fd27..13ce76cc5aff 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -18,6 +18,7 @@
 #ifdef __LP64__
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_SYS_CLONE3
 #endif /* __LP64__ */
 
 #include <asm-generic/unistd.h>
-- 
2.22.0
