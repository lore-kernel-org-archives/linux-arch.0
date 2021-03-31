Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B9BC43611
	for <linux-arch@archiver.kernel.org>; Wed, 31 Mar 2021 16:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E2961029
	for <linux-arch@archiver.kernel.org>; Wed, 31 Mar 2021 16:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbhCaQtD (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 31 Mar 2021 12:49:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63643 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234299AbhCaQsp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Mar 2021 12:48:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F9XMH0NNJz9txhg;
        Wed, 31 Mar 2021 18:48:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1tazS8zw61p1; Wed, 31 Mar 2021 18:48:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F9XMG6hnsz9txhd;
        Wed, 31 Mar 2021 18:48:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0539C8B828;
        Wed, 31 Mar 2021 18:48:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id l34aaPgZOBSO; Wed, 31 Mar 2021 18:48:43 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BD66B8B80D;
        Wed, 31 Mar 2021 18:48:43 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 994F567641; Wed, 31 Mar 2021 16:48:43 +0000 (UTC)
Message-Id: <cover.1617209141.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH RESEND v1 0/4] powerpc/vdso: Add support for time namespaces
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dima@arista.com, avagin@gmail.com, arnd@arndb.de,
        tglx@linutronix.de, vincenzo.frascino@arm.com, luto@kernel.org,
        linux-arch@vger.kernel.org
Date:   Wed, 31 Mar 2021 16:48:43 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[Sorry, resending with complete destination list, I used the wrong script on the first delivery]

This series adds support for time namespaces on powerpc.

All timens selftests are successfull.

Christophe Leroy (3):
  lib/vdso: Mark do_hres_timens() and do_coarse_timens()
    __always_inline()
  lib/vdso: Add vdso_data pointer as input to
    __arch_get_timens_vdso_data()
  powerpc/vdso: Add support for time namespaces

Dmitry Safonov (1):
  powerpc/vdso: Separate vvar vma from vdso

 .../include/asm/vdso/compat_gettimeofday.h    |   3 +-
 arch/arm64/include/asm/vdso/gettimeofday.h    |   2 +-
 arch/powerpc/Kconfig                          |   3 +-
 arch/powerpc/include/asm/mmu_context.h        |   2 +-
 arch/powerpc/include/asm/vdso/gettimeofday.h  |  10 ++
 arch/powerpc/include/asm/vdso_datapage.h      |   2 -
 arch/powerpc/kernel/vdso.c                    | 138 ++++++++++++++++--
 arch/powerpc/kernel/vdso32/vdso32.lds.S       |   2 +-
 arch/powerpc/kernel/vdso64/vdso64.lds.S       |   2 +-
 arch/s390/include/asm/vdso/gettimeofday.h     |   3 +-
 arch/x86/include/asm/vdso/gettimeofday.h      |   3 +-
 lib/vdso/gettimeofday.c                       |  31 ++--
 12 files changed, 162 insertions(+), 39 deletions(-)

-- 
2.25.0

