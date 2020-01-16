Return-Path: <SRS0=WRhj=3F=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:58930 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730114AbgAPAV2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jan 2020 19:21:28 -0500
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2 0/2] Switching ARC to optimized generic strncpy_from_user
Date: Wed, 15 Jan 2020 16:21:22 -0800
Message-ID: <20200116002124.17988-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-snps-arc@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <20200116002122.KqjKUfGr5Iq6SBSbFXFQYPfYaOHm4_hFGXbGhd3j7n4@z>

Hi,

This series switches ARC to generic word-at-a-time interface.

I understand that going fwd, we may drop the inline versions altogether but this
helps ARC code in the interim.

v2 <- v1
 - Moved __strnlen_user/__strncpy_from_user to under ifdef gaurd [Arnd]
 - Dropped the broken optimization patch [Linus]
 - Folded 2 ARC patches into 1

Thx,
-Vineet

Vineet Gupta (2):
  asm-generic/uaccess: don't define inline functions if noinline lib/*
    in use
  ARC: uaccess: use optimized generic __strnlen_user/__strncpy_from_user

 arch/arc/Kconfig               |  2 +
 arch/arc/include/asm/uaccess.h | 85 ++--------------------------------
 arch/arc/mm/extable.c          | 23 ---------
 include/asm-generic/uaccess.h  |  8 ++++
 4 files changed, 14 insertions(+), 104 deletions(-)

-- 
2.20.1
