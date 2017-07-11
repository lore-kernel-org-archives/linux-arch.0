Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr10124.outbound.protection.outlook.com ([40.107.1.124]:32864
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756279AbdGKR1w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jul 2017 13:27:52 -0400
Subject: Re: KASAN vs. boot-time switching between 4- and 5-level paging
References: <20170710141713.7aox3edx6o7lrrie@node.shutemov.name>
 <03A6D7ED-300C-4431-9EB5-67C7A3EA4A2E@amacapital.net>
 <20170710184704.realchrhzpblqqlk@node.shutemov.name>
 <CALCETrVJQ_u-agPm8fFHAW1UJY=VLowdbM+gXyjFCb586r0V3g@mail.gmail.com>
 <20170710212403.7ycczkhhki3vrgac@node.shutemov.name>
 <CALCETrW6pWzpdf1MVx_ytaYYuVGBsF7R+JowEsKqd3i=vCwJ_w@mail.gmail.com>
 <20170711103548.mkv5w7dd5gpdenne@node.shutemov.name>
 <CALCETrVpNUq3-zEu1Q1O77N8r4kv4kFdefXp7XEs3Hpf-JPAjg@mail.gmail.com>
 <d3caf8c4-4575-c1b5-6b0f-95527efaf2f9@virtuozzo.com>
 <f11d9e07-6b31-1add-7677-6a29d15ab608@virtuozzo.com>
 <20170711170332.wlaudicepkg35dmm@node.shutemov.name>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <e9a395f4-018e-4c8c-2098-170172e438f3@virtuozzo.com>
Date: Tue, 11 Jul 2017 20:29:59 +0300
MIME-Version: 1.0
In-Reply-To: <20170711170332.wlaudicepkg35dmm@node.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andy Lutomirski <luto@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Message-ID: <20170711172959.ejwK4OVnGJMk-TvRrdkCU9wD9dAJ2R3tB_qnaquQ4fI@z>



On 07/11/2017 08:03 PM, Kirill A. Shutemov wrote:
> On Tue, Jul 11, 2017 at 07:45:48PM +0300, Andrey Ryabinin wrote:
>> On 07/11/2017 06:15 PM, Andrey Ryabinin wrote:
>>>
>>> I reproduced this, and this is kasan bug:
>>>
>>>    │0xffffffff84864897 <x86_early_init_platform_quirks+5>   mov    $0xffffffff83f1d0b8,%rdi 
>>>    │0xffffffff8486489e <x86_early_init_platform_quirks+12>  movabs $0xdffffc0000000000,%rax 
>>>    │0xffffffff848648a8 <x86_early_init_platform_quirks+22>  push   %rbp
>>>    │0xffffffff848648a9 <x86_early_init_platform_quirks+23>  mov    %rdi,%rdx  
>>>    │0xffffffff848648ac <x86_early_init_platform_quirks+26>  shr    $0x3,%rdx
>>>    │0xffffffff848648b0 <x86_early_init_platform_quirks+30>  mov    %rsp,%rbp
>>>   >│0xffffffff848648b3 <x86_early_init_platform_quirks+33>  mov    (%rdx,%rax,1),%al
>>>
>>> we crash on the last move which is a read from shadow
>>
>>
>> Ughh, I forgot about phys_base.
> 
> Thanks! Works for me.
> 
> Can use your Signed-off-by for a [cleaned up version of your] patch?

Sure.
