Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEE5C3E8C5
	for <linux-arch@archiver.kernel.org>; Fri, 27 Nov 2020 22:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBAC6221FD
	for <linux-arch@archiver.kernel.org>; Fri, 27 Nov 2020 22:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrCQxOkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgK0U4x (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 27 Nov 2020 15:56:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729330AbgK0U4J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Nov 2020 15:56:09 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F77F2223D;
        Fri, 27 Nov 2020 20:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606510568;
        bh=dMMuekuBNzQmFJKaVsfxBM+WX/QdLd4eVfUpm+iNAVI=;
        h=From:Date:Subject:To:Cc:From;
        b=mrCQxOkt9DBpuUuHnYidsarQ8GaKqfcMTv7TrTVANaIHcNyWVqCo15IJALf104U/Q
         gPAcXt+QkeqWMqc/GUkBXcQo6+WcaFWAcFae5VBcSiS016Ufv+d7iq+vNmN5N/uyVj
         eBf2AA3djosMZDm67VsW5UjwcpOoxSHDNa10B5lE=
Received: by mail-ot1-f49.google.com with SMTP id f12so5721825oto.10;
        Fri, 27 Nov 2020 12:56:08 -0800 (PST)
X-Gm-Message-State: AOAM530y0PkEGI4Gqght7Y4Hz2lAxJbNfBi5cTnAKEjPTVQNFZfcaGr+
        6nvZij4TWueUAecOpFqS347192BQ14ZYPCpfTJI=
X-Google-Smtp-Source: ABdhPJzjHQCLfWUmBEOu/CPExDBvIrvJNywm38G6+Gl4Cf2XKvI8Fq/h51TX6t0gSnNDt+jINhaKtXyKMXgGnc3QRC4=
X-Received: by 2002:a9d:be1:: with SMTP id 88mr7814388oth.210.1606510567814;
 Fri, 27 Nov 2020 12:56:07 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 27 Nov 2020 21:55:52 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3eLXunBbxa=i4Z-tXnPwAt==xTg1_hs4TZq7w1LH2dng@mail.gmail.com>
Message-ID: <CAK8P3a3eLXunBbxa=i4Z-tXnPwAt==xTg1_hs4TZq7w1LH2dng@mail.gmail.com>
Subject: [GIT PULL] asm-generic: add correct MAX_POSSIBLE_PHYSMEM_BITS setting
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stefan Agner <stefan@agner.ch>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-fixes-5.10-2

for you to fetch changes up to cef397038167ac15d085914493d6c86385773709:

  arch: pgtable: define MAX_POSSIBLE_PHYSMEM_BITS where needed
(2020-11-16 16:57:18 +0100)

----------------------------------------------------------------
asm-generic: add correct MAX_POSSIBLE_PHYSMEM_BITS setting

This is a single bugfix for a bug that Stefan Agner found on 32-bit
Arm, but that exists on several other architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (1):
      arch: pgtable: define MAX_POSSIBLE_PHYSMEM_BITS where needed

 arch/arc/include/asm/pgtable.h               |  2 ++
 arch/arm/include/asm/pgtable-2level.h        |  2 ++
 arch/arm/include/asm/pgtable-3level.h        |  2 ++
 arch/mips/include/asm/pgtable-32.h           |  3 +++
 arch/powerpc/include/asm/book3s/32/pgtable.h |  2 ++
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 ++
 arch/riscv/include/asm/pgtable-32.h          |  2 ++
 include/linux/pgtable.h                      | 13 +++++++++++++
 8 files changed, 28 insertions(+)
