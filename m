From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 1/3] kernel,sched,time: Clean up gcc work-arounds
Date: Tue, 24 Apr 2012 12:39:24 -0700
Message-ID: <CA+55aFyPG5pUOTb9-cNGFsBc-BLfWqLEbgnWbz528-Gs6miSUg@mail.gmail.com>
References: <20120424161039.293018424@chello.nl> <20120424162224.454623618@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:44883 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757297Ab2DXTjq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Apr 2012 15:39:46 -0400
In-Reply-To: <20120424162224.454623618@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Apr 24, 2012 at 9:10 AM, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> +#define __gcc_dont_optimize_loop(var) asm("" "+rm" (var))

This seems to be missing a colon.

               Linus
