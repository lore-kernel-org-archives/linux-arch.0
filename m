From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: KASAN vs. boot-time switching between 4- and 5-level paging
Date: Mon, 29 May 2017 12:02:18 +0200
Message-ID: <CACT4Y+YyFWg3fbj4ta3tSKoeBaw7hbL2YoBatAFiFB1_cMg9=Q@mail.gmail.com>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
 <20170525203334.867-8-kirill.shutemov@linux.intel.com> <20170526221059.o4kyt3ijdweurz6j@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:36723 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdE2KCk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2017 06:02:40 -0400
Received: by mail-vk0-f41.google.com with SMTP id p85so29439179vkd.3
        for <linux-arch@vger.kernel.org>; Mon, 29 May 2017 03:02:39 -0700 (PDT)
In-Reply-To: <20170526221059.o4kyt3ijdweurz6j@node.shutemov.name>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>

On Sat, May 27, 2017 at 12:10 AM, Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> On Thu, May 25, 2017 at 11:33:33PM +0300, Kirill A. Shutemov wrote:
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 0bf81e837cbf..c795207d8a3c 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -100,7 +100,7 @@ config X86
>>       select HAVE_ARCH_AUDITSYSCALL
>>       select HAVE_ARCH_HUGE_VMAP              if X86_64 || X86_PAE
>>       select HAVE_ARCH_JUMP_LABEL
>> -     select HAVE_ARCH_KASAN                  if X86_64 && SPARSEMEM_VMEMMAP
>> +     select HAVE_ARCH_KASAN                  if X86_64 && SPARSEMEM_VMEMMAP && !X86_5LEVEL
>>       select HAVE_ARCH_KGDB
>>       select HAVE_ARCH_KMEMCHECK
>>       select HAVE_ARCH_MMAP_RND_BITS          if MMU
>
> Looks like KASAN will be a problem for boot-time paging mode switching.
> It wants to know CONFIG_KASAN_SHADOW_OFFSET at compile-time to pass to
> gcc -fasan-shadow-offset=. But this value varies between paging modes...
>
> I don't see how to solve it. Folks, any ideas?

+kasan-dev

I wonder if we can use the same offset for both modes. If we use
0xFFDFFC0000000000 as start of shadow for 5 levels, then the same
offset that we use for 4 levels (0xdffffc0000000000) will also work
for 5 levels. Namely, ending of 5 level shadow will overlap with 4
level mapping (both end at 0xfffffbffffffffff), but 5 level mapping
extends towards lower addresses. The current 5 level start of shadow
is actually close -- 0xffd8000000000000 and it seems that the required
space after it is unused at the moment (at least looking at mm.txt).
So just try to move it to 0xFFDFFC0000000000?
