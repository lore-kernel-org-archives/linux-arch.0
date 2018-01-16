Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:43888 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeAPS2l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jan 2018 13:28:41 -0500
Date: Tue, 16 Jan 2018 19:28:07 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH for 4.16 07/10] x86: Introduce sync_core_before_usermode
 (v2)
In-Reply-To: <20180115191104.12437-8-mathieu.desnoyers@efficios.com>
Message-ID: <alpine.DEB.2.20.1801161927400.2366@nanos>
References: <20180115191104.12437-1-mathieu.desnoyers@efficios.com> <20180115191104.12437-8-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, Maged Michael <maged.michael@gmail.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, "H . Peter Anvin" <hpa@zytor.com>, Andrea Parri <parri.andrea@gmail.com>, Russell King <linux@armlinux.org.uk>, Greg Hackmann <ghackmann@google.com>, Will Deacon <will.deacon@arm.com>, David Sehr <sehr@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180116182807.U8Qy0Yvkxl9ZZI-QOjYXa7BAMCUy3TnigYdvVjg4hRY@z>

On Mon, 15 Jan 2018, Mathieu Desnoyers wrote:

> Introduce an architecture function that ensures the current CPU
> issues a core serializing instruction before returning to usermode.
> 
> This is needed for the membarrier "sync_core" command.
> 
> Architectures defining the sync_core_before_usermode() static inline
> need to select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
