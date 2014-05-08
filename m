Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:46530 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbaEHTUA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 May 2014 15:20:00 -0400
Date: Thu, 8 May 2014 21:19:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v10 12/19] unfair qspinlock: Variable frequency lock
 stealing mechanism
Message-ID: <20140508191944.GT2844@laptop.programming.kicks-ass.net>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
 <1399474907-22206-13-git-send-email-Waiman.Long@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1399474907-22206-13-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, Scott J Norton <scott.norton@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
Message-ID: <20140508191944.jfmr1lIAl5sfxkLmIualtGrw3RArjQ0-fGGUFX0A1f0@z>

On Wed, May 07, 2014 at 11:01:40AM -0400, Waiman Long wrote:
> +#define DEF_LOOP_CNT(c)		int c = 0
> +#define INC_LOOP_CNT(c)		(c)++
> +#define LOOP_CNT(c)		c
> +#define LSTEAL_MIN		(1 << 3)
> +#define LSTEAL_MAX		(1 << 10)
> +#define LSTEAL_MIN_MASK		(LSTEAL_MIN - 1)
> +#define LSTEAL_MAX_MASK		(LSTEAL_MAX - 1)

*groan*.. why do you have to write the most obfuscated code ever? We're
not ioccc.org.


