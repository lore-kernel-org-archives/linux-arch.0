From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Subject: Re: [PATCH v3] vmlinux.lds: account for destructor sections
Date: Fri, 1 Jul 2016 17:58:44 +0300
Message-ID: <CAPAsAGyf79rFQQz6Vhx24V3eo3dtLFyEvEVGYgTJN3A0BYfqGw@mail.gmail.com>
References: <1466782768-106896-1-git-send-email-dvyukov@google.com>
 <CAPAsAGxojhprvmrXF4vuPTN73t5CYVR-919GDJmm39uC+5-ZLA@mail.gmail.com> <CACT4Y+ZnKniz2ojANqTEF709a01Ote-uuqsACL7SOWrDkUnJ_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACT4Y+ZnKniz2ojANqTEF709a01Ote-uuqsACL7SOWrDkUnJ_Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, kasan-dev <kasan-dev@googlegroups.com>, Alexander Potapenko <glider@google.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

2016-06-29 20:28 GMT+03:00 Dmitry Vyukov <dvyukov@google.com>:
> On Fri, Jun 24, 2016 at 6:57 PM, Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>> 2016-06-24 18:39 GMT+03:00 Dmitry Vyukov <dvyukov@google.com>:
>>> If CONFIG_KASAN is enabled and gcc is configured with
>>> --disable-initfini-array and/or gold linker is used,
>>> gcc emits .ctors/.dtors and .text.startup/.text.exit
>>> sections instead of .init_array/.fini_array.
>>> .dtors section is not explicitly accounted in the linker
>>> script and messes vvar/percpu layout. Want:
>>>
>>> ffffffff822bfd80 D _edata
>>> ffffffff822c0000 D __vvar_beginning_hack
>>> ffffffff822c0000 A __vvar_page
>>> ffffffff822c0080 0000000000000098 D vsyscall_gtod_data
>>> ffffffff822c1000 A __init_begin
>>> ffffffff822c1000 D init_per_cpu__irq_stack_union
>>> ffffffff822c1000 A __per_cpu_load
>>> ffffffff822d3000 D init_per_cpu__gdt_page
>>>
>>> Got:
>>>
>>> ffffffff8279a600 D _edata
>>> ffffffff8279b000 A __vvar_page
>>> ffffffff8279c000 A __init_begin
>>> ffffffff8279c000 D init_per_cpu__irq_stack_union
>>> ffffffff8279c000 A __per_cpu_load
>>> ffffffff8279e000 D __vvar_beginning_hack
>>> ffffffff8279e080 0000000000000098 D vsyscall_gtod_data
>>> ffffffff827ae000 D init_per_cpu__gdt_page
>>>
>>> This happens because __vvar_page and .vvar get different
>>> addresses in arch/x86/kernel/vmlinux.lds.S:
>>>
>>>         . = ALIGN(PAGE_SIZE);
>>>         __vvar_page = .;
>>>
>>>         .vvar : AT(ADDR(.vvar) - LOAD_OFFSET) {
>>>                 /* work around gold bug 13023 */
>>>                 __vvar_beginning_hack = .;
>>>
>>> Discard .dtors/.fini_array/.text.exit, since we don't call dtors.
>>> Merge .text.startup into init text.
>>>
>>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>>
>> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>
>
> Who can take it to some tree?

akpm tends to be the maintainer of last resort.
But you probably need to resend the patch, because LKML was not in CC list.
Also, please add stable tag: Cc: <stable@vger.kernel.org> # v4.0+
