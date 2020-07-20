From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Mon, 20 Jul 2020 13:03:03 +1000
Message-ID: <1595213677.kxru89dqy2.astroid@bobo.none>
References: <1594868476.6k5kvx8684.astroid@bobo.none>
        <EFAD6E2F-EC08-4EB3-9ECC-2A963C023FC5@amacapital.net>
        <20200716085032.GO10769@hirez.programming.kicks-ass.net>
        <1594892300.mxnq3b9a77.astroid@bobo.none>
        <20200716110038.GA119549@hirez.programming.kicks-ass.net>
        <1594906688.ikv6r4gznx.astroid@bobo.none>
        <1314561373.18530.1594993363050.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgGTDDJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Jul 2020 23:03:09 -0400
In-Reply-To: <1314561373.18530.1594993363050.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>, Jens Axboe <axboe@kernel.dk>

Excerpts from Mathieu Desnoyers's message of July 17, 2020 11:42 pm:
> ----- On Jul 16, 2020, at 7:26 PM, Nicholas Piggin npiggin@gmail.com wrot=
e:
> [...]
>>=20
>> membarrier does replace barrier instructions on remote CPUs, which do
>> order accesses performed by the kernel on the user address space. So
>> membarrier should too I guess.
>>=20
>> Normal process context accesses like read(2) will do so because they
>> don't get filtered out from IPIs, but kernel threads using the mm may
>> not.
>=20
> But it should not be an issue, because membarrier's ordering is only with=
 respect
> to submit and completion of io_uring requests, which are performed throug=
h
> system calls from the context of user-space threads, which are called fro=
m the
> right mm.

Is that true? Can io completions be written into an address space via a
kernel thread? I don't know the io_uring code well but it looks like=20
that's asynchonously using the user mm context.

How about other memory accesses via kthread_use_mm? Presumably there is=20
still ordering requirement there for membarrier, so I really think
it's a fragile interface with no real way for the user to know how=20
kernel threads may use its mm for any particular reason, so membarrier
should synchronize all possible kernel users as well.

Thanks,
Nick
