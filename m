Return-Path: <SRS0=XmUN=DN=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8DBC41604
	for <linux-arch@archiver.kernel.org>; Tue,  6 Oct 2020 09:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E11206F7
	for <linux-arch@archiver.kernel.org>; Tue,  6 Oct 2020 09:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxvW8cm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJFJpE (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 6 Oct 2020 05:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFJpE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 05:45:04 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C6BC061755
        for <linux-arch@vger.kernel.org>; Tue,  6 Oct 2020 02:45:04 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w21so8690066pfc.7
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2020 02:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bfz1YZ5dIoN2aGR7YJ8XQT/WwiC9kxrzNC++l1jbOuI=;
        b=cxvW8cm8JXCSsB77mHpkG90iYna+vvl/bxfaG9GOp8LUL/5OTf4zu+4YBT9J+spHTR
         5LVQC2Shsnht7t3HCLEAs9joxOBy5aBMhN5oHYtc96YTVJXOO2QpXcMGaG3qtewaAtkz
         XZSYaddfkGZ/vZqMbiZkoUw81Qk9rc+6BpbjIc6wkDW1dYK7HkkieIIE503fwg2yKTCz
         WLlvzz7a9eysSa2RjiZf3Cit40DVH2UhwrnGUlxhia02lCmi7t/QrxFlxd5SH6bGB5iA
         s5l08juAWB55buEw6955mqbuRZfsAb3WeCMMP3+9XoRgt+ySAQbUWZrDv0WzrUDicUL8
         sCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bfz1YZ5dIoN2aGR7YJ8XQT/WwiC9kxrzNC++l1jbOuI=;
        b=Oc2Yq1e1yE6/hpz9mgntoOnUL+dPze/zfDENr5XFCrUDPR16gHXaTR2UP/Dxsl3ucO
         68XGEbupiTp634fANCO9tGtKoD4+678RmpMLD7L1OT6cTYctWPzkAV6BnJ/9udlravct
         idsSV3LDC7SZonags/pE0lrz/txC6cidwOk/1xT+pJL1+qShhZirNnl3qY8TOVrHFCko
         AfLZmDegzBg82u6+PoJ7heQNJsBMSPOvJiQN4jwiaSSUmH0YuhTuowZNLByF8dalhCU3
         QHHQXftQDw308VjsMNExP/BMV6j/0kLZsYAdam8iQnSKnUbtSJjQA/IhEWbxaivFf0WC
         0QkA==
X-Gm-Message-State: AOAM530O+uG3Zb23i+HZkyriNy3xu8TgBrG26y3tDUxT183lMs5CIvLz
        6JgulHJb461LkJNbnzXQVig=
X-Google-Smtp-Source: ABdhPJxp+VgOeK6IOBqA5KJH7DWJ7aLshWZY0GhcvSUPMT2RLzqI4UXNNoxCW1ir+rOFhynEUPxEdw==
X-Received: by 2002:a63:595a:: with SMTP id j26mr3479617pgm.406.1601977504088;
        Tue, 06 Oct 2020 02:45:04 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id i17sm2829224pfa.29.2020.10.06.02.45.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 02:45:03 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 077F620390F49A; Tue,  6 Oct 2020 18:45:01 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Octavian Purdila <tavi@cs.pub.ro>
Subject: [RFC v7 04/21] um: host: implement os_initcalls and os_exitcalls
Date:   Tue,  6 Oct 2020 18:44:13 +0900
Message-Id: <d3bfb0e0e4300bb5191ae51918dd0795de343dc2.1601960644.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi@cs.pub.ro>

This patch implements the init and exit calls for host code. It uses
the automatic __start_<section> and __stop_<section> variables that
are defined by gcc / ld when using custom sections.

Note that this patch should be merged with "um: move arch/um/os-Linux
dir to tools/um" but for now it is separate to make the review easier.

Signed-off-by: Octavian Purdila <tavi@cs.pub.ro>
---
 tools/um/uml/util.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/um/uml/util.c b/tools/um/uml/util.c
index ecf2f390fad2..4011b36fee7e 100644
--- a/tools/um/uml/util.c
+++ b/tools/um/uml/util.c
@@ -186,3 +186,29 @@ void os_warn(const char *fmt, ...)
 	vfprintf(stderr, fmt, list);
 	va_end(list);
 }
+
+extern void (*__start_os_exitcalls)(void);
+extern void (*__stop_os_exitcalls)(void);
+
+void os_exitcalls(void)
+{
+	exitcall_t *call;
+
+	call = &__stop_os_exitcalls;
+	while (--call >= &__start_os_exitcalls)
+		(*call)();
+}
+
+extern int (*__start_os_initcalls)(void);
+extern int (*__stop_os_initcalls)(void);
+
+int os_initcalls(void)
+{
+	initcall_t *call;
+
+	call = &__stop_os_initcalls;
+	while (--call >= &__start_os_initcalls)
+		(*call)();
+
+	return 0;
+}
-- 
2.21.0 (Apple Git-122.2)

