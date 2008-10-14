Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51641 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753076AbYJNIhT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Oct 2008 04:37:19 -0400
Subject: Re: [patch] mutex: optimise generic mutex implementations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
In-Reply-To: <20081012054634.GA12535@wotan.suse.de>
References: <20081012054634.GA12535@wotan.suse.de>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 19:35:19 +1100
Message-ID: <1223973319.8157.333.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org
Message-ID: <20081014083519.BYgqxsQEacA8d5yHkYqkozJt47bIMIEvbCSHmrt5Tl8@z>

On Sun, 2008-10-12 at 07:46 +0200, Nick Piggin wrote:
> Speed up generic mutex implementations.
> 
> - atomic operations which both modify the variable and return something imply
>   full smp memory barriers before and after the memory operations involved
>   (failing atomic_cmpxchg, atomic_add_unless, etc don't imply a barrier because
>   they don't modify the target). See Documentation/atomic_ops.txt.
>   So remove extra barriers and branches.
>   
> - All architectures support atomic_cmpxchg. This has no relation to
>   __HAVE_ARCH_CMPXCHG. We can just take the atomic_cmpxchg path unconditionally
> 
> This reduces a simple single threaded fastpath lock+unlock test from 590 cycles
> to 203 cycles on a ppc970 system.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>

Looks ok.

Cheers,
Ben.


