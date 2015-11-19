From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 0/3] Improve bitmap_empty and bitmap_full
Date: Thu, 19 Nov 2015 10:01:17 +0100
Message-ID: <87bnaqtlb6.fsf@rasmusvillemoes.dk>
References: <1447915724-29709-1-git-send-email-hejianet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35916 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757178AbbKSJBV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2015 04:01:21 -0500
Received: by lbblt2 with SMTP id lt2so39679837lbb.3
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2015 01:01:19 -0800 (PST)
In-Reply-To: <1447915724-29709-1-git-send-email-hejianet@gmail.com> (Jia He's
	message of "Thu, 19 Nov 2015 14:48:41 +0800")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jia He <hejianet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Denys Vlasenko <dvlasenk@redhat.com>, Kyungmin Park <kyungmin.park@samsung.com>, Michal Nazarewicz <mina86@mina86.com>, Yury Norov <yury.norov@gmail.com>, Tejun Heo <tj@kernel.org>, Martin Kepplinger <martink@posteo.de>, George Spelvin <linux@horizon.com>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>

On Thu, Nov 19 2015, Jia He <hejianet@gmail.com> wrote:

> find_fisrt_{zero_}bit are too heavy for bitmap_{full,empty}. We don't 
> need to calculate and compare the position of bitmap. This set of patch
> instroduces lightweight api and replaces the heavy one.
>

Please check the history of the code you're modifying. git blame
include/linux/bitmap.h would immediately point you to 2afe27c718b
"lib/bitmap.c: bitmap_[empty,full]: remove code duplication". While it's
obviously true that find_first_bit does slightly more work than strictly
necessary to establish whether the bitmap is empty, it does the same
number of memory accesses, so I wouldn't consider it particularly
heavy-weight. Getting rid of .text as 2afe27c718b did is a good thing,
so you'd have to explain why we should reintroduce specialized functions
for this.

Your code is also buggy :-(

Rasmus
