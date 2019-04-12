Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbfDLOQe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Apr 2019 10:16:34 -0400
Subject: Re: [PATCH v2 2/4] arm64: Define Documentation/arm64/elf_at_flags.txt
References: <cover.1552679409.git.andreyknvl@google.com>
 <20190318163533.26838-1-vincenzo.frascino@arm.com>
 <20190318163533.26838-3-vincenzo.frascino@arm.com>
 <859341c2-b352-e914-312a-d3de652495b6@arm.com>
 <20190403165031.GE34351@arrakis.emea.arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Message-ID: <d2292560-54cf-8dc3-da96-4ccdd72d090e@arm.com>
Date: Fri, 12 Apr 2019 15:16:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190403165031.GE34351@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Branislav Rankov <Branislav.Rankov@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Daniel Borkmann <daniel@iogearbox.net>, Dave Martin <Dave.Martin@arm.com>, "David S. Miller" <davem@davemloft.net>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, Evgeniy Stepanov <eugenis@google.com>, Graeme Barnes <Graeme.Barnes@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Kostya Serebryany <kcc@google.com>, Lee Smith <Lee.Smith@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Robin Murphy <robin.murphy@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <20190412141619.E2eFelgTBF0dAiMjkYJduF9sdWi5NnhVuU01Krnowy4@z>

On 03/04/2019 17:50, Catalin Marinas wrote:
> On Fri, Mar 22, 2019 at 03:52:49PM +0000, Kevin Brodsky wrote:
>> On 18/03/2019 16:35, Vincenzo Frascino wrote:
>>> +2. Features exposed via AT_FLAGS
>>> +--------------------------------
>>> +
>>> +bit[0]: ARM64_AT_FLAGS_SYSCALL_TBI
>>> +
>>> +    On arm64 the TCR_EL1.TBI0 bit has been always enabled on the arm64
>>> +    kernel, hence the userspace (EL0) is allowed to set a non-zero value
>>> +    in the top byte but the resulting pointers are not allowed at the
>>> +    user-kernel syscall ABI boundary.
>>> +    When bit[0] is set to 1 the kernel is advertising to the userspace
>>> +    that a relaxed ABI is supported hence this type of pointers are now
>>> +    allowed to be passed to the syscalls, when these pointers are in
>>> +    memory ranges privately owned by a process and obtained by the
>>> +    process in accordance with the definition of "valid tagged pointer"
>>> +    in paragraph 3.
>>> +    In these cases the tag is preserved as the pointer goes through the
>>> +    kernel. Only when the kernel needs to check if a pointer is coming
>>> +    from userspace an untag operation is required.
>> I would leave this last sentence out, because:
>> 1. It is an implementation detail that doesn't impact this user ABI.
>> 2. It is not entirely accurate: untagging the pointer may be needed for
>> various kinds of address lookup (like finding the corresponding VMA), at
>> which point the kernel usually already knows it is a userspace pointer.
> I fully agree, the above paragraph should not be part of the user ABI
> document.
>
>>> +3. ARM64_AT_FLAGS_SYSCALL_TBI
>>> +-----------------------------
>>> +
>>> +From the kernel syscall interface prospective, we define, for the purposes
>>> +of this document, a "valid tagged pointer" as a pointer that either it has
>>> +a zero value set in the top byte or it has a non-zero value, it is in memory
>>> +ranges privately owned by a userspace process and it is obtained in one of
>>> +the following ways:
>>> +  - mmap() done by the process itself, where either:
>>> +    * flags = MAP_PRIVATE | MAP_ANONYMOUS
>>> +    * flags = MAP_PRIVATE and the file descriptor refers to a regular
>>> +      file or "/dev/zero"
>>> +  - a mapping below sbrk(0) done by the process itself
>> I don't think that's very clear, this doesn't say how the mapping is
>> obtained. Maybe "a mapping obtained by the process using brk() or sbrk()"?
> I think what we mean here is anything in the "[heap]" section as per
> /proc/*/maps (in the kernel this would be start_brk to brk).
>
>>> +  - any memory mapped by the kernel in the process's address space during
>>> +    creation and following the restrictions presented above (i.e. data, bss,
>>> +    stack).
>> With the rules above, the code section is included as well. Replacing "i.e."
>> with "e.g." would avoid having to list every single section (which is
>> probably not a good idea anyway).
> We could mention [stack] explicitly as that's documented in the
> Documentation/filesystems/proc.txt and it's likely considered ABI
> already.
>
> The code section is MAP_PRIVATE, and can be done by the dynamic loader
> (user process), so it falls under the mmap() rules listed above. I guess
> we could simply drop "done by the process itself" here and allow
> MAP_PRIVATE|MAP_ANONYMOUS or MAP_PRIVATE of regular file. This would
> cover the [heap] and [stack] and we won't have to debate the brk() case
> at all.

That's probably the best option. I initially used this wording because I was worried 
that there could be cases where the kernel allocates "magic" memory for userspace 
that is MAP_PRIVATE|MAP_ANONYMOUS, but in fact it's probably not the case (presumably 
such mapping should always be done via install_special_mapping(), which is definitely 
not MAP_PRIVATE).

> We probably mention somewhere (or we should in the tagged pointers doc)
> that we don't support tagged PC.

I think that Documentation/arm64/tagged-pointers.txt already makes it reasonably 
clear (anyway, with the architecture not supporting it, you can't expect much from 
the kernel).

Kevin
