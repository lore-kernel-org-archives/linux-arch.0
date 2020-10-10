Return-Path: <SRS0=b7yF=DR=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD29FC433DF
	for <linux-arch@archiver.kernel.org>; Sat, 10 Oct 2020 01:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 991B221D6C
	for <linux-arch@archiver.kernel.org>; Sat, 10 Oct 2020 01:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602293754;
	bh=qYoPAseC5W8I4rPPf8IqrM+7sxuCXSHPHNB8L9vDj+o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IcD6EXUXeMzGYRKmFqV2oLmTkj5FxGAgH6SpjyprEOTSvh/B+VTnqqo/r/tw8Ufj5
	 H9Tmx4AnIFMx1TYZuYxmWeUVie9bUNqWDaf1ZMhNwx6dwCYFP0rEaJdKGXi0wv7RXW
	 nRh4QIsiRBUpUlsxOrML+CNMY8NwJL0zw8uvctoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgJJBfi (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 9 Oct 2020 21:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbgJJB3f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 21:29:35 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B25CC0613CF
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 18:29:33 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id l2so12595323lfk.0
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 18:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TL4cwcC3oy9yGXrCPN5M4+HoSQktOSj4hTD8XUaFtsk=;
        b=QUiZW7sc85a+dF87QrbXxq2KTodKggKcduyYT3bL6iRpsp3sgK+dJqXe00Rkr1oRmE
         0Q8iGj6Eoh8nHgmhwmUz1o2eQQJjkWTB80i7gsGyB9/jzaKGM86w97n/T1/Qg4RgrKKx
         Q30PjASdGXDKOZ6VrsgGinXqAdW3g6MlMxMzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TL4cwcC3oy9yGXrCPN5M4+HoSQktOSj4hTD8XUaFtsk=;
        b=Z84KguQSwopdtpg2MmzQBIkwOxf2YzhvmHfv8eP0aOe1yAS8BRcB3FkVj2UPu3eB/P
         zdgd2KKG2f/bsMofbNBcmUxB2KSm4dGKCgNyEZqrcUGe2avD7fTnghIx6xO2aUGvxO9d
         HbRIXgjcQ4AIQf3Lrd57FbnuOBCiMmVuu03tgEgFHzoUUi1lJGH6zGhHs04Eldcqf3Zy
         X1yDeW7VzGIUaJSvJNK/+2Ku/5pNHr9SI/6ayD04G7GdcIbELNg2lDnWPZfIJcv430mf
         p7HxlgVsi51vPaVy7EWtZqqes+VSrNwlTFC032YnjzhQSyXu1YGvjpENSH4Ovl4qlwrX
         O+Qg==
X-Gm-Message-State: AOAM5339YlhqfJOhfdD8WQu0xa0qGW/WXg6SyMHErdWrMD853jtJ1OAF
        2Ss3A+KDLRBNB9zjqAYWNvldJbDBH0IcPg==
X-Google-Smtp-Source: ABdhPJwputa92Egfby4yhTNYlIY+cGw04VXr4EYJ3ZorCb8zT7EWBL7AVsC4Sh3mlGCV27nVbU0JzQ==
X-Received: by 2002:ac2:4c88:: with SMTP id d8mr5419981lfl.445.1602293370889;
        Fri, 09 Oct 2020 18:29:30 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id i63sm96292lfi.53.2020.10.09.18.29.29
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 18:29:29 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id i2so11305595ljg.4
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 18:29:29 -0700 (PDT)
X-Received: by 2002:a2e:9152:: with SMTP id q18mr5731594ljg.421.1602293368914;
 Fri, 09 Oct 2020 18:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de> <20200903142242.925828-6-hch@lst.de>
 <20201001223852.GA855@sol.localdomain> <20201001224051.GI3421308@ZenIV.linux.org.uk>
 <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com>
 <20201009220633.GA1122@sol.localdomain> <CAHk-=whcEzYjkqdpZciHh+iAdUttvfWZYoiHiF67XuTXB1YJLw@mail.gmail.com>
 <20201010011919.GC1122@sol.localdomain>
In-Reply-To: <20201010011919.GC1122@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Oct 2020 18:29:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigvcmp-jcgoNCbx45W7j3=0jA320CfpskwuoEjefM7nQ@mail.gmail.com>
Message-ID: <CAHk-=wigvcmp-jcgoNCbx45W7j3=0jA320CfpskwuoEjefM7nQ@mail.gmail.com>
Subject: Re: [PATCH 05/14] fs: don't allow kernel reads and writes without
 iter ops
To:     Eric Biggers <ebiggers@kernel.org>,
        Alexander Viro <aviro@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 9, 2020 at 6:19 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Okay, that makes more sense.  So the patchset from Matthew
> https://lkml.kernel.org/linux-fsdevel/20201003025534.21045-1-willy@infradead.org/T/#u
> isn't what you had in mind.

No.

That first patch makes sense - it's just the "ppos can be NULL" patch.

But as mentioned, NULL isn't "shorthand for zero". It's just "pipes
don't _have_ a pos, trying to pass in some explicit position is
crazy".

So no, the other patches in that set are a bit odd, I think.

SOME of them look potentially fine - the bpfilter one seems to be
valid, for example, because it's literally about reading/writing a
pipe. And maybe the sysctl one is similarly sensible - I didn't check
the context of that one.

But no, NULL shouldn't mean "start at position zero, and we don't care
about the result".

              Linus
