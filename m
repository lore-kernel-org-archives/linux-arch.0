Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BBFC636CB
	for <linux-arch@archiver.kernel.org>; Sat, 17 Jul 2021 18:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2C356115C
	for <linux-arch@archiver.kernel.org>; Sat, 17 Jul 2021 18:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhGQSzs (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 17 Jul 2021 14:55:48 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50444 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbhGQSzr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Jul 2021 14:55:47 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:56756)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m4pQg-0070LK-10; Sat, 17 Jul 2021 12:52:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:36048 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m4pQe-00Hb6R-VM; Sat, 17 Jul 2021 12:52:49 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, torvalds@linux-foundation.org,
        schwab@linux-m68k.org
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
        <87zgunzovm.fsf@disp2133>
        <3b4f287b-7be2-0e7b-ae5a-6c11972601fb@gmail.com>
        <1b656c02-925c-c4ba-03d3-f56075cdfac5@gmail.com>
Date:   Sat, 17 Jul 2021 13:52:39 -0500
In-Reply-To: <1b656c02-925c-c4ba-03d3-f56075cdfac5@gmail.com> (Michael
        Schmitz's message of "Sat, 17 Jul 2021 17:38:01 +1200")
Message-ID: <8735scvklk.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m4pQe-00Hb6R-VM;;;mid=<8735scvklk.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18U+B6HTEd/+Phi9Jk4EZYzmpUaLkcG/v0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Michael Schmitz <schmitzmic@gmail.com> writes:

> Am 16.07.2021 um 11:10 schrieb Michael Schmitz:
>> Eric,
>>
>> On 16/07/21 1:29 am, Eric W. Biederman wrote:
>>>
>>> I have been digging into this some more and I have found one place
>>> that I am having a challenge dealing with.
>>>
>>> In arch/m68k/fpsp040/skeleton.S there is an assembly version of
>>> copy_from_user that calls fpsp040_die when the bytes can not be read.
>>>
>>> Now fpsp040_die is just:
>>>
>>> /*
>>>   * This function is called if an error occur while accessing
>>>   * user-space from the fpsp040 code.
>>>   */
>>> asmlinkage void fpsp040_die(void)
>>> {
>>>     do_exit(SIGSEGV);
>>> }
>>> The problem here is the instruction emulation performed in the fpsp040
>>> code performs a very minimal saving of registers.  I don't think even
>>> the normal system call entry point registers that are saved are present
>>> at that point.
>>>
>>> Is there any chance you can help me figure out how to get a stack frame
>>> with all of the registers present before fpsp040_die is called?
>>
>> I suppose adding the following code (untested) to entry.S:
>>
>> ENTRY(fpsp040_die)
>>         SAVE_ALL_INT
>>         jbsr    fpsp040_die_c
>>         jra     ret_from_exception
>>
>> along with renaming above C entry point to fpsp040_die_c would add the
>> basic saved registers, but these would not necessarily reflect the state
>> of the processor when the fpsp040 trap was called. Is that what you're
>> after?
>
> I should have looked more closely at skeleton.S - most FPU exceptions
> handled there call trap_c the same way as is done for generic traps,
> i.e. SAVE_ALL_INT before, ret_from_exception after.
>
> Instead of adding code to entry.S, much better to add it in
> skeleton.S. I'll try to come up with a way to test this code path
> (calling fpsp040_die from the dz exception hander seems much the
> easiest way) to make sure this doesn't have side effects.
>
> Does do_exit() ever return?

No.  The function do_exit never returns.

If it is not too much difficulty I would be in favor of having the code
do force_sigsegv(SIGSEGV), instead of calling do_exit directly.

Looking at that code I have not been able to figure out the call paths
that get into skeleton.S.  I am not certain saving all of the registers
on an the exceptions that reach there make sense.  In practice I suspect
taking an exception is much more expensive than saving the registers so it
might not make any difference.  But this definitely looks like code that
is performance sensitive.

My sense when I was reading through skeleton.S was just one or two
registers were saved before the instruction emulation was called.

Eric

