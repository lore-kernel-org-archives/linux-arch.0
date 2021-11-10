Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74399C433F5
	for <linux-arch@archiver.kernel.org>; Wed, 10 Nov 2021 18:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C606103C
	for <linux-arch@archiver.kernel.org>; Wed, 10 Nov 2021 18:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhKJSR2 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 10 Nov 2021 13:17:28 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:50940 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhKJSR1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Nov 2021 13:17:27 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:52310)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mks7K-000pJ1-DU; Wed, 10 Nov 2021 11:14:38 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:44490 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mks7J-007tkI-Hf; Wed, 10 Nov 2021 11:14:38 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>
References: <87tugkm3gc.fsf@disp2133>
Date:   Wed, 10 Nov 2021 12:14:02 -0600
In-Reply-To: <87tugkm3gc.fsf@disp2133> (Eric W. Biederman's message of "Wed,
        10 Nov 2021 09:32:19 -0600")
Message-ID: <874k8j3ml1.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mks7J-007tkI-Hf;;;mid=<874k8j3ml1.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/PDsEsELP7apBRzH/mY/wQRDe8KsIvi4k=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL] exit cleanups for v5.16
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Linus,
>
> Please pull the exit-cleanups-for-v5.16 branch from the git tree:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exit-cleanups-for-v5.16
>
>   HEAD: f91140e4553408cacd326624cd50fc367725e04a Arnd Bergmann <arnd@arndb.de>
>
>
> While looking at some issues related to the exit path in the kernel I
> found several instances where the code is not using the existing
> abstractions properly.
>
> This set of changes introduces force_fatal_sig a way of sending
> a signal and not allowing it to be caught, and corrects the
> misuse of the existing abstractions that I found.
>
> A lot of the misuse of the existing abstractions are silly things such
> as doing something after calling a no return function, rolling BUG by
> hand, doing more work than necessary to terminate a kernel thread, or
> calling do_exit(SIGKILL) instead of calling force_sig(SIGKILL).
>
> In the review a deficiency in force_fatal_sig and force_sig_seccomp
> where ptrace or sigaction could prevent the delivery of the signal was
> found.  I have added a change that adds SA_IMMUTABLE to change that
> makes it impossible to interrupt the delivery of those signals, and
> allows backporting to fix force_sig_seccomp.
>
> Arnd found an issue where a function passed to kthread_run had the wrong
> prototype, and after my cleanup was failing to build.

I forgot to mention there is a minor conflict with the staging tree.
One of the functions that I cleaned up was in a file that was completely
removed from staging.  The result is that when you encounter the
conflict that file can simply be removed.

Eric
