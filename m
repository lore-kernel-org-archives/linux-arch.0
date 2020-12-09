Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E9EC433FE
	for <linux-arch@archiver.kernel.org>; Wed,  9 Dec 2020 05:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198A223B23
	for <linux-arch@archiver.kernel.org>; Wed,  9 Dec 2020 05:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgLIFYL (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 9 Dec 2020 00:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgLIFYL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Dec 2020 00:24:11 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9FDC061793
        for <linux-arch@vger.kernel.org>; Tue,  8 Dec 2020 21:23:31 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id p4so279943pfg.0
        for <linux-arch@vger.kernel.org>; Tue, 08 Dec 2020 21:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Tqs2Bz7msoUPZyObgWN3xF+h9p+l/eCjvEQpWbPSSU=;
        b=OxsOUIM85/FYIPIB2R8Z1zNH6hhLEXdXRuOIyltjsnOhdz5a0A9+eE5h1rpwrsrPQr
         1bXqCha3Xg+zai8ciecNwe/HLZ3kOOJP34uXiIE8cSOdtq2rNDHl9X6xyg/E9r9wlBvh
         PmbqoP3V2IMQ7i2Obc87ZNu55h0VtVcejwoZzw07sPSZggoVY09+XnnId1dIIrxpBqvD
         jLrlbGRCUmCESTmyCYxcy89c+6kuLUnt/ZQYafUPlcP9pJgaTXuHm50LIKQls5hoiude
         YACweNLn3mWmGyxYsuIAPBe1LR/5D4OrYpBsn36s47Sw7LuDo+GFIB6j9dcOyrWEgeju
         FFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Tqs2Bz7msoUPZyObgWN3xF+h9p+l/eCjvEQpWbPSSU=;
        b=ImVhmY0HRadtUcHrQi8mAoXStOly/ENJYJMy5W9IttBhqGbCm0nAm8cL564K3MzLKz
         NY/o7PjHtdkj7uM8ciZiSxj2zb0UbHXZS5Jq6zwtj6/Y9vZ6YpD1+0WpbEKV1yolvH4I
         cqWA4T8lfhy84hYy1bpo06aU9Wd2yd5+ZiGTk8TI34k+2uHvpmu37/6qSb8umpwSIxXR
         LOmUV+eh3oz39snczTZplZepfSvQFCV/hGT2W/UWv1Ib0E1NBgRnOXvrN1sq3KnrrKDj
         W9WZSBsYifqSABWTfrlpS1hUrl0HvgP0yxOC7KDihhfWWi/PSINZKRMQDuxqBoqpGE/P
         Nslg==
X-Gm-Message-State: AOAM531MwZ0zl0l1kaTZSKLaEpBUPv+V+SXnHoC3OM31rZwlAmRtkGI3
        T4BQ9le8QEyNreXwKGCgSkcak974wLukxmzugkHawg==
X-Google-Smtp-Source: ABdhPJxqk+LGhDRPp0umcyl3h6fe4zAxBkF8KehhsBTBAZyCA/jdz6XKfvdMdjdIFiZftrcAFMyYhQT0xlTg5L2ZAXg=
X-Received: by 2002:a05:6a00:acc:b029:198:2ba6:c0f6 with SMTP id
 c12-20020a056a000accb02901982ba6c0f6mr782498pfl.53.1607491410514; Tue, 08 Dec
 2020 21:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
 <CAK8P3a1WEAo2SEgKUEs3SB7n7QeeHa0=cx_nO==rDK0jjDArow@mail.gmail.com>
 <CABCJKueCHo2RYfx_A21m+=d1gQLR9QsOOxCsHFeicCqyHkb-Kg@mail.gmail.com>
 <CAK8P3a1Xfpt7QLkvxjtXKcgzcWkS8g9bmxD687+rqjTafTzKrg@mail.gmail.com> <CAK8P3a3O65m6Us=YvCP3QA+0kqAeEqfi-DLOJa+JYmBqs8-JcA@mail.gmail.com>
In-Reply-To: <CAK8P3a3O65m6Us=YvCP3QA+0kqAeEqfi-DLOJa+JYmBqs8-JcA@mail.gmail.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Tue, 8 Dec 2020 21:23:18 -0800
Message-ID: <CAFP8O3L35sj117VJeE3pUPE2H4++z2g48Gfd-8Ca=CUtP1LVWw@mail.gmail.com>
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 8, 2020 at 1:02 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Dec 8, 2020 at 9:59 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > Attaching the config for "ld.lld: error: Never resolved function from
> >   blockaddress (Producer: 'LLVM12.0.0' Reader: 'LLVM 12.0.0')"
>
> And here is a new one: "ld.lld: error: assignment to symbol
> init_pg_end does not converge"
>
>       Arnd
>

This is interesting. I changed the symbol assignment to a separate
loop in https://reviews.llvm.org/D66279
Does raising the limit help? Sometimes the kernel linker script can be
rewritten to be more friendly to the linker...
