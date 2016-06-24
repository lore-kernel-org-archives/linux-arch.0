From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Subject: Re: [PATCH v3] vmlinux.lds: account for destructor sections
Date: Fri, 24 Jun 2016 19:57:38 +0300
Message-ID: <CAPAsAGxojhprvmrXF4vuPTN73t5CYVR-919GDJmm39uC+5-ZLA@mail.gmail.com>
References: <1466782768-106896-1-git-send-email-dvyukov@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33177 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbcFXQ5l (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jun 2016 12:57:41 -0400
Received: by mail-lf0-f65.google.com with SMTP id l188so22347986lfe.0
        for <linux-arch@vger.kernel.org>; Fri, 24 Jun 2016 09:57:40 -0700 (PDT)
In-Reply-To: <1466782768-106896-1-git-send-email-dvyukov@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, kasan-dev <kasan-dev@googlegroups.com>, Alexander Potapenko <glider@google.com>

2016-06-24 18:39 GMT+03:00 Dmitry Vyukov <dvyukov@google.com>:
> If CONFIG_KASAN is enabled and gcc is configured with
> --disable-initfini-array and/or gold linker is used,
> gcc emits .ctors/.dtors and .text.startup/.text.exit
> sections instead of .init_array/.fini_array.
> .dtors section is not explicitly accounted in the linker
> script and messes vvar/percpu layout. Want:
>
> ffffffff822bfd80 D _edata
> ffffffff822c0000 D __vvar_beginning_hack
> ffffffff822c0000 A __vvar_page
> ffffffff822c0080 0000000000000098 D vsyscall_gtod_data
> ffffffff822c1000 A __init_begin
> ffffffff822c1000 D init_per_cpu__irq_stack_union
> ffffffff822c1000 A __per_cpu_load
> ffffffff822d3000 D init_per_cpu__gdt_page
>
> Got:
>
> ffffffff8279a600 D _edata
> ffffffff8279b000 A __vvar_page
> ffffffff8279c000 A __init_begin
> ffffffff8279c000 D init_per_cpu__irq_stack_union
> ffffffff8279c000 A __per_cpu_load
> ffffffff8279e000 D __vvar_beginning_hack
> ffffffff8279e080 0000000000000098 D vsyscall_gtod_data
> ffffffff827ae000 D init_per_cpu__gdt_page
>
> This happens because __vvar_page and .vvar get different
> addresses in arch/x86/kernel/vmlinux.lds.S:
>
>         . = ALIGN(PAGE_SIZE);
>         __vvar_page = .;
>
>         .vvar : AT(ADDR(.vvar) - LOAD_OFFSET) {
>                 /* work around gold bug 13023 */
>                 __vvar_beginning_hack = .;
>
> Discard .dtors/.fini_array/.text.exit, since we don't call dtors.
> Merge .text.startup into init text.
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
