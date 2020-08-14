Return-Path: <SRS0=bFu9=BY=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F110C433DF
	for <linux-arch@archiver.kernel.org>; Fri, 14 Aug 2020 11:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73ACB207DA
	for <linux-arch@archiver.kernel.org>; Fri, 14 Aug 2020 11:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hu6Nw7Hu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgHNL7V (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgHNL7U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Aug 2020 07:59:20 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3276AC061384
        for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2020 04:59:20 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 93so7363881otx.2
        for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2020 04:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JH6kRqU1JrNcyy+wqdaUc+Qi4AywqVy9VYsywI2jKC4=;
        b=Hu6Nw7Hu8gfRjU0uxCY5ypd0wl/SaFstId/H02InWTfOh1qjNcvA7OEJQlw3IhBFYB
         ZbDdyVhOAJfmgJPLz3PmRAehofZkwiWforKlGlPfVZQIxs3eCEuX4V2gDHWHM3H641P9
         5/95uaTUUeEsQV99+U2SeqIJMG+fs5/ppn/EFQP55KtLY079BqtlK164t0WVWA5OqFb5
         1lDfFXlAbAxHW6RF3Iwt9D61belaN+pbNqJ2YQHi6R4ezzBMyWU1/2akcilZkTOMaK+x
         9NcEVvBOT/kpSK5KK9wGBG+pRvyZhrhPX+tolqxoNe1i5ESpRXzLfnkuMa1GsLGkrNPc
         yiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JH6kRqU1JrNcyy+wqdaUc+Qi4AywqVy9VYsywI2jKC4=;
        b=FfahEn2Vf7RGdvlUeRWYBQXAWhfiwK3vF30hL5V/ftcLWNrpyOshFWDUmgi5QImGnp
         LSKgF84TIWizQGwoEV7osPWU2ngS5o+amMVXXgjCu1h+HmA9wsQPE5fRpi+XiAjjOw4w
         soyQFaXFc0XthwObH0jM490eBzX5DWoaxrYI2wz5STM3RCoNM+jOASG/6TBw3GfnEYa9
         dAo1ZvB0eMDzO9dodR9udUbyiQssYqj7uqkHeWpANRZd+J3dGvwyccgaUlUAnaLtPhaO
         u2AKMFXIuzn5nJDYhbhjf0K3bdn/VebxHypz1alAdYQtCrf9ACb2iahiLm2XBcTr03HK
         /bsA==
X-Gm-Message-State: AOAM530hKoGo4pboK+1cTD6VAbwnxWhHKQ4Ceh5cTMcxK1WEJ+lUrhRW
        nyVm7no5EVpyExoOw9OpKr9Pdmiu1sbYSwBEVh224Q==
X-Google-Smtp-Source: ABdhPJxPPgMpYvrWwruSOJ6rg0e4RTwqBnrs8Barm0/v/AauhxO/vwMhNciGBE2/TazprcJkQc2m1wlC4NQSO0JC60I=
X-Received: by 2002:a05:6830:1612:: with SMTP id g18mr1480092otr.251.1597406359387;
 Fri, 14 Aug 2020 04:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200721103016.3287832-1-elver@google.com> <20200721103016.3287832-9-elver@google.com>
 <20200721141859.GC10769@hirez.programming.kicks-ass.net> <CANpmjNM6C6QtrtLhRkbmfc3jLqYaQOvvM_vKA6UyrkWadkdzNQ@mail.gmail.com>
 <20200814112826.GB68877@C02TD0UTHF1T.local> <20200814113149.GC68877@C02TD0UTHF1T.local>
In-Reply-To: <20200814113149.GC68877@C02TD0UTHF1T.local>
From:   Marco Elver <elver@google.com>
Date:   Fri, 14 Aug 2020 13:59:08 +0200
Message-ID: <CANpmjNNXXMXMBOqJqQTkDDoavggDVktNL6AZn-hLMbEPYzZ_0w@mail.gmail.com>
Subject: Re: [PATCH 8/8] locking/atomics: Use read-write instrumentation for
 atomic RMWs
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 14 Aug 2020 at 13:31, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Aug 14, 2020 at 12:28:26PM +0100, Mark Rutland wrote:
> > Hi,
> >
> > Sorry to come to this rather late -- this comment equally applies to v2
> > so I'm replying here to have context.
>
> ... and now I see that was already applied, so please ignore this!

Thank you for the comment anyway. If this is something urgent, we
could send a separate patch to change.

My argument in favour of keeping it as-is was that the alternative
would throw away the "type" and we no longer recognize a difference
between arguments (in fairness, currently not important though). If,
say, we get an RMW that has a constant argument though, the current
version would do the "right thing" as far as I can tell. Maybe I'm
overly conservative here, but it saves us worrying about some future
use-case breaking this more than before.

Thanks,
-- Marco
