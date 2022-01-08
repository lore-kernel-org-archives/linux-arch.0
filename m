Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19753C433EF
	for <linux-arch@archiver.kernel.org>; Sat,  8 Jan 2022 18:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiAHSVD (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 8 Jan 2022 13:21:03 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:54758 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiAHSVC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 13:21:02 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:46732)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n6GKr-006iKN-PK; Sat, 08 Jan 2022 11:21:01 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:34300 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n6GKq-000x5y-LD; Sat, 08 Jan 2022 11:21:01 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211208202532.16409-9-ebiederm@xmission.com>
        <Yde6sQqp9Rx0Zm5I@zeniv-ca.linux.org.uk>
Date:   Sat, 08 Jan 2022 12:20:53 -0600
In-Reply-To: <Yde6sQqp9Rx0Zm5I@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Fri, 7 Jan 2022 03:59:45 +0000")
Message-ID: <87lezqytq2.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n6GKq-000x5y-LD;;;mid=<87lezqytq2.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX181W88GJJh8ztDxyWUuySS1bDqpA7vYpcY=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 09/10] kthread: Ensure struct kthread is present for all
 kthreads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Wed, Dec 08, 2021 at 02:25:31PM -0600, Eric W. Biederman wrote:
>> Today the rules are a bit iffy and arbitrary about which kernel
>> threads have struct kthread present.  Both idle threads and thread
>> started with create_kthread want struct kthread present so that is
>> effectively all kernel threads.  Make the rule that if PF_KTHREAD
>> and the task is running then struct kthread is present.
>> 
>> This will allow the kernel thread code to using tsk->exit_code
>> with different semantics from ordinary processes.
>
> Getting rid of ->exit_code abuse is independent from this.
> I'm not saying that this change is a bad idea, but it's an
> independent thing.  Simply turn these two failure exits
> into do_exit(0) in 06/10 and that's it.  Then this one
> would get rid of if (!self) and the second of those two
> calls, but it won't be nailed to that point of queue.

That is a good point.

As this code has been in linux-next for a while, I am going to leave
the dependency in place in the interests of sending Linus tested code.

This change with the bit about which field points to struct kthread
seems like a good idea on it's own merits.

Eric

