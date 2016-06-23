From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Subject: Re: [PATCH] kasan: account for new sections when instrumenting globals
Date: Thu, 23 Jun 2016 17:58:08 +0300
Message-ID: <CAPAsAGzu1eo08UzmT=_W605tTfqaY+Sdh_63hd_8QRamDx-PBw@mail.gmail.com>
References: <1466615238-57411-1-git-send-email-dvyukov@google.com>
 <CAPAsAGwxXqyxAjj4o6q=1Ddz4h1PQrv5VcP=DrUg2NvK1or-=g@mail.gmail.com>
 <CAPAsAGx9gf-3K35TCGNjE=suW9_aDY0+a+0L9xtjtBHOYoiysg@mail.gmail.com>
 <CACT4Y+Zd25zQFXWL7tGFxt_-s-kM99K7SCgwyFxZuh2HPiW7Cw@mail.gmail.com>
 <CAPAsAGxkbvBVei=Kz4hyKij44GEh12kL9bUn28FomtfnA-xUAQ@mail.gmail.com>
 <CACT4Y+bBYULtE4ZgzLY=2yGtPyz5x_kKA0N8m74rUJzM6B=Piw@mail.gmail.com>
 <CACT4Y+YrYO0JYnknmFHk4EGvzyP7wwxW-xoMJtcJeEaHo17eDw@mail.gmail.com>
 <CAPAsAGwmf-ULn8Zry4yTZdJy7uiaFxLRcYpM=ZNSQqQOdy7sxQ@mail.gmail.com> <CACT4Y+aUPZsF4QQ1NPCxYeK_3fPCAB8X_+rnXdzEOaYgK8DtVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36580 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbcFWO6L (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2016 10:58:11 -0400
Received: by mail-lf0-f45.google.com with SMTP id q132so97545011lfe.3
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2016 07:58:10 -0700 (PDT)
In-Reply-To: <CACT4Y+aUPZsF4QQ1NPCxYeK_3fPCAB8X_+rnXdzEOaYgK8DtVQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, kasan-dev <kasan-dev@googlegroups.com>, Alexander Potapenko <glider@google.com>

2016-06-23 17:38 GMT+03:00 Dmitry Vyukov <dvyukov@google.com>:
> On Thu, Jun 23, 2016 at 4:00 PM, Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>> 2016-06-23 16:21 GMT+03:00 Dmitry Vyukov <dvyukov@google.com>:
>>>>
>>>> gcc version 6.1.1 20160513
>>>>
>>>> .dtors contains asan destructors for global vars:
>>>>
>>
>> Something has changed very recently, because my gcc-6.1.0 2016-04-27
>> generate .fini_array.
>> So if this is not a bug in gcc, and such change done intentionally, we
>> can just discard .dtors.
>> In case this is a bug, and it will be fixed in gcc release (6.2.0) we
>> can ignore it.
>
>
> Okay, turns out we configure our compilers with
> --disable-initfini-array for some reason. This switches it to usage of
> .ctors/.dtors.
>
> What about?
>

Looks good.

> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -537,15 +537,19 @@
>
>  #define INIT_TEXT                                                      \
>         *(.init.text)                                                   \
> +       *(.text.startup)                                                \
>         MEM_DISCARD(init.text)
>
>  #define EXIT_DATA                                                      \
>         *(.exit.data)                                                   \
> +       *(.fini_array)                                                  \
> +       *(.dtors)                                                       \
>         MEM_DISCARD(exit.data)                                          \
>         MEM_DISCARD(exit.rodata)
>
>  #define EXIT_TEXT                                                      \
>         *(.exit.text)                                                   \
> +       *(.text.exit)                                                   \
>         MEM_DISCARD(exit.text)
>
>  #define EXIT_CALL                                                      \
