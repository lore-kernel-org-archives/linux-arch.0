From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: mm: new mm hook framework
Date: Thu, 25 Jun 2015 10:42:45 +0200
Message-ID: <558BBF05.1050703@linux.vnet.ibm.com>
References: <20150625040814.6C421660F7B@gitolite.kernel.org> <CAMuHMdUG3CbPGvTuPF_JO4JL1C6aqPpLwuZjfixF1zU117Vjfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:53308 "EHLO
	e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbbFYImv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jun 2015 04:42:51 -0400
Received: from /spool/local
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <ldufour@linux.vnet.ibm.com>;
	Thu, 25 Jun 2015 09:42:49 +0100
In-Reply-To: <CAMuHMdUG3CbPGvTuPF_JO4JL1C6aqPpLwuZjfixF1zU117Vjfw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 25/06/2015 09:12, Geert Uytterhoeven wrote:
> On Thu, Jun 25, 2015 at 6:08 AM, Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org> wrote:
>> Gitweb:     http://git.kernel.org/linus/;a=commit;h=2ae416b142b625c58c9ccb039aa3ef48ad0e9bae
>> Commit:     2ae416b142b625c58c9ccb039aa3ef48ad0e9bae
>> Parent:     e81f2d22370f8231cb7f13f454bcc8c0eb4e23f2
>> Refname:    refs/heads/master
>> Author:     Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> AuthorDate: Wed Jun 24 16:56:16 2015 -0700
>> Committer:  Linus Torvalds <torvalds@linux-foundation.org>
>> CommitDate: Wed Jun 24 17:49:41 2015 -0700
>>
>>     mm: new mm hook framework
>>
>>     CRIU is recreating the process memory layout by remapping the checkpointee
>>     memory area on top of the current process (criu).  This includes remapping
>>     the vDSO to the place it has at checkpoint time.
>>
>>     However some architectures like powerpc are keeping a reference to the
>>     vDSO base address to build the signal return stack frame by calling the
>>     vDSO sigreturn service.  So once the vDSO has been moved, this reference
>>     is no more valid and the signal frame built later are not usable.
>>
>>     This patch serie is introducing a new mm hook framework, and a new
>>     arch_remap hook which is called when mremap is done and the mm lock still
>>     hold.  The next patch is adding the vDSO remap and unmap tracking to the
>>     powerpc architecture.
>>
>>     This patch (of 3):
>>
>>     This patch introduces a new set of header file to manage mm hooks:
>>     - per architecture empty header file (arch/x/include/asm/mm-arch-hooks.h)
>>     - a generic header (include/linux/mm-arch-hooks.h)
>>
>>     The architecture which need to overwrite a hook as to redefine it in its
>>     header file, while architecture which doesn't need have nothing to do.
>>
>>     The default hooks are defined in the generic header and are used in the
>>     case the architecture is not defining it.
>>
>>     In a next step, mm hooks defined in include/asm-generic/mm_hooks.h should
>>     be moved here.
>>
>>     Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>>     Suggested-by: Andrew Morton <akpm@linux-foundation.org>
>>     Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>     Cc: Hugh Dickins <hughd@google.com>
>>     Cc: Rik van Riel <riel@redhat.com>
>>     Cc: Mel Gorman <mgorman@suse.de>
>>     Cc: Pavel Emelyanov <xemul@parallels.com>
>>     Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>     Cc: Paul Mackerras <paulus@samba.org>
>>     Cc: Michael Ellerman <mpe@ellerman.id.au>
>>     Cc: Ingo Molnar <mingo@kernel.org>
>>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>> ---
>>  arch/alpha/include/asm/mm-arch-hooks.h      | 15 +++++++++++++++
>>  arch/arc/include/asm/mm-arch-hooks.h        | 15 +++++++++++++++
>>  arch/arm/include/asm/mm-arch-hooks.h        | 15 +++++++++++++++
>>  arch/arm64/include/asm/mm-arch-hooks.h      | 15 +++++++++++++++
>>  arch/avr32/include/asm/mm-arch-hooks.h      | 15 +++++++++++++++
>>  arch/blackfin/include/asm/mm-arch-hooks.h   | 15 +++++++++++++++
>>  arch/c6x/include/asm/mm-arch-hooks.h        | 15 +++++++++++++++
>>  arch/cris/include/asm/mm-arch-hooks.h       | 15 +++++++++++++++
>>  arch/frv/include/asm/mm-arch-hooks.h        | 15 +++++++++++++++
>>  arch/hexagon/include/asm/mm-arch-hooks.h    | 15 +++++++++++++++
>>  arch/ia64/include/asm/mm-arch-hooks.h       | 15 +++++++++++++++
>>  arch/m32r/include/asm/mm-arch-hooks.h       | 15 +++++++++++++++
>>  arch/m68k/include/asm/mm-arch-hooks.h       | 15 +++++++++++++++
>>  arch/metag/include/asm/mm-arch-hooks.h      | 15 +++++++++++++++
>>  arch/microblaze/include/asm/mm-arch-hooks.h | 15 +++++++++++++++
>>  arch/mips/include/asm/mm-arch-hooks.h       | 15 +++++++++++++++
>>  arch/mn10300/include/asm/mm-arch-hooks.h    | 15 +++++++++++++++
>>  arch/nios2/include/asm/mm-arch-hooks.h      | 15 +++++++++++++++
>>  arch/openrisc/include/asm/mm-arch-hooks.h   | 15 +++++++++++++++
>>  arch/parisc/include/asm/mm-arch-hooks.h     | 15 +++++++++++++++
>>  arch/powerpc/include/asm/mm-arch-hooks.h    | 15 +++++++++++++++
>>  arch/s390/include/asm/mm-arch-hooks.h       | 15 +++++++++++++++
>>  arch/score/include/asm/mm-arch-hooks.h      | 15 +++++++++++++++
>>  arch/sh/include/asm/mm-arch-hooks.h         | 15 +++++++++++++++
>>  arch/sparc/include/asm/mm-arch-hooks.h      | 15 +++++++++++++++
>>  arch/tile/include/asm/mm-arch-hooks.h       | 15 +++++++++++++++
>>  arch/um/include/asm/mm-arch-hooks.h         | 15 +++++++++++++++
>>  arch/unicore32/include/asm/mm-arch-hooks.h  | 15 +++++++++++++++
>>  arch/x86/include/asm/mm-arch-hooks.h        | 15 +++++++++++++++
>>  arch/xtensa/include/asm/mm-arch-hooks.h     | 15 +++++++++++++++
>>  include/linux/mm-arch-hooks.h               | 16 ++++++++++++++++
> 
> Touching all arch/ directories without a CC to linux-arch?

