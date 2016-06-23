From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] kasan: account for new sections when instrumenting globals
Date: Thu, 23 Jun 2016 15:21:42 +0200
Message-ID: <CACT4Y+YrYO0JYnknmFHk4EGvzyP7wwxW-xoMJtcJeEaHo17eDw@mail.gmail.com>
References: <1466615238-57411-1-git-send-email-dvyukov@google.com>
 <CAPAsAGwxXqyxAjj4o6q=1Ddz4h1PQrv5VcP=DrUg2NvK1or-=g@mail.gmail.com>
 <CAPAsAGx9gf-3K35TCGNjE=suW9_aDY0+a+0L9xtjtBHOYoiysg@mail.gmail.com>
 <CACT4Y+Zd25zQFXWL7tGFxt_-s-kM99K7SCgwyFxZuh2HPiW7Cw@mail.gmail.com>
 <CAPAsAGxkbvBVei=Kz4hyKij44GEh12kL9bUn28FomtfnA-xUAQ@mail.gmail.com> <CACT4Y+bBYULtE4ZgzLY=2yGtPyz5x_kKA0N8m74rUJzM6B=Piw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33867 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbcFWNWE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2016 09:22:04 -0400
Received: by mail-lf0-f46.google.com with SMTP id h129so95873778lfh.1
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2016 06:22:02 -0700 (PDT)
In-Reply-To: <CACT4Y+bBYULtE4ZgzLY=2yGtPyz5x_kKA0N8m74rUJzM6B=Piw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, kasan-dev <kasan-dev@googlegroups.com>, Alexander Potapenko <glider@google.com>

On Thu, Jun 23, 2016 at 3:19 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, Jun 23, 2016 at 3:06 PM, Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>> 2016-06-23 15:40 GMT+03:00 Dmitry Vyukov <dvyukov@google.com>:
>>> On Thu, Jun 23, 2016 at 1:50 PM, Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>>>> 2016-06-23 14:49 GMT+03:00 Andrey Ryabinin <ryabinin.a.a@gmail.com>:
>>>>
>>>>> Frankly, I don't understand why .text.[exit,startup] sections has any relation
>>>>> to the bug you described, but maybe I just don't now linker
>>>>
>>>> ... scripting well enough to understand what's going on here.
>>>
>>>
>>> I noticed that these 3 new sections are what's different between
>>> kernel that works and kernel that does not work. So I decided to
>>> account all of them
>>> Checked now, it works only with .dtors.
>>> Is it preferable to add only .dtors or all sections?
>>
>> No. Merging text.startup/text.exit into INIT_TEXT/EXIT_TEXT makes sense anyway.
>> This will save us some memory. Also we can add .fini_array into
>> DISCARD section, because we don't need destructors.
>>
>> As for .dtors, at first I'd like to understand where it comes from.
>> AFAIU it shouldn't exist at all.
>> Recent gcc should generate .fini_array instead of .dtors -
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=46770
>> So something is wrong here. Can you share your kernel .config, kernel version?
>> And you use gcc-6.1.0, right?
>
> gcc version 6.1.1 20160513
>
> .dtors contains asan destructors for global vars:
>
>   [18] .dtors            PROGBITS         ffffffff8279a600  016c7600
>        0000000000002e20  0000000000000000  WA       0     0     8
>
> 016c7600  00 1b b4 81 ff ff ff ff  20 1b b4 81 ff ff ff ff  |........ .......|
> 016c7610  40 1b b4 81 ff ff ff ff  60 1b b4 81 ff ff ff ff  |@.......`.......|
> 016c7620  80 1b b4 81 ff ff ff ff  a0 1b b4 81 ff ff ff ff  |................|
> 016c7630  c0 1b b4 81 ff ff ff ff  e0 1b b4 81 ff ff ff ff  |................|
>
> vmlinux.old:ffffffff81b41b20 0000000000000017 t
> _GLOBAL__sub_D_65535_0_init_uts_ns
> vmlinux.old:ffffffff81b41b40 0000000000000017 t
> _GLOBAL__sub_D_65535_0_root_mountflags
> vmlinux.old:ffffffff81b41b60 0000000000000017 t _GLOBAL__sub_D_65535_0_rd_prompt
> vmlinux.old:ffffffff81b41b80 0000000000000017 t
> _GLOBAL__sub_D_65535_0_initrd_load
>
> ffffffff81b41b20 <_GLOBAL__sub_D_65535_0_init_uts_ns>:
> ffffffff81b41b20:       55                      push   %rbp
> ffffffff81b41b21:       be 03 00 00 00          mov    $0x3,%esi
> ffffffff81b41b26:       48 c7 c7 a0 23 21 82    mov    $0xffffffff822123a0,%rdi
> ffffffff81b41b2d:       48 89 e5                mov    %rsp,%rbp
> ffffffff81b41b30:       e8 9b 85 83 ff          callq
> ffffffff8137a0d0 <__asan_unregister_globals>
> ffffffff81b41b35:       5d                      pop    %rbp
> ffffffff81b41b36:       c3                      retq
> ffffffff81b41b37:       66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
> ffffffff81b41b3e:       00 00


gcc/asan.c seems to use plain dtors:
      fn = builtin_decl_implicit (BUILT_IN_ASAN_UNREGISTER_GLOBALS);
      append_to_statement_list (build_call_expr (fn, 2,
build_fold_addr_expr (var), gcount_tree), &dtor_statements);
      cgraph_build_static_cdtor ('D', dtor_statements, priority);
