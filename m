From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Fri, 17 Jul 2020 09:42:43 -0400 (EDT)
Message-ID: <1314561373.18530.1594993363050.JavaMail.zimbra@efficios.com>
References: <1594868476.6k5kvx8684.astroid@bobo.none> <EFAD6E2F-EC08-4EB3-9ECC-2A963C023FC5@amacapital.net> <20200716085032.GO10769@hirez.programming.kicks-ass.net> <1594892300.mxnq3b9a77.astroid@bobo.none> <20200716110038.GA119549@hirez.programming.kicks-ass.net> <1594906688.ikv6r4gznx.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.26.124]:50558 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgGQNmo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 09:42:44 -0400
In-Reply-To: <1594906688.ikv6r4gznx.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>

----- On Jul 16, 2020, at 7:26 PM, Nicholas Piggin npiggin@gmail.com wrote:
[...]
> 
> membarrier does replace barrier instructions on remote CPUs, which do
> order accesses performed by the kernel on the user address space. So
> membarrier should too I guess.
> 
> Normal process context accesses like read(2) will do so because they
> don't get filtered out from IPIs, but kernel threads using the mm may
> not.

But it should not be an issue, because membarrier's ordering is only with respect
to submit and completion of io_uring requests, which are performed through
system calls from the context of user-space threads, which are called from the
right mm.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
