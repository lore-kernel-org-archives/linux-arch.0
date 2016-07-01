Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35313 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbcGAPU6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2016 11:20:58 -0400
Received: by mail-lf0-f42.google.com with SMTP id l188so79432219lfe.2
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2016 08:20:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1467386363-120030-1-git-send-email-dvyukov@google.com>
References: <1467386363-120030-1-git-send-email-dvyukov@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 1 Jul 2016 17:20:31 +0200
Message-ID: <CACT4Y+a6DnHitSQrEsy311Tn5-oeUse7aTrB9-=PTOx1afxavA@mail.gmail.com>
Subject: Re: [PATCH v4] vmlinux.lds: account for destructor sections
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: kasan-dev <kasan-dev@googlegroups.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160701152031.T2aNOECHYu8D8EkFoRi9dy9dtt9it9sS7yuimih1PVQ@z>

On Fri, Jul 1, 2016 at 5:19 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
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
> Cc: <stable@vger.kernel.org> # v4.0+
> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>
> ---
>
> Changes since v1:
>  - discard .dtors
>  - don't define .mem sections
>
> Changes since v2:
>  - use 'vmlinux.lds' subsystem prefix instead of 'kasan'
>
> Changes since v3:
>  - add 'Cc: <stable@vger.kernel.org> # v4.0+' tag
>  - CC linux-kernel@vger.kernel.org,akpm@linux-foundation.org


Andrew, can you please take this to mm tree?
