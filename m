From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Mon, 13 Jul 2020 23:47:14 +1000
Message-ID: <1594647408.wmrazhwjzb.astroid@bobo.none>
References: <20200710015646.2020871-1-npiggin@gmail.com>
        <20200710015646.2020871-5-npiggin@gmail.com>
        <CALCETrVqHDLo09HcaoeOoAVK8w+cNWkSNTLkDDU=evUhaXkyhQ@mail.gmail.com>
        <1594613902.1wzayj0p15.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbgGMNrX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 09:47:23 -0400
In-Reply-To: <1594613902.1wzayj0p15.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>

Excerpts from Nicholas Piggin's message of July 13, 2020 2:45 pm:
> Excerpts from Andy Lutomirski's message of July 11, 2020 3:04 am:
>> Also, as it stands, I can easily see in_irq() ceasing to promise to
>> serialize.  There are older kernels for which it does not promise to
>> serialize.  And I have plans to make it stop serializing in the
>> nearish future.
>=20
> You mean x86's return from interrupt? Sounds fun... you'll konw where to=20
> update the membarrier sync code, at least :)

Oh, I should actually say Mathieu recently clarified a return from
interrupt doesn't fundamentally need to serialize in order to support
membarrier sync core.

https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-July/214171.html

So you may not need to do anything more if you relaxed it.

Thanks,
Nick
