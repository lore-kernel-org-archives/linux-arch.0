From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v6 03/19] kernel: Unify update_vsyscall implementation
Date: Mon, 10 Jun 2019 11:19:15 +0100
Message-ID: <90329b94-6cac-63dd-acad-a04c0d283a83@arm.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-4-vincenzo.frascino@arm.com>
 <20190610093447.GC11076@merlot.physics.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610093447.GC11076@merlot.physics.ox.ac.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Huw Davies <huw@codeweavers.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
List-Id: linux-arch.vger.kernel.org

On 10/06/2019 10:34, Huw Davies wrote:
> On Thu, May 30, 2019 at 03:15:15PM +0100, Vincenzo Frascino wrote:
>> With the definition of the unified vDSO library the implementations of
>> update_vsyscall and update_vsyscall_tz became quite similar across
>> architectures.
>>
>> Define a unified implementation of this two functions in kernel/vdso and
> 
> ... of these two functions ...

Thanks for this, I will fix in v7.

> 
>> provide the bindings that can be implemented by every architecture that
>> takes advantage of the unified vDSO library.

-- 
Regards,
Vincenzo
