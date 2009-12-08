From: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: [patch 09/23] locking: Implement new raw_spinlock
Date: Tue, 8 Dec 2009 21:33:13 +0800
Message-ID: <2674af740912080533o12878af5ve2fb88e5e1c0a286@mail.gmail.com>
References: <20091206110944.492100233@linutronix.de>
	 <20091206111957.651783909@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:43011 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587AbZLHNdG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Dec 2009 08:33:06 -0500
In-Reply-To: <20091206111957.651783909@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Mon, Dec 7, 2009 at 2:02 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Now that the raw_spin name space is freed up, we can implement
> raw_spinlock and the related functions which are used to annotate the
> locks which are not converted to sleeping spinlocks in preempt-rt.
>
> A side effect is that only such locks can be used with the low level
> lock fsunctions which circumvent lockdep.

s/fsunctions/functions
