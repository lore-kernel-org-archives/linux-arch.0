Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37632 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391135AbfBNKDU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Feb 2019 05:03:20 -0500
Subject: Re: [PATCH v7 05/28] x86/asm/entry: annotate THUNKs
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-6-jslaby@suse.cz> <20190209112551.GA5089@zn.tnic>
 <b75f2a0d-974a-c63b-64f8-8f333991e826@suse.cz>
 <20190212110501.GB30028@zn.tnic>
 <6b6aebb5-5f7c-e3b7-545e-3a4558e01e66@suse.cz>
 <20190212114654.GC30028@zn.tnic>
 <37e83ece-28c0-a7ec-86a3-b9b5ca2c61f6@suse.cz>
 <20190212121347.GD30028@zn.tnic>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <cd09f00f-7174-4d06-50a2-3cc056b7d763@suse.cz>
Date: Thu, 14 Feb 2019 11:03:14 +0100
MIME-Version: 1.0
In-Reply-To: <20190212121347.GD30028@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Message-ID: <20190214100314.RC-0EuqXt3V6FXo8xDniqJsxCvf__PF65_W6y9dYGE0@z>

On 12. 02. 19, 13:13, Borislav Petkov wrote:
> On Tue, Feb 12, 2019 at 12:51:08PM +0100, Jiri Slaby wrote:
>> And what if the LOCAL macros prepend .L automatically? The references
>> would need to be via macro or by manually adding .L. I mean:
>>
>> SYM_CODE_START_LOCAL(function)
>>   ret
>> SYM_CODE_END(function)
>>
>> And then used as:
>> call .Lfunction
>> or
>> call SYM_LOCAL(function)
>>
>> Is that too ugly?
> 
> I'd prefer SYM_LOCAL because not everyone is aware of the fact that the
> GNU toolchain makes .L-prepended symbols local.

The problem with local .L symbols is when debugging:
> Local symbols are defined and used within the assembler, but they are
> normally not saved in object files.  Thus, they are not visible when
> debugging.

Which means, when I have:
> .text
> 
> .globl _start
> _start:
>         call .Lbubak
> .type _start STT_FUNC
> .size _start, .-_start
> 
> .Lbubak:
>         movb $0, 0
> .type .Lbubak STT_FUNC
> .size .Lbubak, .-.Lbubak

and I run it:
> (gdb) r
> Starting program: /tmp/asm/asm 
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000000000401006 in ?? ()
> (gdb) where
> #0  0x0000000000401006 in ?? ()
> #1  0x0000000000401005 in _start ()
> (gdb) disass
> No function contains program counter for selected frame.
> (gdb) disass *0x0000000000401006
> No function contains specified address.
> (gdb) x/i $pc
> => 0x401006:    movb   $0x0,0x0
> (gdb) x/i 0x0000000000401006
> => 0x401006:    movb   $0x0,0x0

Which is quite impractical -- disass won't work, only explicit dump via
x. And the kernel unwinder would be no more clever. So when patching
entry like:
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -323,6 +323,18 @@ SYM_CODE_START(__switch_to_asm)
>         jmp     __switch_to
>  SYM_CODE_END(__switch_to_asm)
>  
> +#if 0
> +#define KILLER killer
> +#else
> +#define KILLER .Lkiller
> +#endif
> +
> +SYM_CODE_START_LOCAL(KILLER)
> +       UNWIND_HINT_EMPTY
> +       movb $0, 0
> +       ret
> +SYM_CODE_END(KILLER)
> +
>  /*
>   * A newly forked process directly context switches into this address.
>   *
> @@ -332,6 +344,7 @@ SYM_CODE_END(__switch_to_asm)
>   */
>  SYM_CODE_START(ret_from_fork)
>         UNWIND_HINT_EMPTY
> +       call    KILLER
>         movq    %rax, %rdi
>         call    schedule_tail                   /* rdi: 'prev' task parameter */
>  

first results in objtool complaints:
> arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x190: unsupported intra-function call
> arch/x86/entry/entry_64.o: warning: objtool: If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.

and also the crash is misleading:
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> #PF error: [WRITE] 
> PGD 0 P4D 0 
> Oops: 0002 [#1] PREEMPT SMP
...
> RIP: 0010:__switch_to_asm+0x70/0x80

opposing to classic symbol:
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> #PF error: [WRITE] 
> PGD 0 P4D 0 
> Oops: 0002 [#1] PREEMPT SMP
...> RIP: 0010:killer+0x0/0x10

(The killer was appended to the previous function by gas in the former
case.)

Therefore, I don't think using local .L labels outside of functions is a
good idea...

regards,
-- 
js
suse labs
