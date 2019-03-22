Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfCVPw7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Mar 2019 11:52:59 -0400
Subject: Re: [PATCH v2 2/4] arm64: Define Documentation/arm64/elf_at_flags.txt
References: <cover.1552679409.git.andreyknvl@google.com>
 <20190318163533.26838-1-vincenzo.frascino@arm.com>
 <20190318163533.26838-3-vincenzo.frascino@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Message-ID: <859341c2-b352-e914-312a-d3de652495b6@arm.com>
Date: Fri, 22 Mar 2019 15:52:49 +0000
MIME-Version: 1.0
In-Reply-To: <20190318163533.26838-3-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Branislav Rankov <Branislav.Rankov@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Daniel Borkmann <daniel@iogearbox.net>, Dave Martin <Dave.Martin@arm.com>, "David S. Miller" <davem@davemloft.net>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, Evgeniy Stepanov <eugenis@google.com>, Graeme Barnes <Graeme.Barnes@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Kostya Serebryany <kcc@google.com>, Lee Smith <Lee.Smith@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Robin Murphy <robin.murphy@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <20190322155249.bcA62btyujcQPJL_TDZ_hKQODrljL9eG-wrE-7jk1uQ@z>

On 18/03/2019 16:35, Vincenzo Frascino wrote:
> On arm64 the TCR_EL1.TBI0 bit has been always enabled hence
> the userspace (EL0) is allowed to set a non-zero value in the
> top byte but the resulting pointers are not allowed at the
> user-kernel syscall ABI boundary.
>
> With the relaxed ABI proposed through this document, it is now possible
> to pass tagged pointers to the syscalls, when these pointers are in
> memory ranges obtained by an anonymous (MAP_ANONYMOUS) mmap() or brk().
>
> This change in the ABI requires a mechanism to inform the userspace
> that such an option is available.
>
> Specify and document the way in which AT_FLAGS can be used to advertise
> this feature to the userspace.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> CC: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> Squash with "arm64: Define Documentation/arm64/elf_at_flags.txt"
> ---
>   Documentation/arm64/elf_at_flags.txt | 133 +++++++++++++++++++++++++++
>   1 file changed, 133 insertions(+)
>   create mode 100644 Documentation/arm64/elf_at_flags.txt
>
> diff --git a/Documentation/arm64/elf_at_flags.txt b/Documentation/arm64/elf_at_flags.txt
> new file mode 100644
> index 000000000000..9b3494207c14
> --- /dev/null
> +++ b/Documentation/arm64/elf_at_flags.txt
> @@ -0,0 +1,133 @@
> +ARM64 ELF AT_FLAGS
> +==================
> +
> +This document describes the usage and semantics of AT_FLAGS on arm64.
> +
> +1. Introduction
> +---------------
> +
> +AT_FLAGS is part of the Auxiliary Vector, contains the flags and it
> +is set to zero by the kernel on arm64 unless one or more of the
> +features detailed in paragraph 2 are present.
> +
> +The auxiliary vector can be accessed by the userspace using the
> +getauxval() API provided by the C library.
> +getauxval() returns an unsigned long and when a flag is present in
> +the AT_FLAGS, the corresponding bit in the returned value is set to 1.
> +
> +The AT_FLAGS with a "defined semantics" on arm64 are exposed to the
> +userspace via user API (uapi/asm/atflags.h).
> +The AT_FLAGS bits with "undefined semantics" are set to zero by default.
> +This means that the AT_FLAGS bits to which this document does not assign
> +an explicit meaning are to be intended reserved for future use.
> +The kernel will populate all such bits with zero until meanings are
> +assigned to them. If and when meanings are assigned, it is guaranteed
> +that they will not impact the functional operation of existing userspace
> +software. Userspace software should ignore any AT_FLAGS bit whose meaning
> +is not defined when the software is written.
> +
> +The userspace software can test for features by acquiring the AT_FLAGS
> +entry of the auxiliary vector, and testing whether a relevant flag
> +is set.
> +
> +Example of a userspace test function:
> +
> +bool feature_x_is_present(void)
> +{
> +	unsigned long at_flags = getauxval(AT_FLAGS);
> +	if (at_flags & FEATURE_X)
> +		return true;
> +
> +	return false;
> +}
> +
> +Where the software relies on a feature advertised by AT_FLAGS, it
> +must check that the feature is present before attempting to
> +use it.
> +
> +2. Features exposed via AT_FLAGS
> +--------------------------------
> +
> +bit[0]: ARM64_AT_FLAGS_SYSCALL_TBI
> +
> +    On arm64 the TCR_EL1.TBI0 bit has been always enabled on the arm64
> +    kernel, hence the userspace (EL0) is allowed to set a non-zero value
> +    in the top byte but the resulting pointers are not allowed at the
> +    user-kernel syscall ABI boundary.
> +    When bit[0] is set to 1 the kernel is advertising to the userspace
> +    that a relaxed ABI is supported hence this type of pointers are now
> +    allowed to be passed to the syscalls, when these pointers are in
> +    memory ranges privately owned by a process and obtained by the
> +    process in accordance with the definition of "valid tagged pointer"
> +    in paragraph 3.
> +    In these cases the tag is preserved as the pointer goes through the
> +    kernel. Only when the kernel needs to check if a pointer is coming
> +    from userspace an untag operation is required.

