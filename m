Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42289 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbeJLRQm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Oct 2018 13:16:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so5591630pgq.9
        for <linux-arch@vger.kernel.org>; Fri, 12 Oct 2018 02:45:07 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v4 5/6] parisc: wire up rseq system call
Date: Fri, 12 Oct 2018 15:14:01 +0530
Message-ID: <1539337442-3676-6-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20181012094401.2WrmxSNKLtGGAgH9anBMjDu9YnjKeA1t53i0Al4B9iA@z>

Wire up rseq system call requires an architecture specific
implementation as it not present now.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/kernel/syscalls/syscall.tbl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 7c9f268..91317be 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -366,4 +366,6 @@
 347     common  preadv2                         sys_preadv2                     compat_sys_preadv2
 348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
 349     common  statx                           sys_statx
-350	common  io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
\ No newline at end of file
+350	common  io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
+# rseq requires an architecture specific implementation
+351	common	rseq				sys_rseq
-- 
1.9.1
