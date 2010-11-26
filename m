From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 0/2] little-endian bitops bugfixes
Date: Sat, 27 Nov 2010 01:28:37 +0900
Message-ID: <1290788919-5057-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40132 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160Ab0KZQ2a (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Nov 2010 11:28:30 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>

The little-endian bitops patch series has been added to the -mm tree
recently. I found two problems so far.

Akinobu Mita (2):
  bitops: use find_first_zero_bit() instead of find_next_zero_bit(addr,
    size, 0)
  bitops: introduce CONFIG_GENERIC_FIND_LE_BIT

 arch/frv/Kconfig                |    4 ++++
 arch/h8300/Kconfig              |    4 ++++
 arch/m32r/Kconfig               |    4 ++++
 arch/microblaze/Kconfig         |    3 +++
 arch/mips/Kconfig               |    4 ++++
 arch/parisc/Kconfig             |    4 ++++
 arch/powerpc/Kconfig            |    4 ++++
 arch/sh/Kconfig                 |    3 +++
 arch/sparc/Kconfig              |    4 ++++
 arch/xtensa/Kconfig             |    3 +++
 include/asm-generic/bitops/le.h |    8 +++++---
 lib/Kconfig                     |    3 +++
 lib/Makefile                    |    1 +
 lib/find_next_bit.c             |    3 +++
 14 files changed, 49 insertions(+), 3 deletions(-)

-- 
1.7.3.2
