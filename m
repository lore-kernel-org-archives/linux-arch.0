From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
Date: Thu, 13 Dec 2018 09:46:48 +0000
Message-ID: <1071a68e-f671-b56e-e627-e83bb97da8bf@arm.com>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com>
 <CAK8P3a1njNBWiMExBevqbT+AuUHdU4T2sc1o1rRTn+Ji=y2SbA@mail.gmail.com>
 <64ff3b50-ce55-ff69-ac3a-61f221299895@arm.com>
 <CAK8P3a0LgFuv_s4xiC_rD0X7-GxHRWfzmdDcxJ7vvHrEETApRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK8P3a0LgFuv_s4xiC_rD0X7-GxHRWfzmdDcxJ7vvHrEETApRw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Hi Arnd,

On 11/12/2018 21:41, Arnd Bergmann wrote:
> On Tue, Dec 11, 2018 at 2:39 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>> On 29/11/2018 20:42, Arnd Bergmann wrote:
>>> On Thu, Nov 29, 2018 at 6:06 PM Vincenzo Frascino
>>> <vincenzo.frascino@arm.com> wrote:
>>>
>>>> +/*
>>>> + * The definitions below are required to overcome the limitations
>>>> + * of time_t on 32 bit architectures, which overflows in 2038.
>>>> + * The new code should use the replacements based on time64_t and
>>>> + * timespec64.
>>>> + *
>>>> + * The abstraction below will be updated once the migration to
>>>> + * time64_t is complete.
>>>> + */
>>>> +#ifdef CONFIG_GENERIC_VDSO_32
>>>> +#define __vdso_timespec                old_timespec32
>>>> +#define __vdso_timeval         old_timeval32
>>>> +#else
>>>> +#ifdef ENABLE_COMPAT_VDSO
>>>> +#define __vdso_timespec                old_timespec32
>>>> +#define __vdso_timeval         old_timeval32
>>>> +#else
>>>> +#define __vdso_timespec                __kernel_timespec
>>>> +#define __vdso_timeval         __kernel_old_timeval
>>>> +#endif /* CONFIG_COMPAT_VDSO */
>>>> +#endif /* CONFIG_GENERIC_VDSO_32 */
>>>>
>>>
>>> Have you considered doing this in the reverse way, by including
>>> the common parts from multiple implementations (32 and 64
>>> bit), instead of compiling the same source file multiple
>>> times with different macros set? I think that would make it
>>> easier to understand.
>>>
>>
>> The common code is never compiled as standalone. It includes arch specific code
>> (for the fallbacks) and it is included in the arch specific vdso library (for
>> both 32 and 64 bit where it makes sense). Hence it is built once or twice.
>>
>> If I understand correctly your question, seems inline with what I am doing.
> 
> The result is very similar, it's just a question of which file includes which
> other file. If I understand your current method right, you use Makefile
> logic to build multiple object files from a single source file, and setting
> ENABLE_COMPAT_VDSO on one of them, right?
> 

First of all, thank you for explaining this further.

My approach seems currently in line with what happens in fs/compat_binfmt_elf.c,
the only differences are:
- Instead of doing (pseudo-code):

#ifdef CONFIG_XYZ
#include "../../../../../xyz.c"
#endif

inside of the C file, I am using the Makefile logic (-include of xyz.c) to
include the C file upon checking the config option and to generate the correct
include path. The object (from: lib/vdso/gettimeofday.c) is never built as a
standalone multiple times.

- The chain of inclusion is <arch>/include/asm/vdso/gettimeofday.h -->
lib/vdso/gettimeofday.c --> vdso/vgettimeofday.c (this is the only object that
we are building) and this is to keep the Makefile as simple as possible. In fact
the other way around would have resulted in copying the objects around (to not
override them when compat is present) with the implication of more complicated
Makefiles.

> My preference would be to keep that Makefile simpler and have one
> source file per object file, but have each one define a set of macros
> before including the common source file, similarly to how we deal
> with fs/compat_binfmt_elf.c. If that turns out to be worse than what
> you have here, I'm not overly attached to that solution since including
> C files is still ugly, but I think it's worth trying if that lets you end
> up with more easily understandable source code.
> 
>        Arnd
> 

-- 
Regards,
Vincenzo
