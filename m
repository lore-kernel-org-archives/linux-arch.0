Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89664C433F5
	for <linux-arch@archiver.kernel.org>; Thu, 21 Oct 2021 16:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A37161401
	for <linux-arch@archiver.kernel.org>; Thu, 21 Oct 2021 16:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhJUQjw (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:39:52 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:42986 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhJUQjt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:39:49 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:41788)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdb4N-001Jtm-KY; Thu, 21 Oct 2021 10:37:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:55830 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdb4M-00CmEw-Gn; Thu, 21 Oct 2021 10:37:31 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-14-ebiederm@xmission.com>
        <202110210925.9DEAF27CA@keescook>
Date:   Thu, 21 Oct 2021 11:37:23 -0500
In-Reply-To: <202110210925.9DEAF27CA@keescook> (Kees Cook's message of "Thu,
        21 Oct 2021 09:25:36 -0700")
Message-ID: <878rymbags.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdb4M-00CmEw-Gn;;;mid=<878rymbags.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/5uF2JtmE/Kc+XrBqzEk3qfCQQ0B1hi+U=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 14/20] exit/syscall_user_dispatch: Send ordinary signals on failure
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, Oct 20, 2021 at 12:44:00PM -0500, Eric W. Biederman wrote:
>> Use force_fatal_sig instead of calling do_exit directly.  This ensures
>> the ordinary signal handling path gets invoked, core dumps as
>> appropriate get created, and for multi-threaded processes all of the
>> threads are terminated not just a single thread.
>
> Yeah, looks good. Should be no visible behavior change.

It is observable in that an entire multi-threaded process gets
terminated instead of a single thread.  But since these events should
be handling of extra-ordinary events I don't expect there is anyone
who wants to have a thread of their process survive.

Eric

