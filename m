From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 6/8] READ_ONCE: Drop pointer qualifiers when reading
 from scalar types
Date: Mon, 13 Jan 2020 11:31:56 -0800
Message-ID: <CAHk-=wirAWFOrfD4us1FepP0vWkZMpnqXusJyKHCqwBVsR43CA@mail.gmail.com>
References: <20200110165636.28035-1-will@kernel.org> <20200110165636.28035-7-will@kernel.org>
 <CAHk-=wia5ppBsfHLMx648utCjO01JAZiME0K0eSHmhWuRyL+6w@mail.gmail.com> <20200113145954.GB4458@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46041 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMTcQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jan 2020 14:32:16 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so7762523lfa.12
        for <linux-arch@vger.kernel.org>; Mon, 13 Jan 2020 11:32:15 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id s3sm6175896lfo.77.2020.01.13.11.32.13
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 11:32:13 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id o13so11450314ljg.4
        for <linux-arch@vger.kernel.org>; Mon, 13 Jan 2020 11:32:13 -0800 (PST)
In-Reply-To: <20200113145954.GB4458@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>

On Mon, Jan 13, 2020 at 7:00 AM Will Deacon <will@kernel.org> wrote:
>
> I can't disagree with that, but the only option we've come up with so far
> that solves this in the READ_ONCE() macro itself is the thing from PeterZ:
>
> // Insert big fat comment here
> #define unqual_typeof(x)    typeof(({_Atomic typeof(x) ___x __maybe_unused; ___x; }))

I'm with Luc on this - that not only looks gcc-specific, it looks
fragile too, in that it's not obvious that "_Atomic typeof(x)" really
is guaranteed to do what we want.

> So I suppose my question is: how ill does this code really make you feel?

I wish the code was more obvious.

One way to do that might be to do your approach, but just write it as
a series of macros that makes it a bit more understandable what it
does.

Maybe it's just because of a "pee in the snow" effect, but I think
this is easier to explain:

  #define __pick_scalar_type(x,type,otherwise)          \
        __builtin_choose_expr(__same_type(x,type), (type)0, otherwise)

  #define __pick_integer_type(x, type, otherwise)       \
        __pick_scalar_type(x, unsigned type,            \
          __pick_scalar_type(x, signed type, otherwise))

  #define __unqual_scalar_typeof(x) typeof(             \
        __pick_integer_type(x, char,                    \
          __pick_integer_type(x, short,                 \
            __pick_integer_type(x, int,                 \
              __pick_integer_type(x, long,              \
                __pick_integer_type(x, long long, x))))))

just because you there's less repeated noise, and the repetition there
is is simpler.

So still "Eww", but maybe not quite _as_ "Eww".

             Linus
