From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] locking/refcounts, x86/asm: Use unique .text section for
 refcount exceptions
Date: Sat, 2 Sep 2017 12:51:57 -0700
Message-ID: <CAGXu5jLcqge53KiK4x6eXPSqYqtmBJU9FyAQm3=ysaVA3A-hOA@mail.gmail.com>
References: <20170901202203.GA48925@beast> <20170902102945.xb3rvd6ursb2s5a4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170902102945.xb3rvd6ursb2s5a4@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, "x86@kernel.org" <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>, "Reshetova, Elena" <elena.reshetova@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Sat, Sep 2, 2017 at 3:29 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Kees Cook <keescook@chromium.org> wrote:
>
>> Using .text.unlikely for refcount exceptions isn't safe because gcc may
>> move entire functions into .text.unlikely (e.g. in6_dev_get()), which
>> would cause any uses of a protected refcount_t function to stay inline
>> with the function, triggering the protection unconditionally:
>>
>>         .section        .text.unlikely,"ax",@progbits
>>         .type   in6_dev_get, @function
>> in6_dev_getx:
>> .LFB4673:
>>         .loc 2 4128 0
>>         .cfi_startproc
>> ...
>>         lock; incl 480(%rbx)
>>         js 111f
>>         .pushsection .text.unlikely
>> 111:    lea 480(%rbx), %rcx
>> 112:    .byte 0x0f, 0xff
>> .popsection
>> 113:
>>
>> This creates a unique .text section and adds an additional test to the
>> exception handler to WARN in the case of having none of OF, SF, nor ZF
>> set so we can see things like this more easily in the future.
>>
>> Reported-by: Mike Galbraith <efault@gmx.de>
>> Fixes: 7a46ec0e2f48 ("locking/refcounts, x86/asm: Implement fast refcount overflow protection")
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  arch/x86/Kconfig                  | 2 +-
>>  arch/x86/include/asm/refcount.h   | 2 +-
>>  arch/x86/mm/extable.c             | 7 ++++++-
>>  include/asm-generic/vmlinux.lds.h | 1 +
>>  4 files changed, 9 insertions(+), 3 deletions(-)
>
> Could you please split this into two patches: one that fixes the .unlikely bug,
> the other that re-enables the optimized version?
>
> Should there be any other problem with refcounts this would make any bisection
> result more clear-cut.

Certainly!

-Kees

-- 
Kees Cook
Pixel Security
