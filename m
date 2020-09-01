Return-Path: <SRS0=ECFR=CK=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93CDC433E2
	for <linux-arch@archiver.kernel.org>; Tue,  1 Sep 2020 14:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C6A21D6C
	for <linux-arch@archiver.kernel.org>; Tue,  1 Sep 2020 14:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2f743sdd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Ga86mko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgIAOPO (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgIALt0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 07:49:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7655C061260;
        Tue,  1 Sep 2020 04:48:06 -0700 (PDT)
Date:   Tue, 01 Sep 2020 11:48:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960882;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y2/6jghBtX5EU5gikVpmYI7uEvJ3z2/flvzwOMJ2oS4=;
        b=2f743sddocZ/AjZe3Y8FU6ATuiKyDMLN2QXgaDl+YzZfbFUgAD3Xl79XvsdUexLlV45tVt
        aO2HUiv9bgzo1LoxQ8LvuhjFSXF1EQ0DdpQHeQxUa9M6mqTCcdnXyWBzPsQqu5hn6Q9kOy
        HjHV15VO7GfIGKq71OMvsndE3X0AKH2TLx2Pmzl2qvTh2Cy0v8U/Phor0JivbEHSousAN3
        70SjXmeWV/RbKMiX4EqdDqrQH36O6eX/bHhgdBbYtFb16blvgD15R9Q5R1UXId33RoZxSV
        lFzDdCoWrS7hy9bVMXZY4hdBo0V+55Gld7fov4Fja/IZQUM/5MA497+BlcnROA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960882;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y2/6jghBtX5EU5gikVpmYI7uEvJ3z2/flvzwOMJ2oS4=;
        b=0Ga86mkoVGFK31qCWK7pP82i+WDcDWUL4yPD/QLREyZBsxbdzs/FmmPpBBkhCCM8S3E+Od
        CCpMNJ0Mtc2WtKAQ==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] vmlinux.lds.h: Create COMMON_DISCARDS
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        linux-arch@vger.kernel.org, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-2-keescook@chromium.org>
References: <20200821194310.3089815-2-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896088150.20229.12193229393565370294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     03c2b85cb7f13e9bd82cbe4201ede52177d433f5
Gitweb:        https://git.kernel.org/tip/03c2b85cb7f13e9bd82cbe4201ede52177d433f5
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:42:42 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:50:34 +02:00

vmlinux.lds.h: Create COMMON_DISCARDS

Collect the common DISCARD sections for architectures that need more
specialized discard control than what the standard DISCARDS section
provides.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org
Link: https://lore.kernel.org/r/20200821194310.3089815-2-keescook@chromium.org
---
 include/asm-generic/vmlinux.lds.h |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7616ff0..184b23d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -954,13 +954,16 @@
 	EXIT_DATA
 #endif
 
+#define COMMON_DISCARDS							\
+	*(.discard)							\
+	*(.discard.*)							\
+	*(.modinfo)
+
 #define DISCARDS							\
 	/DISCARD/ : {							\
 	EXIT_DISCARDS							\
 	EXIT_CALL							\
-	*(.discard)							\
-	*(.discard.*)							\
-	*(.modinfo)							\
+	COMMON_DISCARDS							\
 	}
 
 /**
