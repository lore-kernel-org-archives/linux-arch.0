Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35618 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755578AbdGKRDf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2017 13:03:35 -0400
Received: by mail-lf0-f50.google.com with SMTP id b207so5599909lfg.2
        for <linux-arch@vger.kernel.org>; Tue, 11 Jul 2017 10:03:35 -0700 (PDT)
Date: Tue, 11 Jul 2017 20:03:32 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: KASAN vs. boot-time switching between 4- and 5-level paging
Message-ID: <20170711170332.wlaudicepkg35dmm@node.shutemov.name>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f11d9e07-6b31-1add-7677-6a29d15ab608@virtuozzo.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andy Lutomirski <luto@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Message-ID: <20170711170332.6-q0DxiO69Fix0IF6sntb6Hz5X9sqfWjN5LkqbzBi6k@z>

On Tue, Jul 11, 2017 at 07:45:48PM +0300, Andrey Ryabinin wrote:
> On 07/11/2017 06:15 PM, Andrey Ryabinin wrote:
> > 
> > I reproduced this, and this is kasan bug:
> > 
> >    │0xffffffff84864897 <x86_early_init_platform_quirks+5>   mov    $0xffffffff83f1d0b8,%rdi 
> >    │0xffffffff8486489e <x86_early_init_platform_quirks+12>  movabs $0xdffffc0000000000,%rax 
> >    │0xffffffff848648a8 <x86_early_init_platform_quirks+22>  push   %rbp
> >    │0xffffffff848648a9 <x86_early_init_platform_quirks+23>  mov    %rdi,%rdx  
> >    │0xffffffff848648ac <x86_early_init_platform_quirks+26>  shr    $0x3,%rdx
> >    │0xffffffff848648b0 <x86_early_init_platform_quirks+30>  mov    %rsp,%rbp
> >   >│0xffffffff848648b3 <x86_early_init_platform_quirks+33>  mov    (%rdx,%rax,1),%al
> > 
> > we crash on the last move which is a read from shadow
> 
> 
> Ughh, I forgot about phys_base.

Thanks! Works for me.

Can use your Signed-off-by for a [cleaned up version of your] patch?


-- 
 Kirill A. Shutemov
