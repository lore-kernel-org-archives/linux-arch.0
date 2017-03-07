From: Laura Abbott <labbott@redhat.com>
Subject: [PATCHv3 02/16] arm: Use set_memory.h header
Date: Tue,  7 Mar 2017 12:55:19 -0800
Message-ID: <1488920133-27229-3-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Takashi Iwai <tiwai@suse.com>, Wim Van Sebroeck <wim@iguana.be>, "H. Peter Anvin" <hpa@zytor.com>, linux-watchdog@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Jessica Yu <jeyu@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, x86@kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Laura Abbott <labbott@redhat.com>, Guenter Roeck <linux@roeck-us.net>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

set_memory_* functions have moved to set_memory.h. Switch to this
explicitly

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Add one file, keep the cacheflush.h header in bpf
---
 arch/arm/kernel/ftrace.c        | 1 +
 arch/arm/kernel/machine_kexec.c | 1 +
 arch/arm/mm/pageattr.c          | 1 +
 arch/arm/net/bpf_jit_32.c       | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 3f17594..dea3e96 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -21,6 +21,7 @@
 #include <asm/opcodes.h>
 #include <asm/ftrace.h>
 #include <asm/insn.h>
+#include <asm/set_memory.h>
 
 #ifdef CONFIG_THUMB2_KERNEL
 #define	NOP		0xf85deb04	/* pop.w {lr} */
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index b18c1ea..1549588 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -18,6 +18,7 @@
 #include <asm/mach-types.h>
 #include <asm/smp_plat.h>
 #include <asm/system_misc.h>
+#include <asm/set_memory.h>
 
 extern void relocate_new_kernel(void);
 extern const unsigned int relocate_new_kernel_size;
diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
index 3b69f26..1403cb4 100644
--- a/arch/arm/mm/pageattr.c
+++ b/arch/arm/mm/pageattr.c
@@ -15,6 +15,7 @@
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
+#include <asm/set_memory.h>
 
 struct page_change_data {
 	pgprot_t set_mask;
diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 93d0b6d..d5b9fa1 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -18,6 +18,7 @@
 #include <linux/if_vlan.h>
 
 #include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 #include <asm/hwcap.h>
 #include <asm/opcodes.h>
 
-- 
2.7.4
