Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E25C04A94
	for <linux-arch@archiver.kernel.org>; Mon,  7 Aug 2023 15:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjHGPhE (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 7 Aug 2023 11:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjHGPhC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 11:37:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6177099;
        Mon,  7 Aug 2023 08:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E65ED6112C;
        Mon,  7 Aug 2023 15:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB37C433CA;
        Mon,  7 Aug 2023 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691422621;
        bh=7Roui5OuujMMwov1eKQ6IILD+ppjN8Ic19utJAPJSJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fUMzo8uH4T+4igV/HDZM/OaK6H4l4rJttBi4fgXZsTPw0f1Z01aFxLdPDknY8jLLm
         qUSP2YuSUxlj+KJVwYI6wHq5NjNVyf/FIlhBzfefWn1mMnsJcykwTqSTKOLLqlnxjM
         CSP068B/5Zs4kHJ5FFFW843BSKjgMkD+g6/FZGKxi6AE/iuLoJ3uknUI6dJ8tbs9G8
         OqzdtxY0+p/hp92AlsG+wxDpHyN8b+1GqNz+SqqhrEy1wTZQ/1sonNttQVSl3kxXbu
         EuIfFQvwfvSgrX54aFAh1fReFmH73GqnqWlAG/Po+fnZMD0H1xEfnqAM/0vVCnruMC
         5mHjVUX+kkscw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] m68k: remove <asm/export.h>
Date:   Tue,  8 Aug 2023 00:36:54 +0900
Message-Id: <20230807153654.997091-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807153654.997091-1-masahiroy@kernel.org>
References: <20230807153654.997091-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

All *.S files under arch/m68k/ have been converted to include
<linux/export.h> instead of <asm/export.h>.

Remove <asm/export.h>.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/m68k/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 1b720299deb1..0dbf9c5c6fae 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
-generic-y += export.h
 generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
-- 
2.39.2

