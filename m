Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7722C47E48
	for <linux-arch@archiver.kernel.org>; Thu, 15 Jul 2021 13:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB7C613C3
	for <linux-arch@archiver.kernel.org>; Thu, 15 Jul 2021 13:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbhGONd1 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 15 Jul 2021 09:33:27 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55092 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbhGONd0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2021 09:33:26 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m41Rg-00AcTY-Kv; Thu, 15 Jul 2021 07:30:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:49460 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m41Rf-009x1e-Cw; Thu, 15 Jul 2021 07:30:32 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, torvalds@linux-foundation.org,
        schwab@linux-m68k.org
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
Date:   Thu, 15 Jul 2021 08:29:49 -0500
In-Reply-To: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com> (Michael
        Schmitz's message of "Wed, 23 Jun 2021 12:21:33 +1200")
Message-ID: <87zgunzovm.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m41Rf-009x1e-Cw;;;mid=<87zgunzovm.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19qDoQBF+W6wCsYMYjPYLIsWcESflkf144=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Michael Schmitz <schmitzmic@gmail.com> writes:

> m68k version of Eric's patch series 'alpha/ptrace: Improved
> switch_stack handling'.
>
> Registers d6, d7, a3-a6 are not saved on the stack by default
> on every syscall entry by the m68k kernel. A separate switch
> stack frame is pushed to save those registers as needed.
> This leaves the majority of syscalls with only a subset of
> registers on the stack, and access to unsaved registers in
> those would expose or modify random stack addresses.  
>
> Patch 1 and 2 add a switch stack for all syscalls that were
> found to need one to allow ptrace access to all registers
> outside of syscall entry/exit tracing, as well as kernel
> worker threads. This ought to protect against accidents.
>
> Patch 3 adds safety checks and debug output to m68k get_reg()
> and put_reg() functions. Any unsafe register access during
> process tracing will be prevented and reported. 
>
> Suggestions for optimizations or improvements welcome!
>
> Cheers,
>
>    Michael
>    
> Link: https://lore.kernel.org/r/<87pmwlek8d.fsf_-_@disp2133>

I have been digging into this some more and I have found one place
that I am having a challenge dealing with.

In arch/m68k/fpsp040/skeleton.S there is an assembly version of
copy_from_user that calls fpsp040_die when the bytes can not be read.

Now fpsp040_die is just:

/*
 * This function is called if an error occur while accessing
 * user-space from the fpsp040 code.
 */
asmlinkage void fpsp040_die(void)
{
	do_exit(SIGSEGV);
}


The problem here is the instruction emulation performed in the fpsp040
code performs a very minimal saving of registers.  I don't think even
the normal system call entry point registers that are saved are present
at that point.

Is there any chance you can help me figure out how to get a stack frame
with all of the registers present before fpsp040_die is called?

Eric
