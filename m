From: Jia He <hejianet@gmail.com>
Subject: [PATCH v2 0/3] Improve bitmap_empty and bitmap_full
Date: Thu, 19 Nov 2015 14:48:41 +0800
Message-ID: <1447915724-29709-1-git-send-email-hejianet@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:35747 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755861AbbKSGtX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2015 01:49:23 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Denys Vlasenko <dvlasenk@redhat.com>, Kyungmin Park <kyungmin.park@samsung.com>, Michal Nazarewicz <mina86@mina86.com>, Yury Norov <yury.norov@gmail.com>, Tejun Heo <tj@kernel.org>, Martin Kepplinger <martink@posteo.de>, George Spelvin <linux@horizon.com>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jia He <hejianet@gmail.com>

find_fisrt_{zero_}bit are too heavy for bitmap_{full,empty}. We don't 
need to calculate and compare the position of bitmap. This set of patch
instroduces lightweight api and replaces the heavy one.

v2: Move the declarations to linux/bitops.h for compilation

Jia He (3):
  Move 2 mask macro from bitmap.h to bitops.h
  Introduce 2 bit ops api: all_is_bit_{one,zero}
  Replace find_fisrt_{zero_}bit with the new lightweight api

 include/linux/bitmap.h |  7 ++-----
 include/linux/bitops.h |  7 +++++++
 lib/find_bit.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 5 deletions(-)

-- 
2.5.0
