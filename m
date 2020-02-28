From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 2/9] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Date: Thu, 27 Feb 2020 16:22:37 -0800
Message-ID: <20200228002244.15240-3-keescook@chromium.org>
References: <20200228002244.15240-1-keescook@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46479 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730430AbgB1AWy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 19:22:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id o24so710540pfp.13
        for <linux-arch@vger.kernel.org>; Thu, 27 Feb 2020 16:22:52 -0800 (PST)
In-Reply-To: <20200228002244.15240-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@suse.de>
Cc: Kees Cook <keescook@chromium.org>, "H.J. Lu" <hjl.tools@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org

For vmlinux linking, no architecture uses the .gnu.version* section,
so remove it via the common DISCARDS macro in preparation for adding
--orphan-handling=warn more widely.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e00f41aa8ec4..303597e51396 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -902,6 +902,7 @@
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\
+	*(.gnu.version*)						\
 	}
 
 /**
-- 
2.20.1