I would leave this last sentence out, because:
1. It is an implementation detail that doesn't impact this user ABI.
2. It is not entirely accurate: untagging the pointer may be needed for various kinds 
of address lookup (like finding the corresponding VMA), at which point the kernel 
usually already knows it is a userspace pointer.

> +
> +3. ARM64_AT_FLAGS_SYSCALL_TBI
> +-----------------------------
> +
> +From the kernel syscall interface prospective, we define, for the purposes
> +of this document, a "valid tagged pointer" as a pointer that either it has
> +a zero value set in the top byte or it has a non-zero value, it is in memory
> +ranges privately owned by a userspace process and it is obtained in one of
> +the following ways:
> +  - mmap() done by the process itself, where either:
> +    * flags = MAP_PRIVATE | MAP_ANONYMOUS
> +    * flags = MAP_PRIVATE and the file descriptor refers to a regular
> +      file or "/dev/zero"
> +  - a mapping below sbrk(0) done by the process itself

I don't think that's very clear, this doesn't say how the mapping is obtained. Maybe 
"a mapping obtained by the process using brk() or sbrk()"?

> +  - any memory mapped by the kernel in the process's address space during
> +    creation and following the restrictions presented above (i.e. data, bss,
> +    stack).

With the rules above, the code section is included as well. Replacing "i.e." with 
"e.g." would avoid having to list every single section (which is probably not a good 
idea anyway).

Kevin

> +
> +When the ARM64_AT_FLAGS_SYSCALL_TBI flag is set by the kernel, the following
> +behaviours are guaranteed by the ABI:
> +
> +  - Every current or newly introduced syscall can accept any valid tagged
> +    pointers.
> +
> +  - If a non valid tagged pointer is passed to a syscall then the behaviour
> +    is undefined.
> +
> +  - Every valid tagged pointer is expected to work as an untagged one.
> +
> +  - The kernel preserves any valid tagged pointers and returns them to the
> +    userspace unchanged in all the cases except the ones documented in the
> +    "Preserving tags" paragraph of tagged-pointers.txt.
> +
> +A definition of the meaning of tagged pointers on arm64 can be found in:
> +Documentation/arm64/tagged-pointers.txt.
> +
> +Example of correct usage (pseudo-code) for a userspace application:
> +
> +bool arm64_syscall_tbi_is_present(void)
> +{
> +	unsigned long at_flags = getauxval(AT_FLAGS);
> +	if (at_flags & ARM64_AT_FLAGS_SYSCALL_TBI)
> +			return true;
> +
> +	return false;
> +}
> +
> +void main(void)
> +{
> +	char *addr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
> +			  MAP_ANONYMOUS, -1, 0);
> +
> +	int fd = open("test.txt", O_WRONLY);
> +
> +	/* Check if the relaxed ABI is supported */
> +	if (arm64_syscall_tbi_is_present()) {
> +		/* Add a tag to the pointer */
> +		addr = tag_pointer(addr);
> +	}
> +
> +	strcpy("Hello World\n", addr);
> +
> +	/* Write to a file */
> +	write(fd, addr, sizeof(addr));
> +
> +	close(fd);
> +}
> +
