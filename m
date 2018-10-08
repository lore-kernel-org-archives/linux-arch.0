From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v3 5/6] parisc: wire up rseq system call
Date: Mon,  8 Oct 2018 10:46:40 +0530
Message-ID: <1538975801-13735-6-git-send-email-firoz.khan@linaro.org>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/kernel/syscalls/syscall.tbl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 4e85293..4334bb7 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -349,4 +349,5 @@
 347     common  preadv2                         sys_preadv2                     compat_sys_preadv2
 348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
 349     common  statx                           sys_statx
-350	common  io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
\ No newline at end of file
+350	common  io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
+351	common	rseq				sys_rseq			compat_sys_rseq
-- 
1.9.1
