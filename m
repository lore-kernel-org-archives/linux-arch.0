From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/5] riscv: remove redundant kernel-space generic-y
Date: Thu,  3 Jan 2019 10:10:36 +0900
Message-ID: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
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
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

This commit removes redundant generic-y defines in
arch/riscv/include/asm/Kbuild.

[1] It is redundant to define the same generic-y in both
    arch/$(ARCH)/include/asm/Kbuild and
    arch/$(ARCH)/include/uapi/asm/Kbuild.

    Remove the following generic-y:

      errno.h
      fcntl.h
      ioctl.h
      ioctls.h
      ipcbuf.h
      mman.h
      msgbuf.h
      param.h
      poll.h
      posix_types.h
      resource.h
      sembuf.h
      setup.h
      shmbuf.h
      signal.h
      socket.h
      sockios.h
      stat.h
      statfs.h
      swab.h
      termbits.h
      termios.h
      types.h

[2] It is redundant to define generic-y when arch-specific
    implementation exists in arch/$(ARCH)/include/asm/*.h

    Remove the following generic-y:

      cacheflush.h
      module.h

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - rebase on Linus' tree

 arch/riscv/include/asm/Kbuild | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 6a646d9..cccd12c 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -1,5 +1,4 @@
 generic-y += bugs.h
-generic-y += cacheflush.h
 generic-y += checksum.h
 generic-y += compat.h
 generic-y += cputime.h
@@ -9,16 +8,11 @@ generic-y += dma.h
 generic-y += dma-contiguous.h
 generic-y += dma-mapping.h
 generic-y += emergency-restart.h
-generic-y += errno.h
 generic-y += exec.h
 generic-y += fb.h
-generic-y += fcntl.h
 generic-y += hardirq.h
 generic-y += hash.h
 generic-y += hw_irq.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
@@ -27,34 +21,15 @@ generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
-generic-y += mman.h
-generic-y += module.h
-generic-y += msgbuf.h
 generic-y += mutex.h
-generic-y += param.h
 generic-y += percpu.h
-generic-y += poll.h
-generic-y += posix_types.h
 generic-y += preempt.h
-generic-y += resource.h
 generic-y += scatterlist.h
 generic-y += sections.h
-generic-y += sembuf.h
 generic-y += serial.h
-generic-y += setup.h
-generic-y += shmbuf.h
 generic-y += shmparam.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
 generic-y += topology.h
 generic-y += trace_clock.h
-generic-y += types.h
 generic-y += unaligned.h
 generic-y += user.h
 generic-y += vga.h
-- 
2.7.4
