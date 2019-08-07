Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:58433 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387957AbfHGUiS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Aug 2019 16:38:18 -0400
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
Date: Wed, 7 Aug 2019 13:38:16 -0700
MIME-Version: 1.0
In-Reply-To: <20190807155321.9648-2-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will.deacon@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190807203816.aLx1b5KIps842-0N7629vkavzclof8br3WHhWPwm0Ws@z>

On 8/7/19 8:53 AM, Catalin Marinas wrote:
> +- mmap() done by the process itself (or its parent), where either:
> +
> +  - flags have the **MAP_ANONYMOUS** bit set
> +  - the file descriptor refers to a regular file (including those returned
> +    by memfd_create()) or **/dev/zero**

What's a "regular file"? ;)

> +- brk() system call done by the process itself (i.e. the heap area between
> +  the initial location of the program break at process creation and its
> +  current location).
> +
> +- any memory mapped by the kernel in the address space of the process
> +  during creation and with the same restrictions as for mmap() above (e.g.
> +  data, bss, stack).
> +
> +The AArch64 Tagged Address ABI is an opt-in feature and an application can
> +control it via **prctl()** as follows:
> +
> +- **PR_SET_TAGGED_ADDR_CTRL**: enable or disable the AArch64 Tagged Address
> +  ABI for the calling process.
> +
> +  The (unsigned int) arg2 argument is a bit mask describing the control mode
> +  used:
> +
> +  - **PR_TAGGED_ADDR_ENABLE**: enable AArch64 Tagged Address ABI. Default
> +    status is disabled.
> +
> +  The arguments arg3, arg4, and arg5 are ignored.

For previous prctl()'s, we've found that it's best to require that the
unused arguments be 0.  Without that, apps are free to put garbage
there, which makes extending the prctl to use other arguments impossible
in the future.

Also, shouldn't this be converted over to an arch_prctl()?

> +The prctl(PR_SET_TAGGED_ADDR_CTRL, ...) will return -EINVAL if the
> +AArch64 Tagged Address ABI is not available
> +(CONFIG_ARM64_TAGGED_ADDR_ABI disabled or sysctl abi.tagged_addr=0).
> +
> +The ABI properties set by the mechanism described above are inherited by
> +threads of the same application and fork()'ed children but cleared by
> +execve().

What is the scope of these prctl()'s?  Are they thread-scoped or
process-scoped?  Can two threads in the same process run with different
tagging ABI modes?

> +Opting in (the prctl() option described above only) to or out of the
> +AArch64 Tagged Address ABI can be disabled globally at runtime using the
> +sysctl interface:
> +
> +- **abi.tagged_addr**: a new sysctl interface that can be used to prevent
> +  applications from enabling or disabling the relaxed ABI. The sysctl
> +  supports the following configuration options:
> +
> +  - **0**: disable the prctl(PR_SET_TAGGED_ADDR_CTRL) option to
> +    enable/disable the AArch64 Tagged Address ABI globally
> +
> +  - **1** (Default): enable the prctl(PR_SET_TAGGED_ADDR_CTRL) option to
> +    enable/disable the AArch64 Tagged Address ABI globally
> +
> +  Note that this sysctl does not affect the status of the AArch64 Tagged
> +  Address ABI of the running processes.

Shouldn't the name be "abi.tagged_addr_control" or something?  It
actually has *zero* direct effect on tagged addresses in the ABI.

What's the reason for allowing it to be toggled at runtime like this?
Wouldn't it make more sense to just have it be a boot option so you
*know* what the state of individual processes is?

> +When a process has successfully enabled the new ABI by invoking
> +prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE), the following
> +behaviours are guaranteed:
> +
> +- Every currently available syscall, except the cases mentioned in section
> +  3, can accept any valid tagged pointer. The same rule is applicable to
> +  any syscall introduced in the future.
> +
> +- The syscall behaviour is undefined for non valid tagged pointers.

Do you really mean "undefined"?  I mean, a bad pointer is a bad pointer.
 Why should it matter if it's a tagged bad pointer or an untagged bad
pointer?

...
> +A definition of the meaning of tagged pointers on AArch64 can be found in:
> +Documentation/arm64/tagged-pointers.txt.
> +
> +3. AArch64 Tagged Address ABI Exceptions
> +-----------------------------------------
> +
> +The behaviour described in section 2, with particular reference to the
> +acceptance by the syscalls of any valid tagged pointer, is not applicable
> +to the following cases:

This is saying things in a pretty roundabout manner.  Can't it just say:
 "The following cases do not accept tagged pointers:"

> +- mmap() addr parameter.
> +
> +- mremap() new_address parameter.

Is munmap() missing?  Or was there a reason for leaving it out?

> +- prctl(PR_SET_MM, ``*``, ...) other than arg2 PR_SET_MM_MAP and
> +  PR_SET_MM_MAP_SIZE.
> +
> +- prctl(PR_SET_MM, PR_SET_MM_MAP{,_SIZE}, ...) struct prctl_mm_map fields.
> +
> +Any attempt to use non-zero tagged pointers will lead to undefined
> +behaviour.

I wonder if you want to generalize this a bit.  I think you're saying
that parts of the ABI that modify the *layout* of the address space
never accept tagged pointers.

> +4. Example of correct usage
> +---------------------------
> +.. code-block:: c
> +
> +   void main(void)
> +   {
> +           static int tbi_enabled = 0;
> +           unsigned long tag = 0;
> +
> +           char *ptr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
> +                            MAP_ANONYMOUS, -1, 0);
> +
> +           if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE,
> +                     0, 0, 0) == 0)
> +                   tbi_enabled = 1;
> +
> +           if (ptr == (void *)-1) /* MAP_FAILED */
> +                   return -1;
> +
> +           if (tbi_enabled)
> +                   tag = rand() & 0xff;
> +
> +           ptr = (char *)((unsigned long)ptr | (tag << TAG_SHIFT));
> +
> +           *ptr = 'a';
> +
> +           ...
> +   }

It looks like the TAG_SHIFT and tag size are pretty baked into the
aarch64 architecture.  But, are you confident that no future
implementations will want different positions or sizes?  (obviously
controlled by other TCR_EL1 bits)
