From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Mon, 26 Jun 2017 13:07:07 -0700 (PDT)
Message-ID: <mhng-d36dc177-05be-4785-a261-cc59e03d60b5@palmer-si-x1c4>
References: <20170607125850.zwh3w5s5ce54jcrz@hirez.programming.kicks-ass.net>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35596 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbdFZUHJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2017 16:07:09 -0400
Received: by mail-pg0-f67.google.com with SMTP id f127so1442003pgc.2
        for <linux-arch@vger.kernel.org>; Mon, 26 Jun 2017 13:07:09 -0700 (PDT)
In-Reply-To: <20170607125850.zwh3w5s5ce54jcrz@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, will.deacon@arm.com

On Wed, 07 Jun 2017 05:58:50 PDT (-0700), peterz@infradead.org wrote:
> On Wed, Jun 07, 2017 at 02:36:27PM +0200, Peter Zijlstra wrote:
>> Which (pending the sub confusion) will generate the entire set of:
>>
>>  atomic_add, atomic_add_return{_relaxed,_acquire,_release,} atomic_fetch_add{_relaxed,_acquire,_release,}
>>  atomic_sub, atomic_sub_return{_relaxed,_acquire,_release,} atomic_fetch_sub{_relaxed,_acquire,_release,}
>>
>>  atomic_and, atomic_fetch_and{_relaxed,_acquire,_release,}
>>  atomic_or,  atomic_fetch_or{_relaxed,_acquire,_release,}
>>  atomic_xor, atomic_fetch_xor{_relaxed,_acquire,_release,}
>>
>
> Another approach would be to override __atomic_op_{acquire,release} and
> use things like:
>
> 	"FENCE r,rw" -- (load) ACQUIRE
> 	"FENCE rw,w" -- (store) RELEASE
>
> And then you only need to provide _relaxed atomics.
>
> Also, and I didn't check for that, you need to provide:
>
> smp_load_acquire(), smp_store_release(), atomic_read_acquire(),
> atomic_store_release().

OK, thanks for looking so deeply into this.  Sorry it was such a mess, I
thought I included a note somewhere that this all needed to be redone -- I just
wanted to get a v2 out first as that split all the drivers out.  I've went
ahead and completely rewrote atomic.h using your suggestions in a slightly
modified way.  It includes

 * _relaxed, _acquire, and _release versions of everything via a bunch of macros.
 * What I believe to be correct aqrl bits on every op.
 * 64-bit and 32-bit atomics (as opposed to just copying everything)

I didn't implement try_cmpxchg yet.  I'm going to go ahead and sort through our
memory barriers, look at the few remaining CR comments from our v2, and then
submit a v3 patch set.

I'm only replying to this message, but I believe I'll have taken into account
all your comments for the v3.

Thanks, again, for your time!
