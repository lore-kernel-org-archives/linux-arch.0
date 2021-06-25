Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736D7C49EA6
	for <linux-arch@archiver.kernel.org>; Fri, 25 Jun 2021 01:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5650D613BA
	for <linux-arch@archiver.kernel.org>; Fri, 25 Jun 2021 01:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhFYBE4 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 24 Jun 2021 21:04:56 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:42820 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbhFYBEw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jun 2021 21:04:52 -0400
Received: by mail-ej1-f42.google.com with SMTP id bg14so12382911ejb.9;
        Thu, 24 Jun 2021 18:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTl2a45oK7ererAoqlIPpBJuapGCJZ6anTugsk9TTSQ=;
        b=hm5wTy3q6g0A2cHvPxRyPMBk9cnkqHfwIev5BnRaTkWNMTY9sZHTmKirIrIEwJ0Gm8
         atrr1l5gcmQGbT35CBN06ZtptMGFRlVren+VP0hn13Nob258EDbouRMdqqWMPTIC6uZi
         G0vlhubmn240wZnsJlSpId87tUgw9K5Ng1oDdvIefstxEuJRxZv6X9HN7tlcACKSGOnK
         5T8zrULsGEvcbxyYXIRWCNX6+S7uKJJ69HqwdDkaGCZvaK1aRdazfkOWAFlym2Dl4sF/
         +Ab7cFzCT/Nz9MqeGWxPtGkYmqWeudQK2Y35XUKiVMj4Lb6h5IlixoeAG0MbNibiJYqb
         t62g==
X-Gm-Message-State: AOAM5314HeSdM5lhAX1g6etMYYIcri50hZzDbMD3Ca3HILNKD9/KjYPC
        m4vpvn2O49SgQux4JdmuMAkg/VZuVweb7Q==
X-Google-Smtp-Source: ABdhPJxVCiXfkPACT3+y9E9wzhTSnrJLbSJnilSAXh81SgJREFTyL7yrttPSEAYBAPGeBAxl1Ro+MQ==
X-Received: by 2002:a17:906:c1d0:: with SMTP id bw16mr8146696ejb.146.1624582950900;
        Thu, 24 Jun 2021 18:02:30 -0700 (PDT)
Received: from msft-t490s.home (host-95-251-17-240.retail.telecomitalia.it. [95.251.17.240])
        by smtp.gmail.com with ESMTPSA id yc29sm1921909ejb.106.2021.06.24.18.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 18:02:30 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, Nick Kossifidis <mick@ics.forth.gr>,
        Guo Ren <guoren@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Drew Fustini <drew@beagleboard.org>
Cc:     linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCH 3/3] lib/string: optimized memset
Date:   Fri, 25 Jun 2021 03:02:00 +0200
Message-Id: <20210625010200.362755-4-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625010200.362755-1-mcroce@linux.microsoft.com>
References: <20210625010200.362755-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

The generic memset is defined as a byte at time write. This is always
safe, but it's slower than a 4 byte or even 8 byte write.

Write a generic memset which fills the data one byte at time until the
destination is aligned, then fills using the largest size allowed,
and finally fills the remaining data one byte at time.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 lib/string.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 69adec252597..598ece5434e9 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -811,10 +811,36 @@ EXPORT_SYMBOL(__sysfs_match_string);
  */
 void *memset(void *s, int c, size_t count)
 {
-	char *xs = s;
+	union types dest = { .as_u8 = s };
 
+	if (count >= MIN_THRESHOLD) {
+		unsigned long cu = (unsigned long)c;
+
+		/* Compose an ulong with 'c' repeated 4/8 times */
+		cu |= cu << 8;
+		cu |= cu << 16;
+#if BITS_PER_LONG == 64
+		cu |= cu << 32;
+#endif
+
+		if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
+			/*
+			 * Fill the buffer one byte at time until
+			 * the destination is word aligned.
+			 */
+			for (; count && dest.as_uptr & word_mask; count--)
+				*dest.as_u8++ = c;
+		}
+
+		/* Copy using the largest size allowed */
+		for (; count >= bytes_long; count -= bytes_long)
+			*dest.as_ulong++ = cu;
+	}
+
+	/* copy the remainder */
 	while (count--)
-		*xs++ = c;
+		*dest.as_u8++ = c;
+
 	return s;
 }
 EXPORT_SYMBOL(memset);
-- 
2.31.1

