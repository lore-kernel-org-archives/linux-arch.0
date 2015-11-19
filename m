From: Jia He <hejianet@gmail.com>
Subject: [PATCH 0/3] Improve bitmap_empty and bitmap_full
Date: Thu, 19 Nov 2015 10:31:51 +0800
Message-ID: <1447900314-5727-1-git-send-email-hejianet@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:35655 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587AbbKSCcJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2015 21:32:09 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Denys Vlasenko <dvlasenk@redhat.com>, Kyungmin Park <kyungmin.park@samsung.com>, Michal Nazarewicz <mina86@mina86.com>, Yury Norov <yury.norov@gmail.com>, Tejun Heo <tj@kernel.org>, Martin Kepplinger <martink@posteo.de>, George Spelvin <linux@horizon.com>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jia He <hejianet@gmail.com>

find_fisrt_{zero_}bit are too heavy for bitmap_{full,empty}. We don't 
need to calculate and compare the position of bitmap. This set of patch
instroduces lightweight api and replaces the heavy one.

Jia He (3):
  linux/bitmap: Move 2 mask macro from bitmap.h to bitops.h
  lib: Introduce 2 find bit api: all_is_bit_{one,zero}
  linux/bitmap: Replace find_fisrt_{zero_}bit with the new lightweight api 

 include/asm-generic/bitops/find.h |  3 +++
 include/linux/bitmap.h            |  7 ++----
 include/linux/bitops.h            |  4 ++++
 lib/find_bit.c                    | 50 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 5 deletions(-)

-- 
2.5.0
