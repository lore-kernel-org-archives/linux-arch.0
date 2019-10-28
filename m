Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35849 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389536AbfJ1VGG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Oct 2019 17:06:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id c22so378394wmd.1
        for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2019 14:06:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/6] Improvements for random.h/archrandom.h
Date: Mon, 28 Oct 2019 22:05:53 +0100
Message-ID: <20191028210559.8289-1-rth@twiddle.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20191028210553.iHN0ImSxbd4WF7wZmuVrxouw_UHufa4-B1tiVM68v3g@z>

During patch review for an addition of archrandom.h for arm64,
it was suggeted that the arch_random_get_* functions should be
marked __must_check.  Which does sound like a good idea, since
the by-reference integer output may be uninitialized when the
boolean result is false.

In addition, I noticed a few other minor inconsistencies between
the different architectures: x86 defines some functional macros
outside CONFIG_ARCH_RANDOM, and powerpc isn't using bool.


r~


Richard Henderson (6):
  random: Mark CONFIG_ARCH_RANDOM functions __must_check
  x86: Move arch_has_random* inside CONFIG_ARCH_RANDOM
  x86: Mark archrandom.h functions __must_check
  powerpc: Use bool in archrandom.h
  powerpc: Mark archrandom.h functions __must_check
  s390x: Mark archrandom.h functions __must_check

 arch/powerpc/include/asm/archrandom.h | 24 +++++++++++++-----------
 arch/s390/include/asm/archrandom.h    |  8 ++++----
 arch/x86/include/asm/archrandom.h     | 24 ++++++++++++------------
 include/linux/random.h                |  8 ++++----
 4 files changed, 33 insertions(+), 31 deletions(-)

-- 
2.17.1
