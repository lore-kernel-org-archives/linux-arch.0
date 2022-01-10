Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A1FC433EF
	for <linux-arch@archiver.kernel.org>; Mon, 10 Jan 2022 15:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiAJPBC (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 10 Jan 2022 10:01:02 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:39910 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiAJPBC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 10:01:02 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:55338)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n6wAO-009Biv-G6; Mon, 10 Jan 2022 08:01:00 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:43782 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n6wAM-005OOe-Cx; Mon, 10 Jan 2022 08:01:00 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Kyle Huey" <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211208202532.16409-6-ebiederm@xmission.com>
        <YdelKq9U86/dHPcm@zeniv-ca.linux.org.uk>
        <87mtk6xegz.fsf@email.froward.int.ebiederm.org>
        <160ab942f83043d4878719e5354925cc@AcuMS.aculab.com>
Date:   Mon, 10 Jan 2022 09:00:31 -0600
In-Reply-To: <160ab942f83043d4878719e5354925cc@AcuMS.aculab.com> (David
        Laight's message of "Sat, 8 Jan 2022 22:44:33 +0000")
Message-ID: <87fspvy6sw.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n6wAM-005OOe-Cx;;;mid=<87fspvy6sw.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19iILV5Sx5O5SU9tvllA/FEzgwOywGT/7E=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 06/10] exit: Implement kthread_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> writes:

> From: Eric W. Biederman
>> Sent: 08 January 2022 18:36
>> 
>> Al Viro <viro@zeniv.linux.org.uk> writes:
>> 
>> > IMO the right way to handle that would be
>> > 	1) turn these two do_exit() into do_exit(0), to reduce
>> > confusion
>> > 	2) deal with all do_exit() in kthread payloads.  Your
>> > name for the primitive is fine, IMO.
>> > 	3) make that primitive pass the return value by way of
>> > a field in struct kthread, adjusting kthread_stop() accordingly
>> > and passing 0 to do_exit() in kthread_exit() itself.
>> >
>> > (2) is not as trivial as you seem to hope, though.  Your patches
>> > in drivers/staging/rt*/ had papered over the problem in there,
>> > but hadn't really solved it.
>> >
>> > thread_exit() should've been shot, all right, but it really ought
>> > to have been complete_and_exit() there.  The thing is, complete()
>> > + return does *not* guarantee that driver won't get unloaded before
>> > the thread terminates.  Possibly freeing its .code and leaving
>> > a thread to resume running in there as soon as it regains CPU.
>> >
>> > The point of complete_and_exit() is that it's noreturn *and* in
>> > core kernel.  So it can be safely used in a modular kthread,
>> > if paired with wait_for_completion() in or before module_exit.
>> > complete() + do_exit() (or complete + return as you've gotten
>> > there) doesn't give such guarantees at all.
>> 
>> 
>> I think we are mostly in agreement here.
>> 
>> There are kernel threads started by modules that do:
>> 	complete(...);
>>         return 0;
>> 
>> That should be at a minimum calling complete_and_exit.  Possibly should
>> be restructured to use kthread_stop().
>
> There is also module_put_and_exit(0);
> Which must have an implied THIS_MODULE.

Later in the patch series I change
module_put_and_exit -> module_put_and_kthread_exit
complete_and_exit -> complete_and_kthread_exit

The problem that I understand all was seeing was where people should
have been using complete_and_exit and were not.

Eric
