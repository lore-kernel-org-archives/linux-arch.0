From: yalin wang <yalin.wang2010@gmail.com>
Subject: Re: [PATCH v2 2/3] lib: Introduce 2 bit ops api: all_is_bit_{one,zero}
Date: Thu, 19 Nov 2015 16:49:51 +0800
Message-ID: <265F6375-198E-4D74-8915-81E3995B7D4D@gmail.com>
References: <1447915724-29709-1-git-send-email-hejianet@gmail.com> <1447915724-29709-3-git-send-email-hejianet@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33275 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754723AbbKSIuA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2015 03:50:00 -0500
In-Reply-To: <1447915724-29709-3-git-send-email-hejianet@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jia He <hejianet@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Denys Vlasenko <dvlasenk@redhat.com>, Kyungmin Park <kyungmin.park@samsung.com>, Michal Nazarewicz <mina86@mina86.com>, Yury Norov <yury.norov@gmail.com>, Tejun Heo <tj@kernel.org>, Martin Kepplinger <martink@posteo.de>, George Spelvin <linux@horizon.com>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>


> On Nov 19, 2015, at 14:48, Jia He <hejianet@gmail.com> wrote:
> 
> 
why not use memcmp() to compare with  0x0000000 or 0xffffffff  ?
memcmp() have better performance on some platforms .

Thanks
