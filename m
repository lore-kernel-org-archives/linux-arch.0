Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39908 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfIFHnX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Sep 2019 03:43:23 -0400
Subject: Re: [PATCH v8 04/28] x86/asm/entry: annotate THUNKs
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-5-jslaby@suse.cz> <20190815124328.GG15313@zn.tnic>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <b339dc02-390d-b896-5b80-ebe5f08525e8@suse.cz>
Date: Fri, 6 Sep 2019 09:43:17 +0200
MIME-Version: 1.0
In-Reply-To: <20190815124328.GG15313@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190906074317.BN8JK2fDBVo_9FdwiR3n-lKttI9R_DXM3acEy3Fb5Tk@z>

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
