From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v3 18/26] arm64: Introduce asm/vdso/processor.h
Date: Mon, 16 Mar 2020 16:05:17 +0000
Message-ID: <53eb7809-9da8-33e5-540f-7546de51b53d@arm.com>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-19-vincenzo.frascino@arm.com>
 <20200315182950.GB32205@mbp> <c2c0157a-107a-debf-100f-0d97781add7c@arm.com>
 <20200316103437.GD3005@mbp> <77a2e91a-58f4-3ba3-9eef-42d6a8faf859@arm.com>
 <20200316112205.GE3005@mbp> <9a0a9285-8a45-4f65-3a83-813cabd0f0d3@arm.com>
 <20200316144346.GF3005@mbp> <427064ee-45df-233c-0281-69e3d62ba784@arm.com>
 <20200316154930.GG3005@mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-owner@vger.kernel.org>
In-Reply-To: <20200316154930.GG3005@mbp>
Content-Language: en-US
Sender: linux-mips-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>Mark
List-Id: linux-arch.vger.kernel.org

On 3/16/20 3:49 PM, Catalin Marinas wrote:
> On Mon, Mar 16, 2020 at 03:33:30PM +0000, Vincenzo Frascino wrote:
>> On 3/16/20 2:43 PM, Catalin Marinas wrote[...]
[...]
> 
>> To make it more explicit we could make COMPAT_VDSO on arm64 depend on
>> ARM64_4K_PAGES. What do you think?
> 
> No, I don't see why we should add this limitation.
> 

Fine by me.

>>>> Please find below the list of errors for clock_gettime (similar for the other):
>>>>
>>>> passing UINTPTR_MAX to clock_gettime (VDSO): terminated by unexpected signal 7
>>>> clock-gettime-monotonic/abi: 1 failures/inconsistencies encountered
>>>
>>> Ah, so it uses UINTPTR_MAX in the test. Fair enough but I don't think
>>> the arm64 check is entirely useful. On arm32, the check was meant to
>>> return -EFAULT for addresses beyond TASK_SIZE that may enter into the
>>> kernel or module space. On arm64 compat, the kernel space is well above
>>> the reach of the 32-bit code.
>>>
>>> If you want to preserve some compatibility for this specific test, what
>>> about checking for wrapping around 0, I think it would make more sense.
>>> Something like:
>>>
>>> 	if ((u32)ts > UINTPTR_MAX - sizeof(*ts) + 1)
>>
>> Ok, sounds good to me. But it is something that this patch series inherited,
>> hence I would prefer to send a separate patch that introduces what you are
>> proposing and removes TASK_SIZE_32 from the headers. How does it sound?
> 
> I'd rather avoid moving TASK_SIZE_32 unnecessarily. Just add a
> preparatory patch to your series for arm64 compat vdso and follow with
> the rest without moving TASK_SIZE_32 around.
> 

Ok, sounds good. I will test it and repost.

-- 
Regards,
Vincenzo
