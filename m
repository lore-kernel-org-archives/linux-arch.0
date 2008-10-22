From: David Howells <dhowells@redhat.com>
Subject: Re: [patch] mutex: optimise generic mutex implementations
Date: Wed, 22 Oct 2008 17:24:28 +0100
Message-ID: <22459.1224692668@redhat.com>
References: <20081012054634.GA12535@wotan.suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:43512 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752553AbYJVQY7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Oct 2008 12:24:59 -0400
In-Reply-To: <20081012054634.GA12535@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: dhowells@redhat.com, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, benh@kernel.crashing.org

Nick Piggin <npiggin@suse.de> wrote:

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

This seems to work on FRV which uses the mutex-dec generic algorithm, though
you have to take that with a pinch of salt as I don't have SMP hardware for
it.

Acked-by: David Howells <dhowells@redhat.com>
