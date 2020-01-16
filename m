Return-Path: <SRS0=WRhj=3F=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388769AbgAPRnj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Jan 2020 12:43:39 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 035/174] rtc: cmos: ignore bogus century byte
Date: Thu, 16 Jan 2020 12:40:32 -0500
Message-ID: <20200116174251.24326-35-sashal@kernel.org>
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Eric Wong <e@80x24.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Alessandro Zummo <a.zummo@towertech.it>, Sylvain Chouleur <sylvain.chouleur@intel.com>, Patrick McDermott <patrick.mcdermott@libiquity.com>, linux-rtc@vger.kernel.org, Sasha Levin <sashal@kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20200116174032.zHtowhV1nOc0pJGhTFisQJmFv3A0EeKnqZZPXAiR0xE@z>

From: Eric Wong <e@80x24.org>

[ Upstream commit 2a4daadd4d3e507138f8937926e6a4df49c6bfdc ]

Older versions of Libreboot and Coreboot had an invalid value
(`3' in my case) in the century byte affecting the GM45 in
the Thinkpad X200.  Not everybody's updated their firmwares,
and Linux <= 4.2 was able to read the RTC without problems,
so workaround this by ignoring invalid values.

Fixes: 3c217e51d8a272b9 ("rtc: cmos: century support")

Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Sylvain Chouleur <sylvain.chouleur@intel.com>
Cc: Patrick McDermott <patrick.mcdermott@libiquity.com>
Cc: linux-rtc@vger.kernel.org
Signed-off-by: Eric Wong <e@80x24.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/rtc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/rtc.h b/include/asm-generic/rtc.h
index 4e3b6558331e..3e457ae2d571 100644
--- a/include/asm-generic/rtc.h
+++ b/include/asm-generic/rtc.h
@@ -106,7 +106,7 @@ static inline unsigned int __get_rtc_time(struct rtc_time *time)
 	time->tm_year += real_year - 72;
 #endif
 
-	if (century)
+	if (century > 20)
 		time->tm_year += (century - 19) * 100;
 
 	/*
-- 
2.20.1
