Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F40C54EE9
	for <linux-arch@archiver.kernel.org>; Sat, 17 Sep 2022 02:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiIQCUl (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 16 Sep 2022 22:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIQCUk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2022 22:20:40 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8395AA1E
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2022 19:20:38 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id u189so24481297vsb.4
        for <linux-arch@vger.kernel.org>; Fri, 16 Sep 2022 19:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oGVwvUbROocDCKmIi63dwILH5RW1QiYjDieu+3HIGsc=;
        b=p4xe7FkTwPfgqVWHMfckvfXbZ74PEfbA+zGhE3mwURum3Wtwo6VikqJgSAObdpAFke
         MHgaf3cMGbcsp7NKYQST+kgVWi7QA/7EfeeoGpttq5en4rUxgqRWjbhB3n/S//vgR2uv
         S6WlzAYbgM9x6YRypeUAifzcU+4agyXG2WIF5YjQTmbFQQQ9PuFPqhCcTxCqC21V8Oma
         fehUSROGSD31s8uKBl1as5duo/aDD+hrtnyxHZxLITS42/VP+0byTiZn/qi2IZK9QjXQ
         G0LgZLpYHmcT0na0Uoui2L7qNB6jaNUt1Ej0X2zNAazPs/ALCYW+dn5M3uVKopRR+64h
         qv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oGVwvUbROocDCKmIi63dwILH5RW1QiYjDieu+3HIGsc=;
        b=awd1Q1ln5zqxarwIqXp1wV1DI0dVJ3+j6gVtM7rN+POJsH5Ob28vzA3JWzu4BQtFQr
         bMAquSfuZMFWr0t/dHD2m2Kyr9TSDUzsFRME4NFbO+iB2ZkfwJ+VbTiXhbCsZVieRv/8
         ctf9+cpfMKZVNtBH/LGlfnHICpzH9R5wRoBLPSf1DvdI/6O+tD7apml7SFrx59oK1fYu
         XzQ/WJRu8BXyojGMyzcFjKo3wGkgDIlYQUdzXHR7EXXLpjDDzIO1VlzfIi3JVWVTtZNV
         g4DcxKQCmCefABa+AR3nmOcIWwnGe+n0pmIaw/bsInZPzsUjgoL8x0rXQamz3NebL8oT
         KIyQ==
X-Gm-Message-State: ACrzQf0LLzfkx+l+spOwGwYnzJ+86i9o5ma0ioaF+y95+Kk4rES9W+yV
        NzWN0A91vZaSrqQuSeeKSZNzqkGB7/d3QKfMOx/nPw==
X-Google-Smtp-Source: AMsMyM5q6QRJAwXaZJ4XFbVgFggwa1+pamVcYJuzMq6iNMYJMIVWBOPdicQlAri+7OMdOIMIErnmt4nZD65EK0hktVA=
X-Received: by 2002:a67:ed55:0:b0:39a:7942:f574 with SMTP id
 m21-20020a67ed55000000b0039a7942f574mr3217830vsp.65.1663381237345; Fri, 16
 Sep 2022 19:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220916135953.1320601-1-keescook@chromium.org>
In-Reply-To: <20220916135953.1320601-1-keescook@chromium.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 16 Sep 2022 20:20:00 -0600
Message-ID: <CAOUHufbUUf1--=qiseAYzjN2DdyCkf_x=CQboWYDduH7VgpXmQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] x86/dumpstack: Inline copy_from_user_nmi()
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, dev@der-flo.net,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-perf-users@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-hardening@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 16, 2022 at 8:01 AM Kees Cook <keescook@chromium.org> wrote:
>
> Hi,
>
> This fixes a find_vmap_area() deadlock. The main fix is patch 2, repeated here:
>
>     The check_object_size() helper under CONFIG_HARDENED_USERCOPY is
>     designed to skip any checks where the length is known at compile time as
>     a reasonable heuristic to avoid "likely known-good" cases. However, it can
>     only do this when the copy_*_user() helpers are, themselves, inline too.
>
>     Using find_vmap_area() requires taking a spinlock. The check_object_size()
>     helper can call find_vmap_area() when the destination is in vmap memory.
>     If show_regs() is called in interrupt context, it will attempt a call to
>     copy_from_user_nmi(), which may call check_object_size() and then
>     find_vmap_area(). If something in normal context happens to be in the
>     middle of calling find_vmap_area() (with the spinlock held), the interrupt
>     handler will hang forever.
>
>     The copy_from_user_nmi() call is actually being called with a fixed-size
>     length, so check_object_size() should never have been called in the
>     first place. In order for check_object_size() to see that the length is
>     a fixed size, inline copy_from_user_nmi(), as already done with all the
>     other uaccess helpers.
>
>     Reported-by: Yu Zhao <yuzhao@google.com>
>     Link: https://lore.kernel.org/all/CAOUHufaPshtKrTWOz7T7QFYUNVGFm0JBjvM700Nhf9qEL9b3EQ@mail.gmail.com
>     Reported-by: dev@der-flo.net
>
> Patch 1 is a refactor for patch 2, and patch 3 should make sure we avoid
> future deadlocks.

Thanks!

Tested-by: Yu Zhao <yuzhao@google.com>

The same test has been holding up well for a few hours now. It used to
throw that warning in less than half an hour.
