Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F711C11F66
	for <linux-arch@archiver.kernel.org>; Mon, 28 Jun 2021 19:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B3CE61C94
	for <linux-arch@archiver.kernel.org>; Mon, 28 Jun 2021 19:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbhF1TYF (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:24:05 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37532 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbhF1TYE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 15:24:04 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:38726)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lxwp4-00Fc6j-MQ; Mon, 28 Jun 2021 13:21:34 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39076 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lxwp2-00GijM-LY; Mon, 28 Jun 2021 13:21:34 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
        Tejun Heo <tj@kernel.org>
References: <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
        <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
        <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
        <87a6njf0ia.fsf@disp2133>
        <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
        <87tulpbp19.fsf@disp2133>
        <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
        <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133>
        <87r1gr6qc4.fsf_-_@disp2133> <202106252014.5AE600929@keescook>
Date:   Mon, 28 Jun 2021 14:21:24 -0500
In-Reply-To: <202106252014.5AE600929@keescook> (Kees Cook's message of "Fri,
        25 Jun 2021 20:17:51 -0700")
Message-ID: <87im1xx0az.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lxwp2-00GijM-LY;;;mid=<87im1xx0az.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+AUA4C0dC+FUTNNB1hCOCUPdqu7Mk4gYY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 2/9] signal/seccomp: Refactor seccomp signal and coredump generation
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, Jun 24, 2021 at 01:59:55PM -0500, Eric W. Biederman wrote:
>> 
>> Factor out force_sig_seccomp from the seccomp signal generation and
>> place it in kernel/signal.c.  The function force_sig_seccomp takes a
>> paramter force_coredump to indicate that the sigaction field should be
>> reset to SIGDFL so that a coredump will be generated when the signal
>> is delivered.
>
> Ah! This is the part I missed when I was originally trying to figure
> out the coredump stuff. It's the need for setting a default handler
> (i.e. doing a coredump)?

Yes.  If we don't force the handler to SIG_DFL someone might catch
SIGSYS.

>> force_sig_seccomp is then used to replace both seccomp_send_sigsys
>> and seccomp_init_siginfo.
>> 
>> force_sig_info_to_task gains an extra parameter to force using
>> the default signal action.
>> 
>> With this change seccomp is no longer a special case and there
>> becomes exactly one place do_coredump is called from.
>
> Looks good to me. This may benefit from force_sig_seccomp() to be wrapped
> in an #ifdef CONFIG_SECCOMP.

At which point Linus will probably be grumpy with me for introducing
#ifdefs.

I suspect seccomp at this point is sufficiently common that is probably
more productive to figure out how to remove #ifdef  CONFIG_SECCOMP.

> (This patch reminds me that the seccomp self tests don't check for core
> dumps...)

This patch is slightly wrong in that it kept the call to do_group_exit
when it can never be reached.

Eric


