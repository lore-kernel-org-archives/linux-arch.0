Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F61C43332
	for <linux-arch@archiver.kernel.org>; Tue,  9 Mar 2021 15:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F157461581
	for <linux-arch@archiver.kernel.org>; Tue,  9 Mar 2021 15:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhCIPSy (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:18:54 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:31498 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbhCIPSr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 10:18:47 -0500
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 129FHiTc030658;
        Wed, 10 Mar 2021 00:17:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 129FHiTc030658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615303065;
        bh=KwJfPDaf46fObQ+3n3hTs9UggnffeJCU/zgw2qw2iLg=;
        h=From:To:Cc:Subject:Date:From;
        b=CbDkADy7F/hicCOfVFlYOTLhDTRY2rChGyMdh5iMWL+jIEDJf1Uz6t9g2jAWmaDzS
         wMuHRsmwDBjUWQn4Foqn4btIgnZAoUoA1tiMniEJpPKbVmjw2VQYrPsnHKHhXUs5Ck
         jiT0ugQVm6xAEElIubWk7PSZkmIzC7OHE01viBpdP/Kwu8o3jXfrY5VHNmkFGI7vz7
         0FNgBjLtyQDKudtwaooIJKwr6oeRiqZrNtDGKoJmBJ1+kXg7SS3HH7NrFiONHssh/r
         F4eQtf7rdmsn1JttEaNVxEaAmJnwRYRhLFdyD3bECS/Qy192DEussYcmoh9GomF/B2
         O0rkMNnTWfmGg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 0/4] kbuild: build speed improvement of CONFIG_TRIM_UNUSED_KSYMS
Date:   Wed, 10 Mar 2021 00:17:33 +0900
Message-Id: <20210309151737.345722-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Now CONFIG_TRIM_UNUSED_KSYMS is revived, but Linus is still unhappy
about the build speed.

I re-implemented this feature, and the build time cost is now
almost unnoticeable level.


(no changes since v1)

Masahiro Yamada (4):
  export.h: make __ksymtab_strings per-symbol section
  kbuild: separate out vmlinux.lds generation
  kbuild: re-implement CONFIG_TRIM_UNUSED_KSYMS to make it work in
    one-pass
  kbuild: remove guarding from TRIM_UNUSED_KSYMS

 Makefile                                      | 34 ++++-----
 arch/alpha/kernel/Makefile                    |  3 +-
 arch/arc/kernel/Makefile                      |  3 +-
 arch/arm/kernel/Makefile                      |  3 +-
 arch/arm64/kernel/Makefile                    |  3 +-
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S             |  1 +
 arch/csky/kernel/Makefile                     |  3 +-
 arch/h8300/kernel/Makefile                    |  2 +-
 arch/hexagon/kernel/Makefile                  |  3 +-
 arch/ia64/kernel/Makefile                     |  3 +-
 arch/m68k/kernel/Makefile                     |  2 +-
 arch/microblaze/kernel/Makefile               |  3 +-
 arch/mips/kernel/Makefile                     |  3 +-
 arch/nds32/kernel/Makefile                    |  3 +-
 arch/nios2/kernel/Makefile                    |  2 +-
 arch/openrisc/kernel/Makefile                 |  3 +-
 arch/parisc/kernel/Makefile                   |  3 +-
 arch/powerpc/kernel/Makefile                  |  2 +-
 arch/powerpc/kernel/vdso32/vdso32.lds.S       |  1 +
 arch/powerpc/kernel/vdso64/vdso64.lds.S       |  1 +
 arch/riscv/kernel/Makefile                    |  2 +-
 arch/s390/kernel/Makefile                     |  3 +-
 arch/s390/purgatory/purgatory.lds.S           |  1 +
 arch/sh/kernel/Makefile                       |  3 +-
 arch/sparc/kernel/Makefile                    |  2 +-
 arch/um/kernel/Makefile                       |  2 +-
 arch/x86/kernel/Makefile                      |  2 +-
 arch/xtensa/kernel/Makefile                   |  3 +-
 include/asm-generic/export.h                  | 25 +------
 include/asm-generic/vmlinux.lds.h             | 13 ++--
 include/linux/export.h                        | 56 ++++----------
 include/linux/ksyms.lds.h                     | 22 ++++++
 init/Kconfig                                  |  3 +-
 scripts/Makefile.build                        |  7 +-
 scripts/Makefile.lib                          |  1 +
 scripts/adjust_autoksyms.sh                   | 73 -------------------
 .../{gen_autoksyms.sh => gen-keep-ksyms.sh}   | 43 ++++++++---
 scripts/gen_ksymdeps.sh                       | 25 -------
 scripts/module.lds.S                          | 23 +++---
 39 files changed, 152 insertions(+), 238 deletions(-)
 create mode 100644 include/linux/ksyms.lds.h
 delete mode 100755 scripts/adjust_autoksyms.sh
 rename scripts/{gen_autoksyms.sh => gen-keep-ksyms.sh} (66%)
 delete mode 100755 scripts/gen_ksymdeps.sh

-- 
2.27.0

