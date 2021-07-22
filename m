Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C42C63797
	for <linux-arch@archiver.kernel.org>; Thu, 22 Jul 2021 14:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6470D61285
	for <linux-arch@archiver.kernel.org>; Thu, 22 Jul 2021 14:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhGVOJx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 22 Jul 2021 10:09:53 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39950 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhGVOJx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jul 2021 10:09:53 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:48098)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m6a1r-001nQ8-1s; Thu, 22 Jul 2021 08:50:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:53656 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m6a1p-009t7o-Pi; Thu, 22 Jul 2021 08:50:26 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, torvalds@linux-foundation.org,
        schwab@linux-m68k.org
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
        <87zgunzovm.fsf@disp2133>
        <3b4f287b-7be2-0e7b-ae5a-6c11972601fb@gmail.com>
        <1b656c02-925c-c4ba-03d3-f56075cdfac5@gmail.com>
        <8735scvklk.fsf@disp2133>
        <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
        <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com>
        <87h7gopvz2.fsf@disp2133>
        <328e59fb-3e8c-e4cd-06b4-1975ce98614a@gmail.com>
Date:   Thu, 22 Jul 2021 09:49:10 -0500
In-Reply-To: <328e59fb-3e8c-e4cd-06b4-1975ce98614a@gmail.com> (Michael
        Schmitz's message of "Wed, 21 Jul 2021 10:16:05 +1200")
Message-ID: <877dhio13t.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1m6a1p-009t7o-Pi;;;mid=<877dhio13t.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ej+811tHbwtodrCZ2a0TVl7mUja4oBXU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Michael Schmitz <schmitzmic@gmail.com> writes:

> Hi Eric,
>
> On 21/07/21 8:32 am, Eric W. Biederman wrote:
>>
>>> diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
>>> index a8f4161..6c92d38 100644
>>> --- a/arch/m68k/fpsp040/skeleton.S
>>> +++ b/arch/m68k/fpsp040/skeleton.S
>>> @@ -502,7 +502,17 @@ in_ea:
>>>   	.section .fixup,#alloc,#execinstr
>>>   	.even
>>>   1:
>>> +
>>> +	SAVE_ALL_INT
>>> +	SAVE_SWITCH_STACK
>>          ^^^^^^^^^^
>>
>> I don't think this saves the registers in the well known fixed location
>> on the stack because some registers are saved at the exception entry
>> point.
>
> The FPU exception entry points are not using the exception entry code in
> head.S. These entry points are stored in the exception vector table directly. No
> saving of a syscall stack frame happens there. The FPU places its exception
> frame on the stack, and that is what the FPU exception handlers use.
>
> (If these have to call out to the generic exception handlers again, they will
> build a minimal stack frame, see code in skeleton.S.)
>
> Calling fpsp040_die() is no different from calling a syscall that may need to
> have access to the full stack frame. The 'fixed location' is just 'on the stack
> before calling  fpsp040_die()', again this is no different from calling
> e.g. sys_fork() which does not take a pointer to the begin of the stack frame as
> an argument.
>
> I must admit I never looked at how do_exit() figures out where the stack frame
> containing the saved registers is stored, I just assumed it unwinds the stack up
> to the point where the caller syscall was made, and works from there. The same
> strategy ought to work here.

For do_exit the part we need to be careful with is PTRACE_EVENT_EXIT,
which means it is ptrace that we need to look at.

For m68k the code in put_reg and get_reg finds the registers by looking
at task->thread.esp0.

I was expecting m68k to use the same technique as alpha which expects a
fixed offset from task_stack_page(task).

So your code will work if you add code to update task->thread.esp0 which
is also known as THREAD_ESP0 in entry.S

>> Without being saved at the well known fixed location if some process
>> stops in PTRACE_EVENT_EXIT in do_exit we likely get some complete
>> gibberish.
>>
>> That is probably safe.
>>
>>>   	jbra	fpsp040_die
>>> +	addql   #8,%sp
>>> +	addql   #8,%sp
>>> +	addql   #8,%sp
>>> +	addql   #8,%sp
>>> +	addql   #8,%sp
>>> +	addql   #4,%sp
>>> +	rts
>> Especially as everything after jumping to fpsp040_die does not execute.
>
> Unless we change fpsp040_die() to call force_sig(SIGSEGV).

Yes.  I think we would probably need to have it also call get_signal and
all of that, because I don't think the very light call path for that
exception includes testing if signals are pending.

The way the code is structured it is actively incorrect to return from
fpsp040_die, as the code does not know what to do if it reads a byte
from userspace and there is nothing there.

So instead of handling -EFAULT like most pieces of kernel code the code
just immediately calls do_exit, and does not even attempt to handle
the error.

That is not my favorite strategy at all, but I suspect it isn't worth
it, or safe to update the skeleton.S to handle errors.  Especially as we
have not even figured out how to test that code yet.

Eric
