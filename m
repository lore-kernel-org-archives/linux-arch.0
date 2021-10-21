Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75988C433EF
	for <linux-arch@archiver.kernel.org>; Thu, 21 Oct 2021 17:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A5E60FF2
	for <linux-arch@archiver.kernel.org>; Thu, 21 Oct 2021 17:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhJURFP (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 21 Oct 2021 13:05:15 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:40282 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbhJURFP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 13:05:15 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:59376)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdbT0-005fTo-ML; Thu, 21 Oct 2021 11:02:58 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:57008 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdbSy-00CpzD-L6; Thu, 21 Oct 2021 11:02:58 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, H Peter Anvin <hpa@zytor.com>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-10-ebiederm@xmission.com>
        <202110210915.BF17C14980@keescook>
Date:   Thu, 21 Oct 2021 12:02:49 -0500
In-Reply-To: <202110210915.BF17C14980@keescook> (Kees Cook's message of "Thu,
        21 Oct 2021 09:16:02 -0700")
Message-ID: <87r1ce8g5i.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdbSy-00CpzD-L6;;;mid=<87r1ce8g5i.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+4tFpR82thOj+XqsfADzJzogO4+LK+nWA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 10/20] signal/vm86_32: Properly send SIGSEGV when the vm86 state cannot be saved.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, Oct 20, 2021 at 12:43:56PM -0500, Eric W. Biederman wrote:
>> Instead of pretending to send SIGSEGV by calling do_exit(SIGSEGV)
>> call force_sigsegv(SIGSEGV) to force the process to take a SIGSEGV
>> and terminate.
>> 
>> Update handle_signal to return immediately when save_v86_state fails
>> and kills the process.  Returning immediately without doing anything
>> except killing the process with SIGSEGV is also what signal_setup_done
>> does when setup_rt_frame fails.  Plus it is always ok to return
>> immediately without delivering a signal to a userspace handler when a
>> fatal signal has killed the current process.
>
> Do the tools/testing/selftests/x86 tests all pass after these changes? I
> know Andy has a bunch of weird corner cases in there.

That would require a 32bit userspace wouldn't it?

It is a good idea so I will see if I can dig such a box up, but I
unfortunately don't have an up-to-date 32bit box handy, or even
an up-to-date box with a 32bit userspace.

It has been about 20 years since I have done much with 32bit x86.

How hard is it to run the tests under tools/testing/selftests/...
Last time I tried it was a royal pain.  I am hoping it is better this
round.

Eric
