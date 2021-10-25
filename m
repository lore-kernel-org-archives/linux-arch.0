Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C403BC433F5
	for <linux-arch@archiver.kernel.org>; Mon, 25 Oct 2021 21:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F36660F02
	for <linux-arch@archiver.kernel.org>; Mon, 25 Oct 2021 21:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhJYVa6 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 25 Oct 2021 17:30:58 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:33878 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhJYVax (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Oct 2021 17:30:53 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:54352)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mf7W9-00AqF5-U6; Mon, 25 Oct 2021 15:28:29 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:41832 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mf7W8-003uop-UG; Mon, 25 Oct 2021 15:28:29 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
        H Peter Anvin <hpa@zytor.com>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-10-ebiederm@xmission.com>
        <875ytkygfj.fsf_-_@disp2133>
        <CAHk-=whS0PL0NZrz2d8a3V+8=4szSZ6jqkg5fkjeaEjMN_NX8Q@mail.gmail.com>
Date:   Mon, 25 Oct 2021 16:28:22 -0500
In-Reply-To: <CAHk-=whS0PL0NZrz2d8a3V+8=4szSZ6jqkg5fkjeaEjMN_NX8Q@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 25 Oct 2021 14:12:03 -0700")
Message-ID: <87k0i0x095.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mf7W8-003uop-UG;;;mid=<87k0i0x095.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/DScZg9xLaFM+G28oBA4C2vv6AcTHqeoQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 10/32] signal/vm86_32: Properly send SIGSEGV when the vm86 state cannot be saved.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Oct 25, 2021 at 1:54 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Update save_v86_state to always complete all of it's work except
>> possibly some of the copies to userspace even if save_v86_state takes
>> a fault.  This ensures that the kernel is always in a sane state, even
>> if userspace has done something silly.
>
> Well, honestly, with this change, you might as well replace the
> force_sigsegv() with just a plain "force_sig()", and make it something
> the process can catch.

The trouble is I don't think there is enough information made available
for user space to do anything with the SIGSEGV.  My memory is that
applications like dosemu very much have a SIGSEGV handler.

So I think if it ever happened it could be quite confusing.  Not to
mention the pr_alert message.

But I guess if a test is written like you suggest we can include enough
information for someone to make sense of things.

> The only thing that "force_sigsgv()" does is to make SIGSEGV
> uncatchable. In contrast, a plain "force_sig()" just means that it
> can't be ignored - but it can be caught, and it is fatal only when not
> caught.
>
> And with the "always complete the non-vm86 state restore" part change,
> there's really no reason for it to not be caught.
>
> Of course, the other case (where we have no state information for the
> "enter vm86 mode" case) is still fatal, and is a "this should never
> happen". But the "cannot write to the vm86 save state" thing isn't
> technically fatal.
>
> It should even be possible to write a test for it: passing a read-only
> pointer to the vm86() system call. The vm86 entry will work (because
> it only reads the vm86 state from it), but then at vm86 exit, writing
> the state back will fail.
>
> Anybody?

I am enthusiastic about writing a test, but I will plod in that
direction just so I can get this sorted out.

Eric
