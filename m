Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52914 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab1KRTiH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2011 14:38:07 -0500
From: David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH RFC 4/5] MIPS:  Select BUILDTIME_EXTABLE_SORT
Date: Fri, 18 Nov 2011 11:37:47 -0800
Message-ID: <1321645068-20475-5-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com>
References: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mips@linux-mips.org, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, x86@kernel.org
Cc: David Daney <david.daney@cavium.com>
Message-ID: <20111118193747.oBGaQVU2LOtxXH5a2ywETfGjQCL0csSVEXx9oeZUdBM@z>

From: David Daney <david.daney@cavium.com>

We can sort the exeception table at build time for MIPS, so let's do
it.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0c55582..adfe083 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -25,6 +25,7 @@ config MIPS
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_JUMP_LABEL
 	select IRQ_FORCED_THREADING
+	select BUILDTIME_EXTABLE_SORT
 
 menu "Machine selection"
 
-- 
1.7.2.3

