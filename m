From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v8 04/28] x86/asm/entry: annotate THUNKs
Date: Fri, 6 Sep 2019 09:43:17 +0200
Message-ID: <b339dc02-390d-b896-5b80-ebe5f08525e8@suse.cz>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-5-jslaby@suse.cz> <20190815124328.GG15313@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815124328.GG15313@zn.tnic>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 15. 08. 19, 14:43, Borislav Petkov wrote:
> On Thu, Aug 08, 2019 at 12:38:30PM +0200, Jiri Slaby wrote:
>> Place SYM_*_START_NOALIGN and SYM_*_END around the THUNK macro body.
>> Preserve @function by FUNC (64bit) and CODE (32bit). Given it was not
>> marked as aligned, use NOALIGN.
>>
>> The common tail .L_restore is put inside SYM_CODE_START_LOCAL_NOALIGN
>> and SYM_CODE_END too.
> 
> What is that needed for? It is a local label...
> 
>> The result:
>>  Value  Size Type    Bind   Vis      Ndx Name
>>   0000    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_on_thunk
>>   001c    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_off_thunk
>>   0038    24 FUNC    GLOBAL DEFAULT    1 lockdep_sys_exit_thunk
>>   0050    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule
>>   0068    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule_notra
> 
> No difference except alignment:

Yeah, alignment is one and visual effect the other. One can immediately
see where it starts and where it ends -- readability. There is no other
functional meaning, so I don't mind not annotating it. It's your call. So?

before:

#if defined(CONFIG_TRACE_IRQFLAGS) \
 || defined(CONFIG_DEBUG_LOCK_ALLOC) \
 || defined(CONFIG_PREEMPTION)
.L_restore:
        popq %r11
        popq %r10
        popq %r9
        popq %r8
        popq %rax
        popq %rcx
        popq %rdx
        popq %rsi
        popq %rdi
        popq %rbp
        ret
        _ASM_NOKPROBE(.L_restore)
#endif

after:
#if defined(CONFIG_TRACE_IRQFLAGS) \
 || defined(CONFIG_DEBUG_LOCK_ALLOC) \
 || defined(CONFIG_PREEMPTION)
SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
        popq %r11
        popq %r10
        popq %r9
        popq %r8
        popq %rax
        popq %rcx
        popq %rdx
        popq %rsi
        popq %rdi
        popq %rbp
        ret
        _ASM_NOKPROBE(.L_restore)
SYM_CODE_END(.L_restore)
#endif


thanks,
-- 
js
suse labs
