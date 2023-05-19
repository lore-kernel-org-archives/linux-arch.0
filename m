Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4590C7EE26
	for <linux-arch@archiver.kernel.org>; Fri, 19 May 2023 16:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjESQq0 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 19 May 2023 12:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjESQqX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 12:46:23 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A82D7;
        Fri, 19 May 2023 09:46:20 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 3333819A1;
        Fri, 19 May 2023 16:46:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3333819A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684514780; bh=Typx73HH5Gd+kwsk85KMjj7kbllgRR94xrmNw2BZIlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WYI9WZkuzzYdOF/ltlyGKGxTsSsq8BvSweA7Cnufsie0rpDev0ptv3ow+LRSTtmlx
         H/F+kFYDi6PAlZAEKinva456styPUODrq/wK0uk6CqIjrtH3sHPPzGjHj04Q8do8Yj
         uzE97B3xrKEVOlD4H6E6iXctDnVsyJccoDBtsU/Stf/JwKwzGm5rGP5e1und4nj3mx
         I7N2UhDJCd4yVLpJTNmmSe25xPbPvtUL3PC7Mr3k2TNl8U0LFJEOpIZBtC8Na/USdm
         tMJ500oLGErYfQB+9qXtsn0t8bRgKO4Hc1Ba0xJPoszewn4jS1N9/Pvyq/zKeyB63+
         aubfm6Tg3CusQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH 4/7] mips: update a reference to a moved Arm Document
Date:   Fri, 19 May 2023 10:46:04 -0600
Message-Id: <20230519164607.38845-5-corbet@lwn.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519164607.38845-1-corbet@lwn.net>
References: <20230519164607.38845-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arm documentation has moved to Documentation/arch/arm; update a reference
in arch/mips/bmips/setup.c to match.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 arch/mips/bmips/setup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 549a6392a3d2..053805cb741c 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -178,7 +178,10 @@ void __init plat_mem_setup(void)
 	ioport_resource.start = 0;
 	ioport_resource.end = ~0;
 
-	/* intended to somewhat resemble ARM; see Documentation/arm/booting.rst */
+	/*
+	 * intended to somewhat resemble ARM; see
+	 * Documentation/arch/arm/booting.rst
+	 */
 	if (fw_arg0 == 0 && fw_arg1 == 0xffffffff)
 		dtb = phys_to_virt(fw_arg2);
 	else
-- 
2.40.1

