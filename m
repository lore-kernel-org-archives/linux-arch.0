Return-Path: <SRS0=59OF=D4=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23CAC4363A
	for <linux-arch@archiver.kernel.org>; Wed, 21 Oct 2020 20:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724232417B
	for <linux-arch@archiver.kernel.org>; Wed, 21 Oct 2020 20:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kF5lPFe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505092AbgJUUJD (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 21 Oct 2020 16:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505089AbgJUUJD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Oct 2020 16:09:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23506C0613CE
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2020 13:09:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l18so2168922pgg.0
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2020 13:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QmgTEKwAstprmqCLOa3+RIlsgOb3vaDpc+a/kqXMeho=;
        b=kF5lPFe40b1By22pyNf/QSD4ROD/TqtxRsGYCI+6UAvkwJBnp0Bv7hekYoZDC4YPyh
         TuXjh9jmqmmtmR5MePoh8VDkwqjC1qIEF7FhZepb+nHrVfXKuvGAs3v6eEhHOdkTt1a9
         bSFpMSFITiNN8MPP2KQPWrwup5YiohRy88eb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QmgTEKwAstprmqCLOa3+RIlsgOb3vaDpc+a/kqXMeho=;
        b=K9Mp6VAYERYSMbFvhNXZfRWQvAqV2f+BKXf8Zl1ybhVNiYdeSprYRmx255+4Silxta
         x1ni1igO8mUN2u2/ffRZi0PxaMNlgXg/tBIvw0NlQk1X19Qxa4KQf7IR+wy4GX4wX90f
         oSs5Q1zm+LnOIpJ9LrSLzhsyiDxHvAJUxf/AK6waWkHvODqu0L4V0es37lcWbMGGgdvx
         2OnLLiIstKs5HbqWPR0phmofdWgfN+a5tYvi3XA5qtYXL+QaWJH0enzmW3yaTNlGLVRf
         I64CducnfUNYuyUwUJD7EhR5AnSG7KNrxmpLsmOKm8jDUndXg4H4MhcPSUoMeR/mp+0u
         4oiA==
X-Gm-Message-State: AOAM531qN8esC/Chsi1VigLJrua6upMRNjLxyw1u+xqfeXsaCsUz0bdw
        DtEz3xQvgmScm8lNsTLVwshnBA==
X-Google-Smtp-Source: ABdhPJwF6UJKBwTECYtqFLHEK03D4HsXg0oUtonpAoLfp1B5T3WseAaxjF8pc8BipCQz2P7yrf81yw==
X-Received: by 2002:aa7:95a6:0:b029:155:336c:3494 with SMTP id a6-20020aa795a60000b0290155336c3494mr4884846pfk.17.1603310942592;
        Wed, 21 Oct 2020 13:09:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y10sm3344623pff.119.2020.10.21.13.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 13:09:01 -0700 (PDT)
Date:   Wed, 21 Oct 2020 13:09:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: [PATCH v2] vmlinux.lds.h: Keep .ctors.* with .ctors
Message-ID: <202010211304.60EF97AF2@keescook>
References: <20201005025720.2599682-1-keescook@chromium.org>
 <202010141603.49EA0CE@keescook>
 <CAFP8O3LvTkqUK3rp9Q17fmyN+xApZXA8Cs=MNvxrZ3SDCDRX3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3LvTkqUK3rp9Q17fmyN+xApZXA8Cs=MNvxrZ3SDCDRX3A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 14, 2020 at 09:53:39PM -0700, Fāng-ruì Sòng wrote:
> On Wed, Oct 14, 2020 at 4:04 PM Kees Cook <keescook@chromium.org> wrote:
> > > index 5430febd34be..b83c00c63997 100644
> > > --- a/include/asm-generic/vmlinux.lds.h
> > > +++ b/include/asm-generic/vmlinux.lds.h
> > > @@ -684,6 +684,7 @@
> > >  #ifdef CONFIG_CONSTRUCTORS
> > >  #define KERNEL_CTORS()       . = ALIGN(8);                      \
> > >                       __ctors_start = .;                 \
> > > +                     KEEP(*(SORT(.ctors.*)))            \
> > >                       KEEP(*(.ctors))                    \
> > >                       KEEP(*(SORT(.init_array.*)))       \
> > >                       KEEP(*(.init_array))               \
> > > --
> > > 2.25.1
> 
> I think it would be great to figure out why these .ctors.* .dtors.* are generated.

I haven't had the time to investigate. This patch keeps sfr's builds
from regressing, so we need at least this first.

> ~GCC 4.7 switched to default to .init_array/.fini_array if libc
> supports it. I have some refactoring in this area of Clang as well
> (e.g. https://reviews.llvm.org/D71393)
> 
> And I am not sure SORT(.init_array.*) or SORT(.ctors.*) will work. The
> correct construct is SORT_BY_INIT_PRIORITY(.init_array.*)

The kernel doesn't seem to use the init_priority attribute at all. Are
you saying the cause of the .ctors.* names are a result of some internal
use of init_priority by the compiler here?

-- 
Kees Cook
