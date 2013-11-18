From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/3] set_dumpable: fix the theoretical race with itself
Date: Mon, 18 Nov 2013 08:36:48 -0800
Message-ID: <CAGXu5jK1mqQzrHodkMNqQD5jMs164=nMB27KKpUyWePnjo5pSw@mail.gmail.com>
References: <20131101232521.GA23119@www.outflux.net>
	<20131114170337.GA11068@redhat.com>
	<CAGXu5jLXpLqjCAMFwKp7t7GpMq4+WBqNzSFC=up+CBvgGDuFCw@mail.gmail.com>
	<20131115203652.GA13476@redhat.com>
	<CAGXu5j+=LZYAczLVawGPAxd=9VX1FupWZq+2858GsrD1YprL3w@mail.gmail.com>
	<20131116190057.GA22666@redhat.com>
	<20131116190121.GB22666@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:37127 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab3KRQgs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 Nov 2013 11:36:48 -0500
Received: by mail-ob0-f178.google.com with SMTP id va2so7209822obc.37
        for <linux-arch@vger.kernel.org>; Mon, 18 Nov 2013 08:36:48 -0800 (PST)
In-Reply-To: <20131116190121.GB22666@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "security@kernel.org" <security@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Vasily Kulikov <segoon@openwall.com>, Petr Matousek <pmatouse@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Alex Kelly <alex.page.kelly@gmail.com>, Josh Triplett <josh@joshtriplett.org>

On Sat, Nov 16, 2013 at 11:01 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> set_dumpable() updates MMF_DUMPABLE_MASK in a non-trivial way to
> ensure that get_dumpable() can't observe the intermediate state,
> but this all can't help if multiple threads call set_dumpable()
> at the same time.
>
> And in theory commit_creds()->set_dumpable(SUID_DUMP_ROOT) racing
> with sys_prctl()->set_dumpable(SUID_DUMP_DISABLE) can result in
> SUID_DUMP_USER.
>
> Change this code to update both bits atomically via cmpxchg().
>
> Note: this assumes that it is safe to mix bitops and cmpxchg. IOW,
> if, say, an architecture implements cmpxchg() using the locking
> (like arch/parisc/lib/bitops.c does), then it should use the same
> locks for set_bit/etc.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

I can't speak to the bitops/cmpxchg, but the rest looks fine to me.

Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
