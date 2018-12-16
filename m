Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-08.nifty.com ([210.131.2.75]:53299 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPPFQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Dec 2018 10:05:16 -0500
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] bpf: promote bpf_perf_event.h to mandatory UAPI header
Date: Mon, 17 Dec 2018 00:04:40 +0900
Message-ID: <1544972680-4105-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Message-ID: <20181216150440.CVV8JESr0hXwmMAy8fRjQQcXSgcVdMvK2ZV_5o2jaG0@z>

Since commit c895f6f703ad ("bpf: correct broken uapi for
BPF_PROG_TYPE_PERF_EVENT program type"), all architectures
(except um) are required to have bpf_perf_event.h in uapi/asm.

Add it to mandatory-y so "make headers_install" can check it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/uapi/asm-generic/Kbuild.asm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/asm-generic/Kbuild.asm b/include/uapi/asm-generic/Kbuild.asm
index 2138144..355c4ac 100644
--- a/include/uapi/asm-generic/Kbuild.asm
+++ b/include/uapi/asm-generic/Kbuild.asm
@@ -3,6 +3,7 @@
 #
 mandatory-y += auxvec.h
 mandatory-y += bitsperlong.h
+mandatory-y += bpf_perf_event.h
 mandatory-y += byteorder.h
 mandatory-y += errno.h
 mandatory-y += fcntl.h
-- 
2.7.4
