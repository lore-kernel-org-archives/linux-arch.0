Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FA1C433F5
	for <linux-arch@archiver.kernel.org>; Thu, 28 Oct 2021 16:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ABDE610CF
	for <linux-arch@archiver.kernel.org>; Thu, 28 Oct 2021 16:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhJ1Qgh (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:36:37 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:54138 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJ1Qgg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Oct 2021 12:36:36 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:35186)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mg8Lv-005DnD-MN; Thu, 28 Oct 2021 10:34:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:43544 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mg8Lu-002HAx-PA; Thu, 28 Oct 2021 10:34:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-13-ebiederm@xmission.com>
        <CAHk-=whe-ixeDp_OgSOsC4H+dWTLDSuNDU2a0sE3p8DapNeCuQ@mail.gmail.com>
        <9416e8d7-5545-4fc4-8ab0-68fddd35520b@kernel.org>
        <CAHk-=whJETM0MHqWQKCVALBkJX-Th5471z5FW3gFJO5c73L6QA@mail.gmail.com>
        <87v91kqt6b.fsf@disp2133>
        <CAHk-=wiph8wmVDJZiUETH3r_+fWhDvaEz64aA0XNimkSOHf+dw@mail.gmail.com>
Date:   Thu, 28 Oct 2021 11:33:59 -0500
In-Reply-To: <CAHk-=wiph8wmVDJZiUETH3r_+fWhDvaEz64aA0XNimkSOHf+dw@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 26 Oct 2021 09:15:52 -0700")
Message-ID: <87tuh1m7m0.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mg8Lu-002HAx-PA;;;mid=<87tuh1m7m0.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Tt77o5kiz8xKuTpFNy8fo11D0wrkux48=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 13/20] signal: Implement force_fatal_sig
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Oct 25, 2021 at 9:58 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Rereading this I think you might be misreading something.
>
> Gaah. Yes, indeed.
>
>> force_siginfo_to_task takes a sigdfl parameter which I am setting in
>> force_fatal_signal.
>
> .. and I realized that the first time I read through it, but then when
> I read through it due to Andy saying it worries him, I missed it and
> thought the handler didn't get reset.
>
> So the patch is fine.

Thank you.

Andy is right that there is a race with sigaction changing the signal
handler.

To make complete_signal reliably recognize fatal signals is going to
take a bit of work.  None of it particularly hard but there are a lot of
pieces that need to be changed carefully.  Part of the problem is that
recognizing fatal signals early started out as an optimization, and
there remain places in complete_signal and prepare_signal that assume it
is always possible to not recognize fatal signals early and let
get_signal handle things.

The coredump handling of it is the biggest challenge.  Computing a
destination thread with wants_signal in complete_signal before dealing
with fatal signals (which don't care) means that wants_signal can
cause the early recognition of fatal signals to fail.

The entire blocked vs real_blocked set of signal masks are interesting.
The current way those signal masks work does not appear to allow knowing
when blocked is being overridden and blocked is stored in real_blocked.
Something I think needs to be known if fatal signal are always going to
be recognized early.

Given that race it looks like it is important to make the guarantee that
fatal signals are always recognized early.  So the rest of the kernel
can count on that property.

But I aim to get this set of changes into linux-next first.  As I don't
anything will melt down if we leave that race for a bit longer.

Eric
