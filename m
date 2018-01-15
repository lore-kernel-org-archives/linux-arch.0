From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 33/38] arm64: Implement thread_struct whitelist for
 hardened usercopy
Date: Mon, 15 Jan 2018 12:06:17 -0800
Message-ID: <CAGXu5jLHb3BQ9U7g6suoVZwVeETiXiCRbxsprpLNiFxcjcWk1A@mail.gmail.com>
References: <1515636190-24061-1-git-send-email-keescook@chromium.org>
 <1515636190-24061-34-git-send-email-keescook@chromium.org> <20180115122458.GI12608@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180115122458.GI12608@e103592.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave P Martin <Dave.Martin@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, James Morse <James.Morse@arm.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, zijun_hu <zijun_hu@htc.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Windsor <dave@nullcore.net>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@infradead.org>, Christoph Lameter <cl@linux.com>, "David S. Miller" <davem@davemloft.net>, Laura Abbott <labbott>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 15, 2018 at 4:24 AM, Dave P Martin <Dave.Martin@arm.com> wrote:
> On Thu, Jan 11, 2018 at 02:03:05AM +0000, Kees Cook wrote:
>> This whitelists the FPU register state portion of the thread_struct for
>> copying to userspace, instead of the default entire structure.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>> Cc: Dave Martin <Dave.Martin@arm.com>
>> Cc: zijun_hu <zijun_hu@htc.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  arch/arm64/Kconfig                 | 1 +
>>  arch/arm64/include/asm/processor.h | 8 ++++++++
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index a93339f5178f..c84477e6a884 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -90,6 +90,7 @@ config ARM64
>>       select HAVE_ARCH_MMAP_RND_BITS
>>       select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>>       select HAVE_ARCH_SECCOMP_FILTER
>> +     select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>>       select HAVE_ARCH_TRACEHOOK
>>       select HAVE_ARCH_TRANSPARENT_HUGEPAGE
>>       select HAVE_ARCH_VMAP_STACK
>> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
>> index 023cacb946c3..e58a5864ec89 100644
>> --- a/arch/arm64/include/asm/processor.h
>> +++ b/arch/arm64/include/asm/processor.h
>> @@ -113,6 +113,14 @@ struct thread_struct {
>>       struct debug_info       debug;          /* debugging */
>>  };
>>
>> +/* Whitelist the fpsimd_state for copying to userspace. */
>> +static inline void arch_thread_struct_whitelist(unsigned long *offset,
>> +                                             unsigned long *size)
>> +{
>> +     *offset = offsetof(struct thread_struct, fpsimd_state);
>> +     *size = sizeof(struct fpsimd_state);
>
> This should be fpsimd_state.user_fpsimd (fpsimd_state.cpu is important
> for correctly context switching and not supposed to be user-accessible.
> A user copy that encompasses that is definitely a bug).

So, I actually spent some more time looking at this due to the
comments from rmk on arm32, and I don't think any whitelist is needed
here at all. (i.e. it can be *offset = *size = 0) This is because all
the usercopying I could find uses static sizes or bounce buffers, both
of which bypass the dynamic-size hardened usercopy checks.

I've been running some arm64 builds now with this change, and I
haven't tripped over any problems yet...

-Kees

-- 
Kees Cook
Pixel Security
