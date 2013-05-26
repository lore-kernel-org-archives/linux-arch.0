Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:17615 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab3EZIvQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 26 May 2013 04:51:16 -0400
Message-ID: <51A1CCCE.1020103@asianux.com>
Date: Sun, 26 May 2013 16:50:22 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
Subject: [PATCH] arch: x86: platform: mrst: pr_err() need notice that 'sdev->modalias'
 may not a NUL terminated string.
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: "mingo@redhat.com" <mingo@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, sebastian@breakpoint.cc, zhangyanfei@cn.fujitsu.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20130526085022.9sswgBcdDQUolP9oCGP8mktp2REX21VqjbA4JkmtEvI@z>


According to the areas which use "%16.16s" within this file, the
'sdev->modalias' may not always be a NUL terminated string.

So need use "%.16s" instead of "%s" in pr_err(), or may cause issue.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/x86/platform/mrst/mrst.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/platform/mrst/mrst.c b/arch/x86/platform/mrst/mrst.c
index a0a0a43..e2e069c 100644
--- a/arch/x86/platform/mrst/mrst.c
+++ b/arch/x86/platform/mrst/mrst.c
@@ -746,7 +746,7 @@ static void __init intel_scu_spi_device_register(struct spi_board_info *sdev)
 
 	new_dev = kzalloc(sizeof(*sdev), GFP_KERNEL);
 	if (!new_dev) {
-		pr_err("failed to alloc mem for delayed spi dev %s\n",
+		pr_err("failed to alloc mem for delayed spi dev %.16s\n",
 			sdev->modalias);
 		return;
 	}
-- 
1.7.7.6
