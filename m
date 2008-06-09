From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 04/41] cpu ops: Core piece for generic atomic per cpu
 operations
Date: Mon, 9 Jun 2008 16:09:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0806091605490.9534@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com> <200805301708.51284.rusty@rustcorp.com.au>
 <Pine.LNX.4.64.0805301055270.14564@schroedinger.engr.sgi.com>
 <200806021200.41652.rusty@rustcorp.com.au> <4846DC6B.6030802@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.171.30]:46488 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760150AbYFIXJ0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 9 Jun 2008 19:09:26 -0400
In-Reply-To: <4846DC6B.6030802@sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Travis <travis@sgi.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>

On Wed, 4 Jun 2008, Mike Travis wrote:

> 0000000000000013 <test_local_inc>:
>   13:   55                      push   %rbp
>   14:   65 48 8b 05 00 00 00    mov    %gs:0(%rip),%rax        # 1c <test_local_inc+0x9>
>   1b:   00
>   1c:   48 89 e5                mov    %rsp,%rbp
>   1f:   48 ff 04 07             incq   (%rdi,%rax,1)
>   23:   c9                      leaveq
>   24:   c3                      retq

Note also that the address calculation occurs before the incq. That is why 
disabling preemption is required otherwise the processor may change 
between the determination of the per cpu area address and the increment.

The local_t operations could be modified to avoid the preemption issues 
with the zero based patches applied. Then there would still be the 
inflexbility of not being able to increment an arbitrary variable.

I think it is also bad to treat a per cpu variable like an atomic. Its not 
truly atomic nor are strictly atomic accesses used. It is fine to use 
regular operations on the per cpu variable provided one has either 
disabled preemption or interrupts. The per cpu atomic wrt interrupt ops 
are only useful when preemption and/or interrupts are off.
