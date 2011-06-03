From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add another generic ext2 atomic bitops
Date: Fri, 3 Jun 2011 18:00:22 +0200
Message-ID: <201106031800.22298.arnd@arndb.de>
References: <1306938736-11119-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55564 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab1FCQA5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2011 12:00:57 -0400
In-Reply-To: <1306938736-11119-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org

On Wednesday 01 June 2011, Akinobu Mita wrote:
> The majority of architectures implement ext2 atomic bitops as
> test_and_{set,clear}_bit() without spinlock.
> 
> This adds this type of generic implementation in ext2-atomic.h and
> use it wherever possible.

The idea sounds really good, but I'm trying to keep the number of
ARCH_* macros low. How about instead providing a new
asm-generic/bitops/ext2-atomic-setbit.h or similar?

Each architecture can then include either the spinlock or the
atomic bitop based version.

	Arnd
