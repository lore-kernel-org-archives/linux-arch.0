From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/refcount: Implement fast refcount_t handling
Date: Mon, 24 Apr 2017 13:40:56 -0700
Message-ID: <CAGXu5jK5s0KBAfwHPhobiSCn6b0QA4Wb=w=eJG4KyukwbdHTzg@mail.gmail.com>
References: <20170421220939.GA65363@beast> <58FDF8C4.5120.17D092B7@pageexec.freemail.hu>
 <20170424133323.cf3xyd3mmwp6ixaz@hirez.programming.kicks-ass.net> <58FE1687.5511.1844D4FC@pageexec.freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:38723 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S977728AbdDXUk5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Apr 2017 16:40:57 -0400
Received: by mail-it0-f41.google.com with SMTP id f187so2033196ite.1
        for <linux-arch@vger.kernel.org>; Mon, 24 Apr 2017 13:40:57 -0700 (PDT)
In-Reply-To: <58FE1687.5511.1844D4FC@pageexec.freemail.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: PaX Team <pageexec@freemail.hu>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Eric Biggers <ebiggers3@gmail.com>, Christoph Hellwig <hch@infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jann Horn <jann@thejh.net>, "David S. Miller" <davem@davemloft.net>, linux-arch <linux-arch@vger.kernel.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>

On Mon, Apr 24, 2017 at 8:15 AM, PaX Team <pageexec@freemail.hu> wrote:
> On 24 Apr 2017 at 15:33, Peter Zijlstra wrote:
>> On Mon, Apr 24, 2017 at 03:08:20PM +0200, PaX Team wrote:
>> > On 24 Apr 2017 at 13:15, Peter Zijlstra wrote:
>> > that was exactly my point: all this applies to you as well. so let me ask
>> > the 3rd time: what is your "argument for correctness" for a 0 refcount
>> > value check? how does it prevent exploitation?
>>
>> I think I've explained that before; per reference count rules 0 means
>> freed (or about to be freed when we talk RCU).
>
> you only said the same thing, what 0 means. you (still) didn't explain how
> checking for it prevents exploitation.
>
>> The whole pattern:
>>
>>  if (dec_and_test(&obj->ref))
>>   kfree(obj);
>>
>> expresses this etc.. Other reference counts also do this. No references
>> means its getting freed.
>>
>> Can you agree with this?
>
> sure, so far so good.
>
>> If so; any attempt to increase the reference count while its (being)
>> freed() is a use-after-free.
>
> why would ever be there such an attempt? a freed object with intact memory
> content is as useful for an attacker as a live one, that is, not at all.

I think we're way off in the weeds here. The "cannot inc from 0" check
is about general sanity checks on refcounts. It should never happen,
and if it does, there's a bug. However, what the refcount hardening
protection is trying to do is protect again the exploitable condition:
overflow. Inc-from-0 isn't an exploitable condition since in theory
the memory suddenly becomes correctly managed again. We're just
discussing different things.

The point is to have very fast refcount_t that protects against
overflow so the mm, net, and block subsystems aren't worried about
making the atomic_t -> refcount_t changes there.

-Kees

-- 
Kees Cook
Pixel Security
