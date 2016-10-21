Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn3nam01on0058.outbound.protection.outlook.com ([104.47.33.58]:59558
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932542AbcJUUsJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Oct 2016 16:48:09 -0400
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 02/18] arm64: ilp32: add documentation on the ILP32 ABI for ARM64
Date: Fri, 21 Oct 2016 23:33:01 +0300
Message-ID: <1477081997-4770-3-git-send-email-ynorov@caviumnetworks.com>
In-Reply-To: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com
Message-ID: <20161021203301.RVu56gMgYDTRNoQ-05IXy2tQTbNzGAXaSrM3v4wNkBM@z>

Based on Andrew Pinski's patch-series.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 Documentation/arm64/ilp32.txt | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/arm64/ilp32.txt

diff --git a/Documentation/arm64/ilp32.txt b/Documentation/arm64/ilp32.txt
new file mode 100644
index 0000000..b96c18f
--- /dev/null
+++ b/Documentation/arm64/ilp32.txt
@@ -0,0 +1,46 @@
+ILP32 AARCH64 SYSCALL ABI
+=========================
+
+This document describes the ILP32 syscall ABI and where it differs
+from the generic compat linux syscall interface.
+
+AARCH64/ILP32 userspace can potentially access top halves of registers that
+are passed as syscall arguments, so such registers (w0-w7) are deloused.
+
+AARCH64/ILP32 provides next types turned to 64-bit (comparing to AARCH32):
+ino_t       is u64 type.
+off_t       is s64 type.
+blkcnt_t    is s64 type.
+fsblkcnt_t  is u64 type.
+fsfilcnt_t  is u64 type.
+rlim_t      is u64 type.
+
+AARCH64/ILP32 ABI uses standard syscall table which can be found at
+include/uapi/asm-generic/unistd.h, with the exceptions listed below.
+
+Syscalls which pass 64bit values are handled by the code shared from
+AARCH32 and pass that value as a pair. Next syscalls are affected:
+fadvise64_64()
+fallocate()
+ftruncate64()
+pread64()
+pwrite64()
+readahead()
+sync_file_range()
+truncate64()
+sys_mmap()
+
+ptrace() syscall is handled by compat version.
+
+shmat() syscall is handled by non-compat handler as aarch64/ilp32 has no
+limitation on 4-pages alignment for shared memory.
+
+statfs() and fstatfs() take the size of sfruct statfs as an argument.
+It is calculated differently in kernel and user spaces. So AARCH32 handlers
+are taken to handle it.
+
+struct rt_sigframe is redefined and contains struct compat_siginfo,
+as compat syscalls expects, and struct ilp32_sigframe, to handle
+AARCH64 register set and 32-bit userspace register representation.
+
+elf_gregset_t is taken from lp64 to handle registers properly.
-- 
2.7.4

