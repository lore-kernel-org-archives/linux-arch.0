From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH -mm 0/6] convert little-endian bitops macros to inline functions
Date: Thu, 27 Jan 2011 22:56:17 +0900
Message-ID: <1296136583-13815-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47979 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902Ab1A0Nzk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jan 2011 08:55:40 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>

The little-endian bitops patch series has been added to the -mm tree.
This additional patch series converts all little-endian bitops macros
to static inline functions with proper prototypes.

Akinobu Mita (6):
  asm-generic: convert little-endian bitops macros to static inline
    functions
  powerpc: convert little-endian bitops macros to static inline
    functions
  s390: convert little-endian bitops macros to static inline functions
  arm: convert little-endian bitops macros to static inline functions
  m68k: convert little-endian bitops macros to static inline functions
  m68knommu: convert little-endian bitops macros to static inline
    functions

 arch/arm/include/asm/bitops.h     |   70 +++++++++++++++++++++++++----------
 arch/m68k/include/asm/bitops_mm.h |   41 +++++++++++++++------
 arch/m68k/include/asm/bitops_no.h |   12 ++++--
 arch/powerpc/include/asm/bitops.h |   43 +++++++++++++++-------
 arch/s390/include/asm/bitops.h    |   48 +++++++++++++++++-------
 include/asm-generic/bitops/le.h   |   73 ++++++++++++++++++++++++++-----------
 6 files changed, 201 insertions(+), 86 deletions(-)

-- 
1.7.3.4
