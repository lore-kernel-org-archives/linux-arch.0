Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48152 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423Ab2FIIOc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 9 Jun 2012 04:14:32 -0400
From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=206/6=5D=20h8300=3A=20fix=20compiler=20warning=20by=20properly=20inlining=20flat=5Fset=5Fpersistent=28=29?=
Date: Sat,  9 Jun 2012 05:13:31 -0300
Message-ID: <1339229611-2326-6-git-send-email-elezegarcia@gmail.com>
In-Reply-To: <1339229611-2326-1-git-send-email-elezegarcia@gmail.com>
References: <1339229611-2326-1-git-send-email-elezegarcia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Ezequiel Garcia <elezegarcia@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20120609081331.DS5k5Qw4PZCVKP4Xgg00_cSsVdRNJICNWBMgHW4CNwM@z>

This patch removes the following warning:
fs/binfmt_flat.c:752: warning: unused variable ‘persistent’
There is neither change in functionality, nor extra code generated.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Ezequiel Garcia <elezegarcia@gmail.com>
---
 arch/h8300/include/asm/flat.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/h8300/include/asm/flat.h b/arch/h8300/include/asm/flat.h
index bd12b31..24e9c93 100644
--- a/arch/h8300/include/asm/flat.h
+++ b/arch/h8300/include/asm/flat.h
@@ -8,7 +8,12 @@
 #define	flat_argvp_envp_on_stack()		1
 #define	flat_old_ram_flag(flags)		1
 #define	flat_reloc_valid(reloc, size)		((reloc) <= (size))
-#define	flat_set_persistent(relval, p)		0
+
+static inline int flat_set_persistent(unsigned long relval,
+				      unsigned long *persistent)
+{
+	return 0;
+}
 
 /*
  * on the H8 a couple of the relocations have an instruction in the
-- 
1.7.3.4

