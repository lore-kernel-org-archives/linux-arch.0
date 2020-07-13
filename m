From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Tue, 14 Jul 2020 02:37:52 +1000
Message-ID: <1594657848.8og86nopq6.astroid@bobo.none>
References: <20200710015646.2020871-1-npiggin@gmail.com>
        <20200710015646.2020871-5-npiggin@gmail.com>
        <CALCETrVqHDLo09HcaoeOoAVK8w+cNWkSNTLkDDU=evUhaXkyhQ@mail.gmail.com>
        <1594613902.1wzayj0p15.astroid@bobo.none>
        <1594647408.wmrazhwjzb.astroid@bobo.none>
        <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com>
        <CALCETrUHsYp0oGAiy3N-yAauPyx2nKqp1AiETgSJWc77GwO-Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730409AbgGMQh7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 12:37:59 -0400
In-Reply-To: <CALCETrUHsYp0oGAiy3N-yAauPyx2nKqp1AiETgSJWc77GwO-Sg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>

Excerpts from Andy Lutomirski's message of July 14, 2020 1:48 am:
> On Mon, Jul 13, 2020 at 7:13 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> ----- On Jul 13, 2020, at 9:47 AM, Nicholas Piggin npiggin@gmail.com wro=
te:
>>
>> > Excerpts from Nicholas Piggin's message of July 13, 2020 2:45 pm:
>> >> Excerpts from Andy Lutomirski's message of July 11, 2020 3:04 am:
>> >>> Also, as it stands, I can easily see in_irq() ceasing to promise to
>> >>> serialize.  There are older kernels for which it does not promise to
>> >>> serialize.  And I have plans to make it stop serializing in the
>> >>> nearish future.
>> >>
>> >> You mean x86's return from interrupt? Sounds fun... you'll konw where=
 to
>> >> update the membarrier sync code, at least :)
>> >
>> > Oh, I should actually say Mathieu recently clarified a return from
>> > interrupt doesn't fundamentally need to serialize in order to support
>> > membarrier sync core.
>>
>> Clarification to your statement:
>>
>> Return from interrupt to kernel code does not need to be context seriali=
zing
>> as long as kernel serializes before returning to user-space.
>>
>> However, return from interrupt to user-space needs to be context seriali=
zing.
>>
>=20
> Indeed, and I figured this out on the first read through because I'm
> quite familiar with the x86 entry code.  But Nick somehow missed this,
> and Nick is the one who wrote the patch.
>=20
> Nick, I think this helps prove my point.  The code you're submitting
> may well be correct, but it's unmaintainable.

It's not. The patch I wrote for x86 is a no-op, it just moves existing
x86 hook and code that's already there to a different name.

Actually it's not quite a no-op, it't changes it to use hooks that are
actually called in the right places. Because previously it was
unmaintainable from point of view of generic mm -- it was not clear at
all that the old one should have been called in other places where the
mm goes non-lazy. Now with the exit_lazy_tlb hook, it can quite easily
be spotted where it is missing.

And x86 keeps their membarrier code in x86, and uses nice well defined
lazy tlb mm hooks.

> At the very least, this
> needs a comment explaining, from the perspective of x86, *exactly*
> what exit_lazy_tlb() is promising, why it's promising it, how it
> achieves that promise, and what code cares about it.  Or we could do
> something with TIF flags and make this all less magical, although that
> will probably end up very slightly slower.

It's all documented there in existing comments plus the asm-generic
exit_lazy_tlb specification added AFAIKS.

Is the membarrier comment in finish_task_switch plus these ones not
enough?

Thanks,
Nick
