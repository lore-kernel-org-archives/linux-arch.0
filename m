Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ABAC48BE6
	for <linux-arch@archiver.kernel.org>; Wed, 16 Jun 2021 20:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D27026128C
	for <linux-arch@archiver.kernel.org>; Wed, 16 Jun 2021 20:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhFPUwB (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 16 Jun 2021 16:52:01 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:49094 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbhFPUwA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 16:52:00 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltcTw-00ASGj-NA; Wed, 16 Jun 2021 14:49:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltcTv-001WUp-L5; Wed, 16 Jun 2021 14:49:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
References: <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
        <87eed4v2dc.fsf@disp2133>
        <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
        <87fsxjorgs.fsf@disp2133> <87zgvqor7d.fsf_-_@disp2133>
        <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
        <87mtrpg47k.fsf@disp2133> <87pmwlek8d.fsf_-_@disp2133>
        <87eed1ek31.fsf_-_@disp2133> <YMpeP0CrRUVKIysE@zeniv-ca.linux.org.uk>
        <YMpfBsIvqbK0L4Gh@zeniv-ca.linux.org.uk>
Date:   Wed, 16 Jun 2021 15:49:44 -0500
In-Reply-To: <YMpfBsIvqbK0L4Gh@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Wed, 16 Jun 2021 20:28:54 +0000")
Message-ID: <87lf798rh3.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ltcTv-001WUp-L5;;;mid=<87lf798rh3.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+tvGfrhmCRiEkshSDUtMHfA0mFIPg5PpQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 2/2] alpha/ptrace: Add missing switch_stack frames
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Wed, Jun 16, 2021 at 08:25:35PM +0000, Al Viro wrote:
>> On Wed, Jun 16, 2021 at 01:32:50PM -0500, Eric W. Biederman wrote:
>> 
>> > -.macro	fork_like name
>> > +.macro	allregs name
>> >  	.align	4
>> >  	.globl	alpha_\name
>> >  	.ent	alpha_\name
>> > +	.cfi_startproc
>> >  alpha_\name:
>> >  	.prologue 0
>> > -	bsr	$1, do_switch_stack
>> > +	SAVE_SWITCH_STACK
>> >  	jsr	$26, sys_\name
>> > -	ldq	$26, 56($sp)
>> > -	lda	$sp, SWITCH_STACK_SIZE($sp)
>> > +	RESTORE_SWITCH_STACK
>> 
>> 	No.  You've just added one hell of an overhead to fork(2),
>> for no reason whatsoever.  sys_fork() et.al. does *NOT* modify the
>> callee-saved registers; it's plain C.  So this change is complete
>> BS.
>> 
>> > +allregs exit
>> > +allregs exit_group
>> 
>> 	Details, please - what exactly makes exit(2) different from
>> e.g. open(2)?
>
> Ah... PTRACE_EVENT_EXIT garbage, fortunately having no counterparts in case of
> open(2)...  Still, WTF would you want to restore callee-saved registers for
> in case of exit(2)?

Someone might want or try to read them in the case of exit.  Which
without some change will result in a read of other kernel stack content
on alpha.

Plus there are coredumps which definitely want to read everything.
Although admittedly that case no longer matters.

Eric

