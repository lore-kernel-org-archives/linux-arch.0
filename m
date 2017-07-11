Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbdGKAbA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jul 2017 20:31:00 -0400
Received: from mail-ua0-f170.google.com (mail-ua0-f170.google.com [209.85.217.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1DD422C9B
        for <linux-arch@vger.kernel.org>; Tue, 11 Jul 2017 00:30:59 +0000 (UTC)
Received: by mail-ua0-f170.google.com with SMTP id w19so65240296uac.0
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2017 17:30:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170710212403.7ycczkhhki3vrgac@node.shutemov.name>
References: <CACT4Y+bSTOeJtDDZVmkff=qqJFesA_b6uTG__EAn4AvDLw0jzQ@mail.gmail.com>
 <c4f11000-6138-c6ab-d075-2c4bd6a14943@virtuozzo.com> <75acbed7-6a08-692f-61b5-2b44f66ec0d8@virtuozzo.com>
 <bc95be68-8c68-2a45-c530-acbc6c90a231@virtuozzo.com> <20170710123346.7y3jnftqgpingim3@node.shutemov.name>
 <CACT4Y+aRbC7_wvDv8ahH_JwY6P6SFoLg-kdwWHJx5j1stX_P_w@mail.gmail.com>
 <20170710141713.7aox3edx6o7lrrie@node.shutemov.name> <03A6D7ED-300C-4431-9EB5-67C7A3EA4A2E@amacapital.net>
 <20170710184704.realchrhzpblqqlk@node.shutemov.name> <CALCETrVJQ_u-agPm8fFHAW1UJY=VLowdbM+gXyjFCb586r0V3g@mail.gmail.com>
 <20170710212403.7ycczkhhki3vrgac@node.shutemov.name>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 10 Jul 2017 17:30:38 -0700
Message-ID: <CALCETrW6pWzpdf1MVx_ytaYYuVGBsF7R+JowEsKqd3i=vCwJ_w@mail.gmail.com>
Subject: Re: KASAN vs. boot-time switching between 4- and 5-level paging
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andy Lutomirski <luto@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Message-ID: <20170711003038.wo87JpCbSkKwWcElDFUJ-8-e25UYRBFP_FKv-5I9ock@z>

On Mon, Jul 10, 2017 at 2:24 PM, Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> On Mon, Jul 10, 2017 at 01:07:13PM -0700, Andy Lutomirski wrote:
>> Can you give the disassembly of the backtrace lines?  Blaming the
>> .endr doesn't make much sense to me.
>
> I don't have backtrace. It's before printk() is functional. I only see
> triple fault and reboot.
>
> I had to rely on qemu tracing and gdb.

Can you ask GDB or objtool to disassemble around those addresses?  Can
you also attach the big dump that QEMU throws out that shows register
state?  In particular, CR2, CR3, and CR4 could be useful.

--Andy
