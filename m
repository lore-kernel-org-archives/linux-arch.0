Return-Path: <SRS0=jFrJ=EB=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA9AC4363A
	for <linux-arch@archiver.kernel.org>; Mon, 26 Oct 2020 15:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4957B22409
	for <linux-arch@archiver.kernel.org>; Mon, 26 Oct 2020 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603727640;
	bh=5IVVcrxpYydxJgmqENGuC00vj7m3t2LxF6vYxRp4r2w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=n7c5sHaYt540L/8oZFucPbXScKM/lq4Zni/JwXogP7RqhSYIzwTNv7lhtzw/Ij3kW
	 bW+Y22fpxu5J4NV9YtO352EIty9EIHrgo6+3iyLHRAQVY0BMcH1vsFKzQOh58yoHG5
	 vDn76pJPA506Mi8F2E4SkpbnxQXoEIHVydviswss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773167AbgJZPx7 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 26 Oct 2020 11:53:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1771082AbgJZPx7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Oct 2020 11:53:59 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37F9D22400;
        Mon, 26 Oct 2020 15:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603727639;
        bh=5IVVcrxpYydxJgmqENGuC00vj7m3t2LxF6vYxRp4r2w=;
        h=From:To:Cc:Subject:Date:From;
        b=LXg4jZYqyajpFhZgg/Tuy3Yn4HUDSaJSVKwCDTWrPZIY/+539jPBsjz86NtslNLr/
         qNWfEjM8MnulgkUQFO3gh+nwLrpthClYHYlICjnMPCsowEK+Vco42eMddbndZXQ2m+
         Tn5u/6CZ1HzxlEfxz6Pus4Ly+U2xuem4QofC/JPg=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@linux.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] asm-generic: percpu: avoid Wshadow warning
Date:   Mon, 26 Oct 2020 16:53:48 +0100
Message-Id: <20201026155353.3702892-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Nesting macros that use the same local variable names causes
warnings when building with "make W=2":

include/asm-generic/percpu.h:117:14: warning: declaration of '__ret' shadows a previous local [-Wshadow]
include/asm-generic/percpu.h:126:14: warning: declaration of '__ret' shadows a previous local [-Wshadow]

These are fairly harmless, but since the warning comes from
a global header, the warning happens every time the headers
are included, which is fairly annoying.

Rename the variables to avoid shadowing and shut up the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/percpu.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 35e4a53b83e6..6432a7fade91 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -114,21 +114,21 @@ do {									\
 
 #define __this_cpu_generic_read_nopreempt(pcp)				\
 ({									\
-	typeof(pcp) __ret;						\
+	typeof(pcp) ___ret;						\
 	preempt_disable_notrace();					\
-	__ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));			\
+	___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));			\
 	preempt_enable_notrace();					\
-	__ret;								\
+	___ret;								\
 })
 
 #define __this_cpu_generic_read_noirq(pcp)				\
 ({									\
-	typeof(pcp) __ret;						\
-	unsigned long __flags;						\
-	raw_local_irq_save(__flags);					\
-	__ret = raw_cpu_generic_read(pcp);				\
-	raw_local_irq_restore(__flags);					\
-	__ret;								\
+	typeof(pcp) ___ret;						\
+	unsigned long ___flags;						\
+	raw_local_irq_save(___flags);					\
+	___ret = raw_cpu_generic_read(pcp);				\
+	raw_local_irq_restore(___flags);				\
+	___ret;								\
 })
 
 #define this_cpu_generic_read(pcp)					\
-- 
2.27.0

