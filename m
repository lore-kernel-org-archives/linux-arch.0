From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 02/23] locking: Split rwlock from spinlock headers
Date: Mon, 7 Dec 2009 18:28:15 +0100
Message-ID: <200912071828.15280.arnd@arndb.de>
References: <20091206110944.492100233@linutronix.de> <20091206111957.370028725@linutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57105 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935436AbZLGR2b (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Dec 2009 12:28:31 -0500
In-Reply-To: <20091206111957.370028725@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Sunday 06 December 2009, Thomas Gleixner wrote:
> +
> +#ifndef __LINUX_SPINLOCK_H
> +# error "please don't include this file directly"
> +#endif
> +

Hmm, why not? I think it would be nice to have rwlock.h self-contained
to the degree that users of rwlock_t but not spinlock_t only need to
include the rwlock header and vice versa.

Obviously, we'd have to clean up all the ~200 users of rwlock_t before
we're able to remove rwlock.h from spinlock.h, but the other direction
could be done easily.

	Arnd <><
