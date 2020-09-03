Return-Path: <SRS0=8TOP=CM=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBCDC43461
	for <linux-arch@archiver.kernel.org>; Thu,  3 Sep 2020 23:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BC52084D
	for <linux-arch@archiver.kernel.org>; Thu,  3 Sep 2020 23:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599175577;
	bh=YN64hnHu+sspWvZwzTcYjF6KKEJjiaTwL+xMgbaoqpM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0w+kNXhhDjZ8gChk53PtFmjZDAbbFNwTnM1JQKfFpfRvRq257zKD7sZcW9axsP82T
	 6P8STxWd6cOjy95mBec0qF0titLDVPRxDe2YNm44Fr7KCChcU4o0fq9YGweAfIyBXx
	 fz6bFfdAeJySj5grzd5LwvjIYJ+wMz8Tmc2Nhl0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgICX0R (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 3 Sep 2020 19:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgICX0P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 19:26:15 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE4BC061244
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 16:26:14 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s205so5767012lja.7
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eoc+5mie1+ZuNTuaPcGzSI2qJ6owz7A4Ofr10ghZJJ4=;
        b=gWGJKo5xiJNWPTtwqGkQlOlOwg3GjNMHWAbbLf6G2umLeN+ziH7HLU4o7mqfu6xrQX
         0nqy/1qDWFPlTHlbUl4hIrosGA73uytx27UrMGezo0ol7EOlqSXT8KqCo6mWmcDs1cwA
         at576v5S6IW6A1SwuGUswjPYeT1mwL3S6Pfko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eoc+5mie1+ZuNTuaPcGzSI2qJ6owz7A4Ofr10ghZJJ4=;
        b=dwDe33xvCOAph4SPEpgdm6/5VpY99IC8uVISkMKazumx8Y3b6Vi1Lpo+bhyCRWWwdC
         7u5SDn6vMDjLyWRdaI1Nsqrl9SYO8JEAgFhNfvum9Dbp4hqJraWdYFzdlPRnakqG2C6f
         Ah6G54Y1hPvq6mKMYVOGxuWBYqWsS8MpW6gJnzxseJbDwDWydsb9ZaUPYn+yq2axLqY4
         4LVNxLIsRH8QsLx6c1aJ2rQgMLY7HrhR+kId1E6ccyanlxo633848dusp//rWrrhr98v
         hxL/pNWi2qXgVaUkJDDeNvb++m6h1VVYmpB6+cMyj16jV13jpNePqt2Atg6jFFqKYoFi
         Qd/Q==
X-Gm-Message-State: AOAM532E5k5WTzSF8IQuEKiG5Nsfx87VLsi8Jr0AP09NTSMC+C4QcOvw
        JJm3PVEBr86SsH/UcNlL2ieznMfD8uEEeQ==
X-Google-Smtp-Source: ABdhPJwhyr+xE9pE2UXNbv4kIBGQB77/TLwZ4jb1CLB48pxQFntZWXlvfwjOxVxAE1OMMZX2hzr9sg==
X-Received: by 2002:a2e:b4ba:: with SMTP id q26mr2191480ljm.79.1599175572778;
        Thu, 03 Sep 2020 16:26:12 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id g63sm896945lfd.28.2020.09.03.16.26.10
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 16:26:11 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id c15so2867151lfi.3
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 16:26:10 -0700 (PDT)
X-Received: by 2002:a19:4a88:: with SMTP id x130mr2429205lfa.31.1599175570612;
 Thu, 03 Sep 2020 16:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de> <20200903142242.925828-13-hch@lst.de>
 <9ab40244a2164f7db2ff0c1d23ab59a0@AcuMS.aculab.com>
In-Reply-To: <9ab40244a2164f7db2ff0c1d23ab59a0@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Sep 2020 16:25:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDtnudkbZ8-hR8HiDE7zog0dv+Gu9Sx5i6SPakrDtajQ@mail.gmail.com>
Message-ID: <CAHk-=whDtnudkbZ8-hR8HiDE7zog0dv+Gu9Sx5i6SPakrDtajQ@mail.gmail.com>
Subject: Re: [PATCH 12/14] x86: remove address space overrides using set_fs()
To:     David Laight <David.Laight@aculab.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "x86@kernel.org" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 3, 2020 at 2:30 PM David Laight <David.Laight@aculab.com> wrote:
>
> A non-canonical (is that the right term) address between the highest
> valid user address and the lowest valid kernel address (7ffe to fffe?)
> will fault anyway.

Yes.

But we actually warn against that fault, because it's been a good way
to catch places that didn't use the proper "access_ok()" pattern.

See ex_handler_uaccess() and the

        WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in
user access. Non-canonical address?");

warning. It's been good for randomized testing - a missing range check
on a user address will often hit this.

Of course, you should never see it in real life (and hopefully not in
testing either any more). But belt-and-suspenders..

              Linus
