Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492FDC49EA6
	for <linux-arch@archiver.kernel.org>; Thu, 24 Jun 2021 21:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27826613B7
	for <linux-arch@archiver.kernel.org>; Thu, 24 Jun 2021 21:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhFXVk1 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 24 Jun 2021 17:40:27 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59776 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhFXVk0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jun 2021 17:40:26 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:34726)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwX2z-008su7-FE; Thu, 24 Jun 2021 15:38:05 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:51012 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lwX2y-003iue-41; Thu, 24 Jun 2021 15:38:05 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
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
        Arnd Bergmann <arnd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
        <87sg1lwhvm.fsf@disp2133>
        <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
        <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
        <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
        <87eed4v2dc.fsf@disp2133>
        <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
        <87fsxjorgs.fsf@disp2133>
        <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
        <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
        <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
        <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
        <87a6njf0ia.fsf@disp2133>
        <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
        <87tulpbp19.fsf@disp2133>
        <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
        <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133>
        <87y2az5bmt.fsf_-_@disp2133>
        <CAHk-=wg16ZBqtLngzE2edV8e68Qxje2kFehnKTrBBe5opcsj-w@mail.gmail.com>
Date:   Thu, 24 Jun 2021 16:37:19 -0500
In-Reply-To: <CAHk-=wg16ZBqtLngzE2edV8e68Qxje2kFehnKTrBBe5opcsj-w@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 24 Jun 2021 13:11:18 -0700")
Message-ID: <87a6nf54hc.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lwX2y-003iue-41;;;mid=<87a6nf54hc.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18LalAUym3BX/fF3gpKr2RXYRq1CIkZYD0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 7/9] signal: Make individual tasks exiting a first class concept.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Jun 24, 2021 at 12:03 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Implement start_task_exit_locked and rewrite the de_thread logic
>> in exec using it.
>>
>> Calling start_task_exit_locked is equivalent to asyncrhonously
>> calling exit(2) aka pthread_exit on a task.
>
> Ok, so this is the patch that makes me go "Yeah, this seems to all go together".
>
> The whole "start_exit()" thing seemed fairly sane as an interesting
> concept to the whole ptrace notification thing, but this one actually
> made me think it makes conceptual sense and how we had exactly that
> "start exit asynchronously" case already in zap_other_threads().
>
> So doing that zap_other_threads() as that async exit makes me just
> thin kthat yes, this series is the right thing, because it not only
> cleans up the ptrace condition, it makes sense in this entirely
> unrelated area too.
>
> So I think I'm convinced. I'd like Oleg in particular to Ack this
> series, and Al to look it over, but I do think this is the right
> direction.

Thanks.

It took a bit of exploration and playing with things to get here,
but I had the same sense.

Next round I will see if I can clean up the patches a bit more.

Eric
