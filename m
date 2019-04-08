From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2] srcu: Remove unused vmlinux srcu linker entries
Date: Sun,  7 Apr 2019 20:47:19 -0400
Message-ID: <20190408004719.178484-1-joel@joelfernandes.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, kernel-team@android.com, paulmck@linux.vnet.ibm.com, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The SRCU for modules optimization (commit title "srcu: Allocate per-CPU
data for DEFINE_SRCU() in modules") introduced vmlinux linker entries
which is unused since it applies only to the built-in vmlinux. So remove
it to prevent any space usage due to the 8 byte alignment it added.
vmlinux.lds.h has no effect on module loading and is not used for
building the module object, so the changes were not needed in the first
place since the optimization is specific to modules.

Tested with SRCU torture_type and rcutorture. Put prints in module
loader to confirm it is able to find and initialize the srcu structures.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: kernel-team@android.com
Cc: paulmck@linux.vnet.ibm.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1->v2: Added more context to change log.

 include/asm-generic/vmlinux.lds.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c2d919a1566e..f8f6f04c4453 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -338,10 +338,6 @@
 		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
 		__stop___tracepoints_ptrs = .;				\
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
-		. = ALIGN(8);						\
-		__start___srcu_struct = .;				\
-		*(___srcu_struct_ptrs)					\
-		__end___srcu_struct = .;				\
 	}								\
 									\
 	.rodata1          : AT(ADDR(.rodata1) - LOAD_OFFSET) {		\
-- 
2.21.0.392.gf8f6787159e-goog
