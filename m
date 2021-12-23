Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A96EC433FE
	for <linux-arch@archiver.kernel.org>; Thu, 23 Dec 2021 03:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346220AbhLWDeu (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 22 Dec 2021 22:34:50 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:51616 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346218AbhLWDet (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Dec 2021 22:34:49 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:41304)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n0EsS-008mUJ-A0; Wed, 22 Dec 2021 20:34:48 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:43790 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n0EsR-00AR5u-8e; Wed, 22 Dec 2021 20:34:47 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mike Christie <michael.christie@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211208202532.16409-9-ebiederm@xmission.com>
        <YcNsG0Lp94V13whH@archlinux-ax161>
        <87zgoswkym.fsf@email.froward.int.ebiederm.org>
        <YcNyjxac3wlKPywk@archlinux-ax161>
        <87pmpow7ga.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wgtFAA9SbVYg0gR1tqPMC17-NYcs0GQkaYg1bGhh1uJQQ@mail.gmail.com>
Date:   Wed, 22 Dec 2021 21:34:39 -0600
In-Reply-To: <CAHk-=wgtFAA9SbVYg0gR1tqPMC17-NYcs0GQkaYg1bGhh1uJQQ@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 22 Dec 2021 17:44:19 -0800")
Message-ID: <87o858uh80.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n0EsR-00AR5u-8e;;;mid=<87o858uh80.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/fF160QdsqN4oM1IDCMSjxQAhzKoPXXSg=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 09/10] kthread: Ensure struct kthread is present for all kthreads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Added a couple of people from the vhost thread.

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Dec 22, 2021 at 3:25 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Solve this by skipping the put_user for all kthreads.
>
> Ugh.
>
> While this fixes the problem, could we please just not mis-use that
> 'set_child_tid' as that kthread pointer any more?
>
> It was always kind of hacky. I think a new pointer with the proper
> 'struct kthread *' type would be an improvement.
>
> One of the "arguments" in the comment for re-using that set_child_tid
> pointer was that 'fork()' used to not wrongly copy it, but your patch
> literally now does that "allocate new kthread struct" at fork-time, so
> that argument is actually bogus now.

I agree.  I think I saw in the recent vhost patches that were
generalizing create_io_thread that the pf_io_worker field of
struct task_struct was being generalized as well.

If so I think it makes sense just to take that approach.

Just build some basic infrastructure that can be used for io_workers,
vhost_workers, and kthreads.

Eric


