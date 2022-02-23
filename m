Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C55C433F5
	for <linux-arch@archiver.kernel.org>; Wed, 23 Feb 2022 20:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241353AbiBWUls (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 23 Feb 2022 15:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiBWUls (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 15:41:48 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7D24D9E1
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 12:41:18 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cm8so25168edb.3
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 12:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qFhEoMfG9JnrMiuxRlHG2UuQZfxYUHHdzjSkeWsOcD8=;
        b=Sch0qA/uMUHSX7lm1Z26E01aFQIda35gcyPmVMGmgg/B0iK1poWZ5N+Iv8pmlRuBJ/
         hmD9WSqMPQCsXSmydxbzVzOjygUon9SlqLsP2d/yUlh2jZBB1LkXkBDyjE9WCuOkIIhk
         VJJ5eZOA1/ScB6KVCbfKtnEVHGsuTIFbkykeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qFhEoMfG9JnrMiuxRlHG2UuQZfxYUHHdzjSkeWsOcD8=;
        b=FgQSNWVJlEN4l715jhpB4A8kB59qZyubh+pP8xZXyTleKUmSIXn3yz373n+rLTwlSm
         iD2YluK9ofQTnRGDku6z/bpTfov/zVqSPVfmT6OP5wKH6M+4LKfIj7YtY8NVPYXlgxgY
         LeXsdOJe7B0KdpdAfT2y3EkgVK6Vwrte/gq9LrMhZV0YWOWAoCJmOszHgnyxxT+vK81Q
         ORb6/0BBbQ2kyVPMIeul5ZehUISJJuXgotJWolwQzkDo+xhDf1PTAudTZno9OTJch5tK
         HNJ+/TjUjJCZxQZQwLUpBVmGzPCfUIPpsMRok58+LtTHTfXcDprUAcEOBDj6cSgm85It
         GD8g==
X-Gm-Message-State: AOAM531q8jbJtSu0W5hS4xjCuVg7d1oVGduEHB4Z1c7TZb/l14bSXxTO
        z8fv24Lriww911M9dcxtLW6FLwfUHakIrr+sMig=
X-Google-Smtp-Source: ABdhPJwiBrlvJMSDh/DCq7p57BA9gl+CCN1daE5DI5IFBTmYOKvgkpccJ/wH2veTTwR09Qzn/qZGYg==
X-Received: by 2002:a05:6402:4305:b0:410:d56e:efe3 with SMTP id m5-20020a056402430500b00410d56eefe3mr1142010edc.440.1645648877325;
        Wed, 23 Feb 2022 12:41:17 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 16sm290416eji.94.2022.02.23.12.41.17
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 12:41:17 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a8so55116700ejc.8
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 12:41:17 -0800 (PST)
X-Received: by 2002:ac2:5313:0:b0:443:99c1:7e89 with SMTP id
 c19-20020ac25313000000b0044399c17e89mr825261lfh.531.1645648474572; Wed, 23
 Feb 2022 12:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-5-jakobkoschel@gmail.com> <20220218151216.GE1037534@ziepe.ca>
 <6BA40980-554F-45E2-914D-5E4CD02FF21C@gmail.com> <CAHk-=wir=xabJ73Upk1dsuoMKWTTjTfeLFJ=p2S0yRYYaxW4fA@mail.gmail.com>
 <20220223191222.GC10361@ziepe.ca> <CAHk-=widDQUjQS2tpaw3j_+Yz8rAY3P0qdqpz+nTNu4-3LaU3w@mail.gmail.com>
 <5a476b24-0f34-91d4-84a4-699e8c374abe@rasmusvillemoes.dk>
In-Reply-To: <5a476b24-0f34-91d4-84a4-699e8c374abe@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Feb 2022 12:34:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whpK93+mF8CPJZo0KxDeHrV2GL05=HT7=y+GnhcNbNyUA@mail.gmail.com>
Message-ID: <CAHk-=whpK93+mF8CPJZo0KxDeHrV2GL05=HT7=y+GnhcNbNyUA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/13] vfio/mdev: remove the usage of the list
 iterator after the loop
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 23, 2022 at 12:19 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> I have often wished that the iterator macros would consistently set the
> loop variable to NULL upon reaching the end.

I really think the rule should be that to a 99% approximation, we
should strive only ever use the iterated-upon value *inside* the loop.

No, that's now how we do it now. But I think the "break out and do the
work outside the loop" case is kind of broken anyway. It makes you
test the condition twice - and while a compiler might be smart enough
to optimize the second test away, it's still just plain ugly.

             Linus
