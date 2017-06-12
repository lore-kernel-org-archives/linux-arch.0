From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 05/27] ARM: move generic-y of exported headers to
 uapi/asm/Kbuild
Date: Mon, 12 Jun 2017 12:26:59 +0900
Message-ID: <1497238041-7011-6-git-send-email-yamada.masahiro@socionext.com>
References: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Since commit fcc8487d477a ("uapi: export all headers under uapi
directories"), all (and only) headers under uapi directories are
exported, but asm-generic wrappers are still exceptions.

scripts/Makefile.headersinst still need to deal with old-kbuild-file
for headers listed in arch/*/include/asm/Kbuild, but actually exported.

As the last work to finish de-coupling the uapi from kernel headers,
move generic-y of exported headers to uapi/asm/Kbuild.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/include/asm/Kbuild      | 17 -----------------
 arch/arm/include/uapi/asm/Kbuild | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 3a36d99ff836..721ab5ecfb9b 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -1,40 +1,23 @@
-
-
-generic-y += bitsperlong.h
 generic-y += clkdev.h
 generic-y += current.h
 generic-y += early_ioremap.h
 generic-y += emergency-restart.h
-generic-y += errno.h
 generic-y += exec.h
 generic-y += extable.h
-generic-y += ioctl.h
-generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += kdebug.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
-generic-y += msgbuf.h
 generic-y += msi.h
-generic-y += param.h
 generic-y += parport.h
-generic-y += poll.h
 generic-y += preempt.h
-generic-y += resource.h
 generic-y += rwsem.h
 generic-y += seccomp.h
 generic-y += segment.h
-generic-y += sembuf.h
 generic-y += serial.h
-generic-y += shmbuf.h
-generic-y += siginfo.h
 generic-y += simd.h
 generic-y += sizes.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += termbits.h
-generic-y += termios.h
 generic-y += timex.h
 generic-y += trace_clock.h
 generic-y += unaligned.h
diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
index 607f702c2d62..b531c2786f27 100644
--- a/arch/arm/include/uapi/asm/Kbuild
+++ b/arch/arm/include/uapi/asm/Kbuild
@@ -1,6 +1,22 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += bitsperlong.h
+generic-y += errno.h
+generic-y += ioctl.h
+generic-y += ipcbuf.h
+generic-y += msgbuf.h
+generic-y += param.h
+generic-y += poll.h
+generic-y += resource.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
+generic-y += siginfo.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += termbits.h
+generic-y += termios.h
+
 genhdr-y += unistd-common.h
 genhdr-y += unistd-oabi.h
 genhdr-y += unistd-eabi.h
-- 
2.7.4