I apologizes, this thread initially was only involving arch/powerpc
files, and following multiple advices it came to impact all arch.

> 
>>  31 files changed, 466 insertions(+)
>>
>> diff --git a/arch/alpha/include/asm/mm-arch-hooks.h b/arch/alpha/include/asm/mm-arch-hooks.h
>> new file mode 100644
>> index 0000000..b07fd86
>> --- /dev/null
>> +++ b/arch/alpha/include/asm/mm-arch-hooks.h
>> @@ -0,0 +1,15 @@
>> +/*
>> + * Architecture specific mm hooks
>> + *
>> + * Copyright (C) 2015, IBM Corporation
>> + * Author: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> 
> Cool, copyright on an empty header!
> 
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef _ASM_ALPHA_MM_ARCH_HOOKS_H
>> +#define _ASM_ALPHA_MM_ARCH_HOOKS_H
>> +
>> +#endif /* _ASM_ALPHA_MM_ARCH_HOOKS_H */
> 
> [...]
> 
> IMHO this screams for the generic version in include/asm-generic/,
> and "generic-y += mm-arch-hooks.h" in arch/*/include/asm/Kbuild/.

I do like your proposal which avoid creating too many *empty* files.
Since Andrew suggested the way I did the current patch, I'd appreciate
his feedback too.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
