Return-Path: <SRS0=UQh+=BU=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CECC433DF
	for <linux-arch@archiver.kernel.org>; Mon, 10 Aug 2020 02:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483452068F
	for <linux-arch@archiver.kernel.org>; Mon, 10 Aug 2020 02:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXxOU2xG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgHJC1q (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 9 Aug 2020 22:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgHJC1q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Aug 2020 22:27:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F0FC061756;
        Sun,  9 Aug 2020 19:27:46 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k18so4369547pfp.7;
        Sun, 09 Aug 2020 19:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lzxph7HUrtCsNObBpk/2q0N4xl2/b6fgaDXhZwZ8wdw=;
        b=hXxOU2xGFDWhSc6pBH4LsAl13Hv/3Opah9RgUAM9fODj01xKgQGx9kXp9H2xjHfJXv
         uwcKkzXB6aHmFRd6n4+U/gjboLnFEE2NScnQHOQDDjBiX4n2wpykdVdkeo0HMtl65w5u
         DmDY0E5v11yItK6r6dnORxOqWdSHbDcTpgXAjLgRGRqcxGRr9l/vynHLOxqahpp4WxbB
         /H9YBc1AlFkIITjMJ6FvsLneGyu+O5I8WaaqgbZDWHkioWhekTHr1EXZ719YBcJANixA
         RnaVSsoZ8wAMdOPuvFDqPHf4F/JSr2y6Tqn1xxogDiz4Ry4qQGAHDYgZmaCRHj4D/vX7
         rugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lzxph7HUrtCsNObBpk/2q0N4xl2/b6fgaDXhZwZ8wdw=;
        b=o6UQ7HB51qjEbSAlqpYYjHZYob6LPZ8CVT4fm1qbWZS6ordimuArvJZ1R0C9O0K62j
         KAh8mgkBkxbrMP1WJr1xU0eC9MFspT3OebeUKBEC4HJRP9Th8WLnm3bcGhR+Q1dNRHz0
         sfa/kYf+ecv2/UIvjuVYA0aFYXlgyk0tVjIBuI2TXqJTtCsoH/P8o4AEHGDTHQ8htiR1
         nPkR3ZzsSLkHCcQUUAalrQz1tE0JL5+PhBK51AyYJK6BjBWxhzXvdEtcx7mFRgWspBAX
         DJx6oN+Sz0upNvjQixCYjogBTSnkATJpG/JMeUa8djZjWMugeHNIVq9SYrmDlfXZwfRE
         /ABQ==
X-Gm-Message-State: AOAM533iG/tMEqFesveJBnNMW36htrde5WSK1Fak3ftq0jHObu9gwkHX
        qLIHY+QnQ5VczgLV/r3MWHw=
X-Google-Smtp-Source: ABdhPJyo1yMviqJeXAUhMHDnChq1lq67ZG7fUhEPURTQRtsv3hxzDLawTAFoRSCkbWkcDXxswkoPdA==
X-Received: by 2002:a62:77d2:: with SMTP id s201mr23249114pfc.213.1597026465676;
        Sun, 09 Aug 2020 19:27:45 -0700 (PDT)
Received: from bobo.ibm.com (193-116-100-32.tpgi.com.au. [193.116.100.32])
        by smtp.gmail.com with ESMTPSA id l17sm21863475pff.126.2020.08.09.19.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 19:27:44 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Zefan Li <lizefan@huawei.com>
Subject: [PATCH v3 0/8] huge vmalloc mappings
Date:   Mon, 10 Aug 2020 12:27:24 +1000
Message-Id: <20200810022732.1150009-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Not tested on x86 or arm64, would appreciate a quick test there so I can
ask Andrew to put it in -mm. Other option is I can disable huge vmallocs
for them for the time being.

Since v2:
- Rebased on vmalloc cleanups, split series into simpler pieces.
- Fixed several compile errors and warnings
- Keep the page array and accounting in small page units because
  struct vm_struct is an interface (this should fix x86 vmap stack debug
  assert). [Thanks Zefan]

Nicholas Piggin (8):
  mm/vmalloc: fix vmalloc_to_page for huge vmap mappings
  mm: apply_to_pte_range warn and fail if a large pte is encountered
  mm/vmalloc: rename vmap_*_range vmap_pages_*_range
  lib/ioremap: rename ioremap_*_range to vmap_*_range
  mm: HUGE_VMAP arch support cleanup
  mm: Move vmap_range from lib/ioremap.c to mm/vmalloc.c
  mm/vmalloc: add vmap_range_noflush variant
  mm/vmalloc: Hugepage vmalloc mappings

 .../admin-guide/kernel-parameters.txt         |   2 +
 arch/arm64/mm/mmu.c                           |  10 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c      |   8 +-
 arch/x86/mm/ioremap.c                         |  10 +-
 include/linux/io.h                            |   9 -
 include/linux/vmalloc.h                       |  13 +
 init/main.c                                   |   1 -
 mm/ioremap.c                                  | 231 +--------
 mm/memory.c                                   |  60 ++-
 mm/vmalloc.c                                  | 442 +++++++++++++++---
 10 files changed, 453 insertions(+), 333 deletions(-)

-- 
2.23.0

