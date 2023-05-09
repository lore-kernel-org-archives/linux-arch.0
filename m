Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C07C7EE22
	for <linux-arch@archiver.kernel.org>; Tue,  9 May 2023 11:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbjEILIS (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 9 May 2023 07:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbjEILIB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 May 2023 07:08:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EAF49EC;
        Tue,  9 May 2023 04:08:00 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64115eef620so41527176b3a.1;
        Tue, 09 May 2023 04:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683630479; x=1686222479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yU27RYtd81vPNZ12bejpPHLZejv/XbgwelpOomxfow=;
        b=GgUXtNdPzzYsEqIjs7txR52D9wvDQFEf0socOYlZmw/PitxcU23yv41MM37O9oHGZA
         kQ/fNxdrKBfxetxa4uEJyzCfAhXym942L+bIs9ADv2jj+m5DkY0PX0LRchKfB/6hnxIR
         BI50hHMDZwT+cDQ1BwzsYtWVjUf8Qu8wEpzWn9T89vxOTdUSQLhTIegKy1/7hrmh/epo
         g6qRiGfXZT9WDeP23Y/Fz5dJ20/CvoIdiu/wF1YGa38oZStIKLjZ5EuCfJuUsAH9+NOc
         7frAg3dij8RqGB/XtVp2WaFxav4RxVITkt+W+N7we0w98qcvI3pd+3KQm9jKp2mUCbEF
         wySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683630479; x=1686222479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yU27RYtd81vPNZ12bejpPHLZejv/XbgwelpOomxfow=;
        b=TygPLpDlqBntFRD1iZrkzCGzX1NRS36qG6jDjy0DRJjUvoJAlTDtQD9gPFgw1I5nQj
         Oqoiz4iA1VChtoWNOypD465qfhH2Y4+z4BypQ6RIan8vFQ+EgpRqVNkMDrI4pAetMsxY
         afMzjqU7P50Mt7R5tfapNmaX3mNEoC9EeJ19TkMEX1WKNsAJ5cjG5PSTKwzI0Q0ik0Dk
         JraWxxwYbzZF69+ehpRVq6QC7Cg3xvDFT1zHoQuZVelkkVb0L/7hlWjS40MNRN72ZumL
         R5IAQgJl6arEiwPoy6tz/HNZTS84ZFSHDdrM1puC648q3V/s3+9Ezhw0tWY4n0enytu7
         NWAg==
X-Gm-Message-State: AC+VfDzFWOTi+SbcxHmoBGRe7rwfi5qrkpw34qVk23lzpNTk5XU4faty
        MbC7TKwXsr/pi8ZuHVyCjbUV0dCxjPc=
X-Google-Smtp-Source: ACHHUZ6R+6OFfzhp1uGRbjs11n+oFDhM5MImse43sM0dRgYG0Y8jrnmMuFRxF/l7qR3urorXfyAQgg==
X-Received: by 2002:a17:902:d4c7:b0:1a6:bc34:2ee with SMTP id o7-20020a170902d4c700b001a6bc3402eemr16224156plg.21.1683630479628;
        Tue, 09 May 2023 04:07:59 -0700 (PDT)
Received: from wheely.local0.net ([118.208.131.108])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090270c500b001a641ea111fsm1269923plt.112.2023.05.09.04.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:07:59 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 3/3] irqflags: Warn on irq disable when disabled and enable when enabled
Date:   Tue,  9 May 2023 21:07:39 +1000
Message-Id: <20230509110739.241735-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509110739.241735-1-npiggin@gmail.com>
References: <20230509110739.241735-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add CONFIG_IRQFLAGS_DEBUG checks for local_irq_disable() when irqs
are already disabled, and local_irq_enable() when they are enabled.
This could help catch risky or unbalanced irq manipulation.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/irqflags.h       | 26 ++++++++++++++++++++++++--
 kernel/locking/irqflag-debug.c | 14 ++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 5ec0fa71399e..82f54cda2c20 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -157,6 +157,18 @@ do {						\
 #endif
 
 #ifdef CONFIG_DEBUG_IRQFLAGS
+extern void warn_bogus_irq_disable(void);
+#define raw_check_bogus_irq_disable()			\
+	do {						\
+		if (unlikely(arch_irqs_disabled()))	\
+			warn_bogus_irq_disable();	\
+	} while (0)
+extern void warn_bogus_irq_enable(void);
+#define raw_check_bogus_irq_enable()			\
+	do {						\
+		if (unlikely(!arch_irqs_disabled()))	\
+			warn_bogus_irq_enable();	\
+	} while (0)
 extern void warn_bogus_irq_restore(void);
 #define raw_check_bogus_irq_restore()			\
 	do {						\
@@ -164,14 +176,24 @@ extern void warn_bogus_irq_restore(void);
 			warn_bogus_irq_restore();	\
 	} while (0)
 #else
+#define raw_check_bogus_irq_disable() do { } while (0)
+#define raw_check_bogus_irq_enable() do { } while (0)
 #define raw_check_bogus_irq_restore() do { } while (0)
 #endif
 
 /*
  * Wrap the arch provided IRQ routines to provide appropriate checks.
  */
-#define raw_local_irq_disable()		arch_local_irq_disable()
-#define raw_local_irq_enable()		arch_local_irq_enable()
+#define raw_local_irq_disable()				\
+	do {						\
+		raw_check_bogus_irq_disable();		\
+		arch_local_irq_disable();		\
+	} while (0)
+#define raw_local_irq_enable()				\
+	do {						\
+		raw_check_bogus_irq_enable();		\
+		arch_local_irq_enable();		\
+	} while (0)
 #define raw_local_irq_save(flags)			\
 	do {						\
 		typecheck(unsigned long, flags);	\
diff --git a/kernel/locking/irqflag-debug.c b/kernel/locking/irqflag-debug.c
index 810b50344d35..20e5e1b9a86f 100644
--- a/kernel/locking/irqflag-debug.c
+++ b/kernel/locking/irqflag-debug.c
@@ -4,6 +4,20 @@
 #include <linux/export.h>
 #include <linux/irqflags.h>
 
+noinstr void warn_bogus_irq_disable(void)
+{
+	instrumentation_begin();
+	WARN_ONCE(1, "raw_local_irq_disable() called with IRQs disabled\n");
+	instrumentation_end();
+}
+EXPORT_SYMBOL(warn_bogus_irq_disable);
+noinstr void warn_bogus_irq_enable(void)
+{
+	instrumentation_begin();
+	WARN_ONCE(1, "raw_local_irq_enable() called with IRQs enabled\n");
+	instrumentation_end();
+}
+EXPORT_SYMBOL(warn_bogus_irq_enable);
 noinstr void warn_bogus_irq_restore(void)
 {
 	instrumentation_begin();
-- 
2.40.1

