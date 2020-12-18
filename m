Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AE8C49ECB
	for <linux-arch@archiver.kernel.org>; Fri, 18 Dec 2020 14:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B8823AC0
	for <linux-arch@archiver.kernel.org>; Fri, 18 Dec 2020 14:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgLROfW (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 18 Dec 2020 09:35:22 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:41181 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgLROfV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 09:35:21 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N5mOZ-1k2N2Y27Wl-017Bhg; Fri, 18 Dec 2020 15:31:45 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, msalter@redhat.com, jacquiot.aurelien@gmail.com,
        gerg@linux-m68k.org, geert@linux-m68k.org,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        maz@kernel.org, tony@atomide.com, arnd@arndb.de,
        linux-alpha@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 03/23] arch: arm: drop misleading warning on spurious IRQ
Date:   Fri, 18 Dec 2020 15:31:02 +0100
Message-Id: <20201218143122.19459-4-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218143122.19459-1-info@metux.net>
References: <20201218143122.19459-1-info@metux.net>
X-Provags-ID: V03:K1:Q7YF/PDtGFAPMnh/5r0ZcLG8kqJyVdYcOY3wH4BQkuTsF8QHL41
 DCK1dWguFjXEIBUIwp3QoH++xWCXqbCcXeccPyM3aqFPYRuuO4i2de6zlsd0NdKRK6xqQe0
 DxEPxyjeex1FejnEM+tWJsPdCp7wf1aQCsUU8mqsEGpqfqArLSlUHMjgsFfrUtSNuDwRwmK
 ehfpOzK01Tstvxp3exzFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R0+M41aEnoc=:MlPinXXglCsnz7BD8P5+AK
 Bf8FW1qIyEMRI3yOO7X4hZh4eGnYkeqxF0vIZQB8sPQv36r/4ZOnU0W0NbI0AYmgMdGGTmbSm
 RIcVcFL36u9jXTkDcbXQzYZ+qXEl5tksfc+jHgTnw7lmcKiiuwNFAi5FTX9kzqd/SdaWXmVNZ
 8S9b0y80hqhU+aC9WxZyIQ7rJKpgEvl6rMjms0f4I9M+WcTQun1DawRDXknlACxYw6+1YY4Ci
 1MC4DHt2THw66SrSXn+9/lBKldI4B1X/+IPQHVjATmNGwUPeiRn64WHNUgFlPQdbNaFGttID8
 /B62Km5PVaXNS3CGWm2FG02ibnpqTrFeuyzGWvBUlTr3SLdMGY2J9Ll+PXF/hyRIerL4LdhEP
 YD1JxyYn3zCjDwXDkZzs2swPEA2+jPQ0Spg4LpXs6/PuUvJTscbUYOm5K9TSI
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The warning in ack_bad_irq() is misleading in several ways:
* the term "vector" isn't quite correct
* the printing format isn't consistent across the archs: some print decimal,
  some hex, some hex w/o 0x prefix.
* the printed linux irq isn't meaningful in all cases - we actually would
  want it to print the hw irq.

Since all call sites already print out more detailed and correct information,
we just don't need to duplicate this in each single arch. So just drop it.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/arm/include/asm/hw_irq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/hw_irq.h b/arch/arm/include/asm/hw_irq.h
index cecc13214ef1..5305c7e33aee 100644
--- a/arch/arm/include/asm/hw_irq.h
+++ b/arch/arm/include/asm/hw_irq.h
@@ -9,7 +9,6 @@ static inline void ack_bad_irq(int irq)
 {
 	extern unsigned long irq_err_count;
 	irq_err_count++;
-	pr_crit("unexpected IRQ trap at vector %02x\n", irq);
 }
 
 #define ARCH_IRQ_INIT_FLAGS	(IRQ_NOREQUEST | IRQ_NOPROBE)
-- 
2.11.0

