From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: KASAN vs. boot-time switching between 4- and 5-level paging
Date: Mon, 10 Jul 2017 19:57:00 +0300
Message-ID: <a3ed1e95-d1c1-9672-3010-ec06309f31cb@virtuozzo.com>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
 <20170525203334.867-8-kirill.shutemov@linux.intel.com>
 <20170526221059.o4kyt3ijdweurz6j@node.shutemov.name>
 <CACT4Y+YyFWg3fbj4ta3tSKoeBaw7hbL2YoBatAFiFB1_cMg9=Q@mail.gmail.com>
 <71e11033-f95c-887f-4e4e-351bcc3df71e@virtuozzo.com>
 <CACT4Y+bSTOeJtDDZVmkff=qqJFesA_b6uTG__EAn4AvDLw0jzQ@mail.gmail.com>
 <c4f11000-6138-c6ab-d075-2c4bd6a14943@virtuozzo.com>
 <75acbed7-6a08-692f-61b5-2b44f66ec0d8@virtuozzo.com>
 <bc95be68-8c68-2a45-c530-acbc6c90a231@virtuozzo.com>
 <20170710123346.7y3jnftqgpingim3@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-he1eur01on0103.outbound.protection.outlook.com ([104.47.0.103]:36304
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754359AbdGJQzV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jul 2017 12:55:21 -0400
In-Reply-To: <20170710123346.7y3jnftqgpingim3@node.shutemov.name>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>



On 07/10/2017 03:33 PM, Kirill A. Shutemov wrote:

> 
> [Sorry for loong delay.]
> 
> The patch works for me for legacy boot. But it breaks EFI boot with
> 5-level paging. And I struggle to understand why.
> 
> What I see is many page faults at mm/kasan/kasan.c:758 --
> "DEFINE_ASAN_LOAD_STORE(4)". Handling one of them I get double-fault at
> arch/x86/kernel/head_64.S:298 -- "pushq %r14", which ends up with triple
> fault.
> 
> Any ideas?
> 
> If you want to play with this by yourself, qemu supports la57 -- use
> -cpu "qemu64,+la57".
> 

I'll have a look.
