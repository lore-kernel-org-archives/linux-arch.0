From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v3 18/26] arm64: Introduce asm/vdso/processor.h
Date: Mon, 16 Mar 2020 10:55:00 +0000
Message-ID: <77a2e91a-58f4-3ba3-9eef-42d6a8faf859@arm.com>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-19-vincenzo.frascino@arm.com>
 <20200315182950.GB32205@mbp> <c2c0157a-107a-debf-100f-0d97781add7c@arm.com>
 <20200316103437.GD3005@mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-owner@vger.kernel.org>
In-Reply-To: <20200316103437.GD3005@mbp>
Content-Language: en-US
Sender: linux-mips-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>Mark
List-Id: linux-arch.vger.kernel.org

Hi Catalin,

On 3/16/20 10:34 AM, Catalin Marinas wrote:
[...]


>>
>> I tried to fine grain the headers as much as I could in order to avoid
>> unneeded/unwanted inclusions:
>>  * TASK_SIZE_32 is used to verify ABI consistency on vdso32 (please refer to
>>    arch/arm64/kernel/vdso32/vgettimeofday.c).
> 
> I see. But the test is probably useless. With 4K pages, TASK_SIZE_32 is
> 1UL << 32, so you can't have a u32 greater than this. So I'd argue that
> the ABI compatibility here doesn't matter.
> 
> With 16K or 64K pages, TASK_SIZE_32 is slightly smaller but arm32 never
> supported it.
> 
> What's the side-effect of dropping this check altogether?
> 

The main side-effect is that arm32 and arm64 compat have a different behavior,
that it is what we want to avoid.

The vdsotest [1] I am using, verifies all the side conditions with respect to
the ABI, which we are now compatible with. Removing those checks would break
this condition.

[1] https://github.com/nlynch-mentor/vdsotest

-- 
Regards,
Vincenzo
