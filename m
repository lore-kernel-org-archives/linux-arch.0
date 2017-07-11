From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: KASAN vs. boot-time switching between 4- and 5-level paging
Date: Tue, 11 Jul 2017 18:15:29 +0300
Message-ID: <d3caf8c4-4575-c1b5-6b0f-95527efaf2f9@virtuozzo.com>
References: <75acbed7-6a08-692f-61b5-2b44f66ec0d8@virtuozzo.com>
 <bc95be68-8c68-2a45-c530-acbc6c90a231@virtuozzo.com>
 <20170710123346.7y3jnftqgpingim3@node.shutemov.name>
 <CACT4Y+aRbC7_wvDv8ahH_JwY6P6SFoLg-kdwWHJx5j1stX_P_w@mail.gmail.com>
 <20170710141713.7aox3edx6o7lrrie@node.shutemov.name>
 <03A6D7ED-300C-4431-9EB5-67C7A3EA4A2E@amacapital.net>
 <20170710184704.realchrhzpblqqlk@node.shutemov.name>
 <CALCETrVJQ_u-agPm8fFHAW1UJY=VLowdbM+gXyjFCb586r0V3g@mail.gmail.com>
 <20170710212403.7ycczkhhki3vrgac@node.shutemov.name>
 <CALCETrW6pWzpdf1MVx_ytaYYuVGBsF7R+JowEsKqd3i=vCwJ_w@mail.gmail.com>
 <20170711103548.mkv5w7dd5gpdenne@node.shutemov.name>
 <CALCETrVpNUq3-zEu1Q1O77N8r4kv4kFdefXp7XEs3Hpf-JPAjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CALCETrVpNUq3-zEu1Q1O77N8r4kv4kFdefXp7XEs3Hpf-JPAjg@mail.gmail.com>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
List-Id: linux-arch.vger.kernel.org



On 07/11/2017 06:06 PM, Andy Lutomirski wrote:
> On Tue, Jul 11, 2017 at 3:35 AM, Kirill A. Shutemov
> <kirill@shutemov.name> wrote:
>> On Mon, Jul 10, 2017 at 05:30:38PM -0700, Andy Lutomirski wrote:
>>> On Mon, Jul 10, 2017 at 2:24 PM, Kirill A. Shutemov
>>> <kirill@shutemov.name> wrote:
>>>> On Mon, Jul 10, 2017 at 01:07:13PM -0700, Andy Lutomirski wrote:
>>>>> Can you give the disassembly of the backtrace lines?  Blaming the
>>>>> .endr doesn't make much sense to me.
>>>>
>>>> I don't have backtrace. It's before printk() is functional. I only see
>>>> triple fault and reboot.
>>>>
>>>> I had to rely on qemu tracing and gdb.
>>>
>>> Can you ask GDB or objtool to disassemble around those addresses?  Can
>>> you also attach the big dump that QEMU throws out that shows register
>>> state?  In particular, CR2, CR3, and CR4 could be useful.
>>
>> The last three execptions:
>>
>> check_exception old: 0xffffffff new 0xe, cr2: 0xffffffff7ffffff8, rip: 0xffffffff84bb3036
>> RAX=00000000ffffffff RBX=ffffffff800000d8 RCX=ffffffff84be4021 RDX=dffffc0000000000
>> RSI=0000000000000006 RDI=ffffffff84c57000 RBP=ffffffff800000c8 RSP=ffffffff80000000
> 
> So RSP was 0xffffffff80000000, a push happened, and we tried to write
> to 0xffffffff7ffffff8, which failed.
> 
>> check_exception old: 0xe new 0xe, cr2: 0xffffffff7ffffff8, rip: 0xffffffff84bb3141
>> RAX=00000000ffffffff RBX=ffffffff800000d8 RCX=ffffffff84be4021 RDX=dffffc0000000000
>> RSI=0000000000000006 RDI=ffffffff84c57000 RBP=ffffffff800000c8 RSP=ffffffff80000000
> 
> And #PF doesn't use IST, so it double-faulted.
> 
> Either the stack isn't mapped in the page tables, RSP is corrupt, or
> there's a genuine stack overflow here.
> 

I reproduced this, and this is kasan bug:

   │0xffffffff84864897 <x86_early_init_platform_quirks+5>   mov    $0xffffffff83f1d0b8,%rdi 
   │0xffffffff8486489e <x86_early_init_platform_quirks+12>  movabs $0xdffffc0000000000,%rax 
   │0xffffffff848648a8 <x86_early_init_platform_quirks+22>  push   %rbp
   │0xffffffff848648a9 <x86_early_init_platform_quirks+23>  mov    %rdi,%rdx  
   │0xffffffff848648ac <x86_early_init_platform_quirks+26>  shr    $0x3,%rdx
   │0xffffffff848648b0 <x86_early_init_platform_quirks+30>  mov    %rsp,%rbp
  >│0xffffffff848648b3 <x86_early_init_platform_quirks+33>  mov    (%rdx,%rax,1),%al

we crash on the last move which is a read from shadow

(gdb) p/x $rdx 
$1 = 0x1ffffffff07e3a17
(gdb) p/x $rax
$2 = 0xdffffc0000000000

(gdb) p/x 0xdffffc0000000000 + 0x1ffffffff07e3a17
$4 = 0xfffffbfff07e3a17
(gdb) p/x *0xfffffbfff07e3a17
Cannot access memory at address 0xfffffbfff07e3a17

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
