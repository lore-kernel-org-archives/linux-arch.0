Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455E6C433EF
	for <linux-arch@archiver.kernel.org>; Fri,  7 Jan 2022 19:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiAGTC3 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 7 Jan 2022 14:02:29 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:40296 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiAGTC2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jan 2022 14:02:28 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:43986)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5uVP-00HEhT-Dg; Fri, 07 Jan 2022 12:02:27 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:48656 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5uVO-003OyS-Em; Fri, 07 Jan 2022 12:02:27 -0700
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
        <20211208202532.16409-3-ebiederm@xmission.com>
        <YdUxGKRcSiDy8jGg@zeniv-ca.linux.org.uk>
        <Yde2wwNmqzRTxh1f@zeniv-ca.linux.org.uk>
Date:   Fri, 07 Jan 2022 13:02:19 -0600
In-Reply-To: <Yde2wwNmqzRTxh1f@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Fri, 7 Jan 2022 03:42:59 +0000")
Message-ID: <87mtk7wero.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n5uVO-003OyS-Em;;;mid=<87mtk7wero.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19YtqG0d1ZS9sns+co2Ay8/Z9Im23FAtf4=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 03/10] exit: Move oops specific logic from do_exit into
 make_task_dead
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Wed, Jan 05, 2022 at 05:48:08AM +0000, Al Viro wrote:
>> On Wed, Dec 08, 2021 at 02:25:25PM -0600, Eric W. Biederman wrote:
>> > The beginning of do_exit has become cluttered and difficult to read as
>> > it is filled with checks to handle things that can only happen when
>> > the kernel is operating improperly.
>> > 
>> > Now that we have a dedicated function for cleaning up a task when the
>> > kernel is operating improperly move the checks there.
>> 
>> Umm...  I would probably take profile_task_exit() crap out before that
>> point.
>> 	1) the damn thing is dead - nothing registers notifiers there
>> 	2) blocking_notifier_call_chain() is not a nice thing to do on oops...
>> 
>> I'll post a patch ripping the dead parts of kernel/profile.c out tomorrow
>> morning (there's also profile_handoff_task(), equally useless these days
>> and complicating things for __put_task_struct()).
>
> Argh...  OK, so your subsequent series had pretty much the same thing.
> My apologies - still digging myself out from mail pile that had accumulated
> over two months ;-/

No worries.  I really appreciate getting some detail review.  Some
things just take another set of eyes to spot.

Eric

