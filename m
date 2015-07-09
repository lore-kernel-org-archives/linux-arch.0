From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 0/3] atomic_or() related changes
Date: Thu, 9 Jul 2015 13:43:16 +0530
Message-ID: <1436429599-10762-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:33324 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbGIINr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 04:13:47 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Hi,

This started off as an effort to convert a cmpxchg based loop in arc/kernel/smp.c
to an API which is more LLOCK/SCOND friendly.

e.g.
        do {
                new = old = ACCESS_ONCE(*ipi_data_ptr);
                new |= 1U << msg;
        } while (cmpxchg(ipi_data_ptr, old, new) != old);

The generated code is horrible. There are 2 useless branches here and a
LD/LLOCK to same address all inside a loop.

8015cefc:	ld_s       r2,[r3,0]
8015cefe:	or         r5,r2,r1
8015cf02:	llock      r4,[r3]
8015cf06:	brne       r4,r2,8015cf12
8015cf0a:	scond      r5,[r3]
8015cf0e:	bnz        8015cf02
8015cf12:	brne       r2,r4,8015cefc

An atomic_or() kind of API is better suited to generate something like below

8015cf02:	llock      r4,[r3]
8015cf06:	or         r5,r2,r1
8015cf0a:	scond      r5,[r3]
8015cf0e:	bnz        8015cf02

Although this doesn't work for the specific instance I wanted to fix as
ipi_data_ptr is not atomic_t, I did run into a few things which could be
improved, hence this series.

Compile tested on ARC, ARM, x86.

I do have some concern about mixing long and int on 64 bit arch, which I've
captured inline in patch 2/3. It is most likely a lack of understand on my
part, but worth asking..

Thx,
-Vineet

Vineet Gupta (3):
  asm-generic/atomic.h: ARCH_HAS_ATOMIC_OR -> CONFIG_ARCH_HAS_ATOMIC_OR
  brcmfmac: dhd_sdio.c: use existing atomic_or primitive
  ARC: provide atomic_or() and define ARCH_HAS_ATOMIC_OR

 arch/arc/include/asm/atomic.h                  |  9 +++++++++
 drivers/net/wireless/brcm80211/brcmfmac/sdio.c | 13 ++-----------
 include/asm-generic/atomic.h                   |  2 +-
 include/linux/atomic.h                         |  4 ++--
 4 files changed, 14 insertions(+), 14 deletions(-)

-- 
1.9.1
