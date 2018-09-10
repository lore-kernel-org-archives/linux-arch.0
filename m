Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33732 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbeIJJoh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Sep 2018 05:44:37 -0400
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC][PATCH 7/8] switch x86 to generic uapi asm/termios.h
Date: Mon, 10 Sep 2018 05:52:26 +0100
Message-ID: <20180910045227.9895-7-viro@ZenIV.linux.org.uk>
In-Reply-To: <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
References: <20180910044937.GJ19965@ZenIV.linux.org.uk>
 <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Message-ID: <20180910045226.iW8_vPUWTnoVhg23mxCgWu6fnz8WmWP4xWf5JRr4Xmc@z>

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/uapi/asm/Kbuild    | 1 +
 arch/x86/include/uapi/asm/termios.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)
 delete mode 100644 arch/x86/include/uapi/asm/termios.h

diff --git a/arch/x86/include/uapi/asm/Kbuild b/arch/x86/include/uapi/asm/Kbuild
index 322681622d1e..56994b75c491 100644
--- a/arch/x86/include/uapi/asm/Kbuild
+++ b/arch/x86/include/uapi/asm/Kbuild
@@ -2,6 +2,7 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
+generic-y += termios.h
 generated-y += unistd_32.h
 generated-y += unistd_64.h
 generated-y += unistd_x32.h
diff --git a/arch/x86/include/uapi/asm/termios.h b/arch/x86/include/uapi/asm/termios.h
deleted file mode 100644
index 280d78a9d966..000000000000
--- a/arch/x86/include/uapi/asm/termios.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/termios.h>
-- 
2.11.0
