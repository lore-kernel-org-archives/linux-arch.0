Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F885C48BE0
	for <linux-arch@archiver.kernel.org>; Thu, 10 Jun 2021 20:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08F461375
	for <linux-arch@archiver.kernel.org>; Thu, 10 Jun 2021 20:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhFJVAK (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 10 Jun 2021 17:00:10 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46278 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFJVAJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jun 2021 17:00:09 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lrRkd-00G7Q2-LO; Thu, 10 Jun 2021 14:58:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lrRkb-003V64-TI; Thu, 10 Jun 2021 14:58:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-arch@vger.kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>,
        Daniel Jacobowitz <drow@nevyn.them.org>,
        Kees Cook <keescook@chromium.org>
Date:   Thu, 10 Jun 2021 15:57:58 -0500
Message-ID: <87sg1p30a1.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lrRkb-003V64-TI;;;mid=<87sg1p30a1.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1//8WQu+x+uCru6/HE74WQnaxGdKbF4cdU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Folks,

Digging through the guts of exit I found something I am not quite
certain what to do with.  On some architectures such as alpha, m68k, and
nios2 the kernel calls into system calls with a subset of the registers
saved on the kernel stack, and the kernel calls into signal handling and
a few other contexts with all of the registers saved on the kernel
stack.  The problem is sometimes we read all of the registers from
a context where they are not all saved.

When this was initially observed it looked just like a coredump problem
and it could be solved by tweaking the coredump code.  That change was
77f6ab8b7768 ("don't dump the threads that had been already exiting when
zapped.")

However I have looked farther and we have the location where get_signal
is called from io_uring, and we have the ptrace_stop in
PTRACE_EVENT_EXIT.  In PTRACE_EVENT_EXIT we could be called from exit(2)
which is a syscall and we definitely won't have everything saved on the
kernel stack.  I have not doubled checked create_io_thread but I don't
think create_io_threads saves all of the registers on the kernel stack.

I think at this point we need to say that the architectures that have a
do this need to be fixed to at least call do_exit and the kernel
function in create_io_thread with the deeper stack.

Is that reasonable of me to ask?  Is there some other way to deal with
this issue that I am not seeing?  Am I missing some critical detail that
makes PTRACE_EVENT_EXIT in do_exit not a problem if someone reads the
register with ptrace?

Eric

