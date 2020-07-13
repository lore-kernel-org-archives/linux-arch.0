From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Mon, 13 Jul 2020 10:13:21 -0400 (EDT)
Message-ID: <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com>
References: <20200710015646.2020871-1-npiggin@gmail.com> <20200710015646.2020871-5-npiggin@gmail.com> <CALCETrVqHDLo09HcaoeOoAVK8w+cNWkSNTLkDDU=evUhaXkyhQ@mail.gmail.com> <1594613902.1wzayj0p15.astroid@bobo.none> <1594647408.wmrazhwjzb.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.26.124]:37366 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbgGMONW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 10:13:22 -0400
In-Reply-To: <1594647408.wmrazhwjzb.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>

----- On Jul 13, 2020, at 9:47 AM, Nicholas Piggin npiggin@gmail.com wrote:

> Excerpts from Nicholas Piggin's message of July 13, 2020 2:45 pm:
>> Excerpts from Andy Lutomirski's message of July 11, 2020 3:04 am:
>>> Also, as it stands, I can easily see in_irq() ceasing to promise to
>>> serialize.  There are older kernels for which it does not promise to
>>> serialize.  And I have plans to make it stop serializing in the
>>> nearish future.
>> 
>> You mean x86's return from interrupt? Sounds fun... you'll konw where to
>> update the membarrier sync code, at least :)
> 
> Oh, I should actually say Mathieu recently clarified a return from
> interrupt doesn't fundamentally need to serialize in order to support
> membarrier sync core.

Clarification to your statement:

Return from interrupt to kernel code does not need to be context serializing
as long as kernel serializes before returning to user-space.

However, return from interrupt to user-space needs to be context serializing.

Thanks,

Mathieu

> 
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-July/214171.html
> 
> So you may not need to do anything more if you relaxed it.
> 
> Thanks,
> Nick

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
