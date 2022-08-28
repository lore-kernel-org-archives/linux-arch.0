Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D95AC0502E
	for <linux-arch@archiver.kernel.org>; Sun, 28 Aug 2022 02:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiH1Cq0 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 27 Aug 2022 22:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiH1CqV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 22:46:21 -0400
Received: from condef-05.nifty.com (condef-05.nifty.com [202.248.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B943B2CDE1
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 19:46:20 -0700 (PDT)
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-05.nifty.com with ESMTP id 27S2eisn018104
        for <linux-arch@vger.kernel.org>; Sun, 28 Aug 2022 11:40:44 +0900
Received: from localhost.localdomain (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 27S2e6Gm030639;
        Sun, 28 Aug 2022 11:40:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 27S2e6Gm030639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661654409;
        bh=nmi4TuCe4/ZAlGow19MAlTrGk9A2EH+pzmZGuA/W3Iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qMLJ5SQP1vKLWoZ0ax+e9zBVS7as01zWNxNsoj/LMTHa6jdioGqsniKe0Ku6K90Tf
         2RnrOwiABHIT3eExKjZ2FjseWXMgqa/3VB9AAg0AyoFwcSuiZYxT2bRdg+njRkanN6
         d/4EXT6tk+PBFSUTeB85J927zauUO6E7Ju0o+AeFtLNJ4uqz1igz0e78tamixkU3Yt
         UJTKiH4BRFhztYsWBLo0xVA0DvdIzg5CO8EVzG8bymkH67h1B5JYvcFtGVTDwcivrK
         OCHamCDi9u+sauMx+MwtPM8h69hV9NtKF1IxxSGh9IxskcHLLqFuzc0vYoPHT+bZPt
         6ywSI9ETb0POA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 04/15] init/version.c: remove #include <linux/version.h>
Date:   Sun, 28 Aug 2022 11:39:52 +0900
Message-Id: <20220828024003.28873-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220828024003.28873-1-masahiroy@kernel.org>
References: <20220828024003.28873-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is unneeded since commit 073a9ecb3a73 ("init/version.c: remove
Version_<LINUX_VERSION_CODE> symbol").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 init/version.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/init/version.c b/init/version.c
index b7f9559d417c..3391c4051bf3 100644
--- a/init/version.c
+++ b/init/version.c
@@ -16,7 +16,6 @@
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <generated/utsrelease.h>
-#include <linux/version.h>
 #include <linux/proc_ns.h>
 
 struct uts_namespace init_uts_ns = {
-- 
2.34.1

