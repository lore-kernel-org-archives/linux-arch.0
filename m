Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([192.83.249.54]:57320 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757756AbXGJDAw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2007 23:00:52 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [x86 setup 01/33] x86 setup: MAINTAINERS: formally take responsibility for the i386 boot code
Date: Mon,  9 Jul 2007 19:51:40 -0700
Message-Id: <11840360383913-git-send-email-hpa@zytor.com>
In-Reply-To: <11840359321823-git-send-email-hpa@zytor.com>
References: <11840359321823-git-send-email-hpa@zytor.com>
Message-Id: <2034f71d414def30de582fb59573295cadbdabb4.1184032748.git.hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, andi@firstfloor.org, akpm@linux-foundation.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
List-ID: <linux-arch.vger.kernel.org>

From: H. Peter Anvin <hpa@zytor.com>

Change MAINTAINERS to formally take responsibility for the i386 boot code.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
---
 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index df40a4e..7f92ce2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1750,8 +1750,8 @@ T:	http://www.harbaum.org/till/i2c_tiny_usb
 S:	Maintained
 
 i386 BOOT CODE
-P:	Riley H. Williams
-M:	Riley@Williams.Name
+P:	H. Peter Anvin
+M:	hpa@zytor.com
 L:	Linux-Kernel@vger.kernel.org
 S:	Maintained
 
-- 
1.5.2.2

