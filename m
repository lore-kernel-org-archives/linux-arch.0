Return-Path: <SRS0=b863=CF=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416BFC433E1
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 18:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D272087C
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598551610;
	bh=6QltA7bFHSSY80S0oagTuUAAGfxrCWlRjC5dY1Zu3mA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=E9d7R3htXLPMhC7BuxQOQEM5RlBBXggQq3Hjw5WSmjOQlbqry7WYJGrl07X5zbFTN
	 TA+ypfM2xL6qVXRV1ZZ8kPbbpX5aIRiMajKjk1xuM464QNW9PitPXXy3ecYPD1yILi
	 VOiRxeF7EHs7GeN5ggk2pYvSdvUa553yseuz0qnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgH0SGs (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgH0SGs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 14:06:48 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17E7C061264
        for <linux-arch@vger.kernel.org>; Thu, 27 Aug 2020 11:06:47 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 185so7452587ljj.7
        for <linux-arch@vger.kernel.org>; Thu, 27 Aug 2020 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7U2YQUo5PvChApZK/cKK/V+bD5P2TFvYUwUUfL3IKr8=;
        b=V+YFpBqcArUu/7w7NBd4zYiujYYZd0XbXg3pMzUSnwQHkdzIY7nP3mP+VimDcTthyi
         LlD3xPgdurxv9ctSZwPOT/zU/BV4vftgYTphIZCwjwJtNjyaIwWnhXCoLDg9QLVljgtJ
         MDCUHybVVKKZURhQ+X8r3p5PJ1lUGBFZYBCuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7U2YQUo5PvChApZK/cKK/V+bD5P2TFvYUwUUfL3IKr8=;
        b=XOMNf6sZaaCnWJOwHWY9CbiQIWmCRu4ud6x2JQeL3YGkZMddrNMFtozvFbdLobLiAZ
         /6AB4FM78CM58AJWreyyO92bHdSpwQPJpyRyK2E2ONk1be6VnWBQTw4plaZNHavyaMup
         mc1fJbPZQnJxeuC43jXStASUC4ZNcxyevygbNgUru79qnWzm697mzxaAjV3Kmzx7wSDS
         Jn169IMPKlFU4bSVwgjT+lj1Sp7PrwqvQODquXTv+dBUN5Tr+XKu389/7nB8H7mX7mT4
         AzbNc6C02ZAYTpXELnd5ZzOlJbDMdFYjb0BX6TzNe4WEtW2sLes1tO3bvLVrqVbnsCji
         vFmg==
X-Gm-Message-State: AOAM530saBsnL+5ntg1KiXSqd4yt7ikx4ezz4c4JC6hrLJHmoRilDuHI
        hsOhyMjYR3TON7t0+JWGLHN8vC0yCX23Jw==
X-Google-Smtp-Source: ABdhPJzllLeM1XnkOaTbuZXmty1o8H9SxLW37yp2+6mU99VAZI0KmSw6BTu+wIGHFSbC7QPHNEtKxw==
X-Received: by 2002:a2e:9913:: with SMTP id v19mr9823355lji.292.1598551606162;
        Thu, 27 Aug 2020 11:06:46 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id y28sm682934lfl.15.2020.08.27.11.06.45
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 11:06:45 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 12so3407438lfb.11
        for <linux-arch@vger.kernel.org>; Thu, 27 Aug 2020 11:06:45 -0700 (PDT)
X-Received: by 2002:a05:6512:50c:: with SMTP id o12mr3180051lfb.192.1598551604725;
 Thu, 27 Aug 2020 11:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200827150030.282762-1-hch@lst.de> <20200827150030.282762-6-hch@lst.de>
In-Reply-To: <20200827150030.282762-6-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 11:06:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipbWD66sU7etETXwDW5NRsU2vnbDpXXQ5i94hiTcawyw@mail.gmail.com>
Message-ID: <CAHk-=wipbWD66sU7etETXwDW5NRsU2vnbDpXXQ5i94hiTcawyw@mail.gmail.com>
Subject: Re: [PATCH 05/10] lkdtm: disable set_fs-based tests for !CONFIG_SET_FS
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 8:00 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Once we can't manipulate the address limit, we also can't test what
> happens when the manipulation is abused.

Just remove these tests entirely.

Once set_fs() doesn't exist on x86, the tests no longer make any sense
what-so-ever, because test coverage will be basically zero.

So don't make the code uglier just to maintain a fiction that
something is tested when it isn't really.

                 Linus
