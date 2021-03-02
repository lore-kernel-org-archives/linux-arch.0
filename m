Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD564C433DB
	for <linux-arch@archiver.kernel.org>; Wed,  3 Mar 2021 05:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FFCE64EA4
	for <linux-arch@archiver.kernel.org>; Wed,  3 Mar 2021 05:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354180AbhCCF1O (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 3 Mar 2021 00:27:14 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:13051 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352009AbhCBRvJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 12:51:09 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DqkXq2Y55z9v1By;
        Tue,  2 Mar 2021 18:25:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3XK1Ji_IwYa7; Tue,  2 Mar 2021 18:25:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DqkXq139Yz9v1Bx;
        Tue,  2 Mar 2021 18:25:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D6D058B7B5;
        Tue,  2 Mar 2021 18:25:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fhn6Nsk8d_7h; Tue,  2 Mar 2021 18:25:16 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 81F848B75F;
        Tue,  2 Mar 2021 18:25:16 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 41160674A2; Tue,  2 Mar 2021 17:25:16 +0000 (UTC)
Message-Id: <cover.1614705851.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 0/7] Improve boot command line handling
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com,
        robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org
Date:   Tue,  2 Mar 2021 17:25:16 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The purpose of this series is to improve and enhance the
handling of kernel boot arguments.

It is first focussed on powerpc but also extends the capability
for other arches.

This is based on suggestion from Daniel Walker <danielwa@cisco.com>

Christophe Leroy (7):
  cmdline: Add generic function to build command line.
  drivers: of: use cmdline building function
  powerpc: convert to generic builtin command line
  cmdline: Add capability to prepend the command line
  powerpc: add capability to prepend default command line
  cmdline: Gives architectures opportunity to use generically defined
    boot cmdline manipulation
  powerpc: use generic CMDLINE manipulations

 arch/powerpc/Kconfig            | 37 ++-----------------
 arch/powerpc/kernel/prom_init.c | 35 +++---------------
 drivers/of/fdt.c                | 23 ++----------
 include/linux/cmdline.h         | 65 +++++++++++++++++++++++++++++++++
 init/Kconfig                    | 56 ++++++++++++++++++++++++++++
 5 files changed, 133 insertions(+), 83 deletions(-)
 create mode 100644 include/linux/cmdline.h

-- 
2.25.0

