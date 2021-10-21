Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2C6C433F5
	for <linux-arch@archiver.kernel.org>; Thu, 21 Oct 2021 16:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5531760E90
	for <linux-arch@archiver.kernel.org>; Thu, 21 Oct 2021 16:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJUQgI (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:36:08 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:42240 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhJUQgI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:36:08 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:55016)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdb0p-001JO8-F1; Thu, 21 Oct 2021 10:33:51 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:55474 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdb0o-0046Sd-Hn; Thu, 21 Oct 2021 10:33:51 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-13-ebiederm@xmission.com>
        <202110210923.F5BE43C@keescook>
Date:   Thu, 21 Oct 2021 11:33:43 -0500
In-Reply-To: <202110210923.F5BE43C@keescook> (Kees Cook's message of "Thu, 21
        Oct 2021 09:24:22 -0700")
Message-ID: <87ilxqbamw.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdb0o-0046Sd-Hn;;;mid=<87ilxqbamw.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+xXdKU+id/xvXMlErdVtLQeZqNpQrNeoU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 13/20] signal: Implement force_fatal_sig
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, Oct 20, 2021 at 12:43:59PM -0500, Eric W. Biederman wrote:
>> This is interesting both because it makes force_sigsegv simpler and
>> because there are a couple of buggy places in the kernel that call
>> do_exit(SIGILL) or do_exit(SIGSYS) because there is no straight
>> forward way today for those places to simply force the exit of a
>> process with the chosen signal.  Creating force_fatal_sig allows
>> those places to be implemented with normal signal exits.
>
> I assume this is talking about seccomp()? :) Should a patch be included
> in this series to change those?

Actually it is not talking about seccomp.  As far as I can tell seccomp
is deliberately only killing a single thread when it calls do_exit.

I am thinking about places where we really want the entire process to
die and not just a single thread.  Please see the following changes
where I actually use force_fatal_sig.

Eric
