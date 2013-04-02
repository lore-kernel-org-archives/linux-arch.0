Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:42909 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761467Ab3DBRa6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Apr 2013 13:30:58 -0400
Received: by mail-ia0-f171.google.com with SMTP id z13so523764iaz.30
        for <linux-arch@vger.kernel.org>; Tue, 02 Apr 2013 10:30:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364921954.20640.22.camel@laptop>
References: <20130228102452.15191.22673.stgit@patser>
	<20130228102502.15191.14146.stgit@patser>
	<1364900432.18374.24.camel@laptop>
	<515AF1C1.7080508@canonical.com>
	<1364921954.20640.22.camel@laptop>
Date: Tue, 2 Apr 2013 19:30:57 +0200
Message-ID: <CAKMK7uHPtR1m_GYTH2xmnfo-rCJUCvz3_ci40jp9zOWTNpzsvw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mutex: add support for reservation style locks, v2
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Maarten Lankhorst <maarten.lankhorst@canonical.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, robclark@gmail.com, tglx@linutronix.de, mingo@elte.hu, linux-media@vger.kernel.org
Message-ID: <20130402173057.N2ANibmgA7E8Qru1439H05_ub9Uyh1y3OOhfwp-ozcs@z>

On Tue, Apr 2, 2013 at 6:59 PM, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
>> > Also, is there anything in CS literature that comes close to this? I'd
>> > think the DBMS people would have something similar with their
>> > transactional systems. What do they call it?
>
>> I didn't study cs, but judging from your phrasing I guess you mean you
>> want me to call it transaction_mutexes instead?
>
> Nah, me neither, I just hate reinventing names for something that's
> already got a perfectly fine name under which a bunch of people know
> it.
>
> See the email from Daniel, apparently its known as wound-wait deadlock
> avoidance -- its actually described in the "deadlock" wikipedia
> article.
>
> So how about we call the thing something like:
>
>   struct ww_mutex; /* wound/wait */
>
>   int mutex_wound_lock(struct ww_mutex *); /* returns -EDEADLK */
>   int mutex_wait_lock(struct ww_mutex *);  /* does not fail */

I'm not sold on this prefix, since wound-wait is just the
implementation detail of how it detects/handles deadlocks. For users a
really dumb strategy of just doing a mutex trylock and always
returning -EAGAIN if that fails (together with a msleep(rand) in the
slowpath) would have the same interface. Almost at least, we could
ditch the ticket - but the ticket is used as a virtual lock for the
lockdep annotation, so ditching it would also reduce lockdep
usefulness (due to all those trylocks). So in case we ever switch the
deadlock/backoff algo ww_ would be a bit misleading.

Otoh reservation_ is just what it's used for in graphics-land, so not
that much better. I don't really have a good idea for what this is
besides mutexes_with_magic_deadlock_detection_and_backoff. Which is a
bit long.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
