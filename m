Return-Path: <SRS0=59OF=D4=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1490C4363A
	for <linux-arch@archiver.kernel.org>; Wed, 21 Oct 2020 22:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2443424248
	for <linux-arch@archiver.kernel.org>; Wed, 21 Oct 2020 22:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EFuen1JP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506698AbgJUW3d (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:29:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52284 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506697AbgJUW3d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 18:29:33 -0400
Received: from zn.tnic (p200300ec2f0c9a000363ca1046998683.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9a00:363:ca10:4699:8683])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 276351EC01A8;
        Thu, 22 Oct 2020 00:29:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603319372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zQJz30b30fEvcR2ms1ObL7VDhJR2lPmGmg0uC+VZ6/s=;
        b=EFuen1JP/qoOVJ9AcCCKqQvas6QY00u5swOEOfLuWc+IPmT46TY/ZNrMYO1ipF3FAvxX8h
        EOyRDxXauI5BhqujXNC5BB9FLQZ8kxdHh36bHWtGEVV/qFgX7OZwaR7uFkySH6gsq2LHQF
        RbG+mq2detWIkjaEXsKrc97rrO0mnEA=
Date:   Thu, 22 Oct 2020 00:29:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vmlinux.lds.h: Keep .ctors.* with .ctors
Message-ID: <20201021222926.GE4050@zn.tnic>
References: <20201005025720.2599682-1-keescook@chromium.org>
 <202010211303.4F8386F2@keescook>
 <20201021222215.GC4050@zn.tnic>
 <202010211523.EC217C9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202010211523.EC217C9@keescook>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 03:25:06PM -0700, Kees Cook wrote:
> It was a fix for the series Ingo took, so I seemed sensible to keep it
> together. Though at this point, I don't care who takes it. :)

That series is upstream already, I presume. And then it probably doesn't
matter who takes it...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
