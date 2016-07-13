Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:32773 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbcGMSnV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jul 2016 14:43:21 -0400
Received: by mail-vk0-f46.google.com with SMTP id x130so78318147vkc.0
        for <linux-arch@vger.kernel.org>; Wed, 13 Jul 2016 11:43:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160713075314.GA32700@gmail.com>
References: <cover.1468270393.git.luto@kernel.org> <8d36dd9b2430b61db64333af7b911d0bca7d5d2f.1468270393.git.luto@kernel.org>
 <20160713075314.GA32700@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 13 Jul 2016 11:42:35 -0700
Message-ID: <CALCETrW9B=MAGaLAV0Y86MQ2==pjoShHdOPNM_8ZR1OKZDy2ZQ@mail.gmail.com>
Subject: Re: [PATCH v5 14/32] x86/mm/64: Enable vmapped stacks
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20160713184235.Ij86E0rGBOMlbAkKLYOxvlLsO8dNsZ_7q_3CnHZsCb8@z>

On Wed, Jul 13, 2016 at 12:53 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Andy Lutomirski <luto@kernel.org> wrote:
>
>> This allows x86_64 kernels to enable vmapped stacks.  There are a
>> couple of interesting bits.
>
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -92,6 +92,7 @@ config X86
>>       select HAVE_ARCH_TRACEHOOK
>>       select HAVE_ARCH_TRANSPARENT_HUGEPAGE
>>       select HAVE_EBPF_JIT                    if X86_64
>> +     select HAVE_ARCH_VMAP_STACK             if X86_64
>
> So what is the performance impact?

Seems to be a very slight speedup (0.5 µs or so) on my silly benchmark
(pthread_create, pthread_join in a loop).  It should be a small
slowdown on workloads that create many threads all at once, thus
defeating the stack cache.  It should be a *large* speedup on any
workload that would trigger compaction on clone() to satisfy the
high-order allocation.

>
> Because I think we should consider enabling this feature by default on x86 - but
> the way it's selected here it will be default-off.
>
> On the plus side: the debuggability and reliability improvements are real and
> making it harder for exploits to use kernel stack overflows is a nice bonus as
> well. There's two performance effects:

Agreed.  At the very least, I want to wait until after net-next gets
pulled to flip the default to y.  I'm also a bit concerned about more
random driver issues that I haven't found yet.  I suppose we could
flip the default to y for a few -rc releases and see what, if
anything, shakes loose.

--Andy
