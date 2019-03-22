Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfCVGWt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Mar 2019 02:22:49 -0400
MIME-Version: 1.0
References: <cover.1552679409.git.andreyknvl@google.com> <20190318163533.26838-1-vincenzo.frascino@arm.com>
 <20190318163533.26838-3-vincenzo.frascino@arm.com>
In-Reply-To: <20190318163533.26838-3-vincenzo.frascino@arm.com>
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Date: Fri, 22 Mar 2019 11:52:37 +0530
Message-ID: <CADGdYn7HYcj4vxw2bCS6McdNRmWu7o13=VAQra5A1Z18JNPMXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm64: Define Documentation/arm64/elf_at_flags.txt
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: LAK <linux-arm-kernel@lists.infradead.org>, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Kate Stewart <kstewart@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>, Kostya Serebryany <kcc@google.com>, Eric Dumazet <edumazet@google.com>, Chintan Pandya <cpandya@codeaurora.org>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Daniel Borkmann <daniel@iogearbox.net>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Graeme Barnes <Graeme.Barnes@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Dmitry Vyukov <dvyukov@google.com>, Branislav Rankov <Branislav.Rankov@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20190322062237.l6_-JYS3smJoz3wx9eNbsnFh_DM78u2sMWN0Kf3pNgM@z>

Hi Vincenzo,

On Mon, Mar 18, 2019 at 10:06 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
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
>  Documentation/arm64/elf_at_flags.txt | 133 +++++++++++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100644 Documentation/arm64/elf_at_flags.txt
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
> +       unsigned long at_flags = getauxval(AT_FLAGS);
> +       if (at_flags & FEATURE_X)
> +               return true;
> +
> +       return false;
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
> +  - any memory mapped by the kernel in the process's address space during
> +    creation and following the restrictions presented above (i.e. data, bss,
> +    stack).
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
> +       unsigned long at_flags = getauxval(AT_FLAGS);
> +       if (at_flags & ARM64_AT_FLAGS_SYSCALL_TBI)
> +                       return true;
> +
> +       return false;
> +}
> +
> +void main(void)
> +{
> +       char *addr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
> +                         MAP_ANONYMOUS, -1, 0);
> +
> +       int fd = open("test.txt", O_WRONLY);
> +
> +       /* Check if the relaxed ABI is supported */
> +       if (arm64_syscall_tbi_is_present()) {
> +               /* Add a tag to the pointer */
> +               addr = tag_pointer(addr);
> +       }
> +
> +       strcpy("Hello World\n", addr);
Nit: s/strcpy("Hello World\n", addr)/strcpy(addr, "Hello World\n")

Thanks,
Amit D
> +
> +       /* Write to a file */
> +       write(fd, addr, sizeof(addr));
> +
> +       close(fd);
> +}
> +
> --
> 2.21.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
