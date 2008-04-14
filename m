Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.188]:29633 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762676AbYDNQih (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Apr 2008 12:38:37 -0400
Received: by rn-out-0910.google.com with SMTP id e11so745425rng.17
        for <linux-arch@vger.kernel.org>; Mon, 14 Apr 2008 09:38:35 -0700 (PDT)
Subject: [PATCH 05/10] mmc: Use get/put_unaligned_* helpers
From: Harvey Harrison <harvey.harrison@gmail.com>
Content-Type: text/plain
Date: Mon, 14 Apr 2008 09:37:55 -0700
Message-ID: <1208191075.5721.27.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20080414163755.7y4ZQwhsJzi1O7mgLi79QrPjWToZojqSMhYT6IEW25c@z>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/mmc/host/mmc_spi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 365024b..3550858 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -340,7 +340,7 @@ checkstatus:
 
 	/* SPI R3, R4, or R7 == R1 + 4 bytes */
 	case MMC_RSP_SPI_R3:
-		cmd->resp[1] = be32_to_cpu(get_unaligned((u32 *)cp));
+		cmd->resp[1] = get_unaligned_be32(cp);
 		break;
 
 	/* SPI R1 == just one status byte */
-- 
1.5.5.144.g3e42


