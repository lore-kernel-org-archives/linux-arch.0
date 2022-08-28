Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2174ECAAD1
	for <linux-arch@archiver.kernel.org>; Sun, 28 Aug 2022 02:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiH1Cph (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 27 Aug 2022 22:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiH1Cpf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 22:45:35 -0400
Received: from condef-04.nifty.com (condef-04.nifty.com [202.248.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18462A248
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 19:45:34 -0700 (PDT)
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-04.nifty.com with ESMTP id 27S2elOS013998
        for <linux-arch@vger.kernel.org>; Sun, 28 Aug 2022 11:40:47 +0900
Received: from localhost.localdomain (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 27S2e6Gq030639;
        Sun, 28 Aug 2022 11:40:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 27S2e6Gq030639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661654411;
        bh=pcMhDiiIpuG9IA8eOqVr1JYW01owykoWnir+g7tldYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jo1j2k/N+uaWBpzCO54Kz2cFlciKFXqxfEn0CjcUzR14SbWmQTc8i++Y6WlwjAn65
         cosm6dj73cNrg4DQtkr5C/yI9RRGoAXj1Z9CxJ1x4whDqmcLH5rQUoUX7fPkaMmjzk
         1QSmNsrqFjfTaam3WY484+K6ugzgwig4t1xCjfEgZ94O3XlAinJ57KxqqY6+i5LU2X
         ieMjy28nzCMjtf5iH7zSGEtomAcbDRtqap89dL+oOUngojV7EC8jy0nmlhKdum8WiW
         d1ONiErX360qwSNwY87ySwQGnZREiIj9R3De1Ay+tqlA5mcpVjvgrVR4NSft1aI0Hx
         kEh1TmAqzvFlw==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 08/15] Revert "kbuild: Make scripts/compile.h when sh != bash"
Date:   Sun, 28 Aug 2022 11:39:56 +0900
Message-Id: <20220828024003.28873-9-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220828024003.28873-1-masahiroy@kernel.org>
References: <20220828024003.28873-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This reverts commit [1] in the pre-git era.

I do not know what problem happened in the script when sh != bash
because there is no commit message.

Now that this script is much simpler than it used to be, let's revert
it, and let' see. (If this turns out to be problematic, fix the code
with proper commit description.)

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=11acbbbb8a50f4de7dbe4bc1b5acc440dfe81810

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mkcompile_h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
index b76ccbbc094b..2596f78e52ef 100755
--- a/scripts/mkcompile_h
+++ b/scripts/mkcompile_h
@@ -5,9 +5,6 @@ UTS_MACHINE=$1
 CC_VERSION="$2"
 LD=$3
 
-# Do not expand names
-set -f
-
 if test -z "$KBUILD_BUILD_USER"; then
 	LINUX_COMPILE_BY=$(whoami | sed 's/\\/\\\\/')
 else
-- 
2.34.1

