Return-Path: <SRS0=jIX+=AZ=kvack.org=owner-linux-mm@kernel.org>
Date: Tue, 14 Jul 2020 15:23:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 7/7] lazy tlb: shoot lazies, a non-refcounting lazy
 tlb option
Message-ID: <20200714132341.GY10769@hirez.programming.kicks-ass.net>
References: <1594708054.04iuyxuyb5.astroid@bobo.none>
 <6D3D1346-DB1E-43EB-812A-184918CCC16A@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6D3D1346-DB1E-43EB-812A-184918CCC16A@amacapital.net>
Sender: owner-linux-mm@kvack.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, X86 ML <x86@kernel.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200714132341.aYRhrSxmw566u5gqL9offV8e0bA6qfqWd8VQd8Z43IE@z>

On Tue, Jul 14, 2020 at 05:46:05AM -0700, Andy Lutomirski wrote:
> x86 has this exact problem. At least no more than 64*8 CPUs share the cache line :)

I've seen patches for a 'sparse' bitmap to solve related problems.

It's basically the same code, except it multiplies everything (size,
bit-nr) by a constant to reduce the number of active bits per line.

This sadly doesn't take topology into account, but reducing contention
is still good ofcourse.
