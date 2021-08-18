Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC4AC4338F
	for <linux-arch@archiver.kernel.org>; Wed, 18 Aug 2021 11:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D9861058
	for <linux-arch@archiver.kernel.org>; Wed, 18 Aug 2021 11:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhHRLJJ (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 18 Aug 2021 07:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbhHRLJE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Aug 2021 07:09:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515DBC061764;
        Wed, 18 Aug 2021 04:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xF3XSQocGKr3XFWdPGOP9gXsahAr6PzRo/gjqi7SrQw=; b=elMK4wMFZCS7zOtF3Kqr6Qx0Ts
        BvtKhauM9WXNcWGqt3xyFwwLDMmg90XOftPK1TKxNZ0ElZqghYwMSu3VOshfKq4mJu1NEJYfOIlYP
        8cerDUID75lFIm370aWtQuziRuBEoaeDNezJSUJel6Yl3VVLphnSA+Rd20hQ/ylzHco+tr15iyuwt
        7OgloetCQ4m6OvROCo+b4zZLTBFME+nvxfRaOMPCK6tmOmz4n2Ro40g9DgtqcHiugbFqYN1GBXPkD
        52RPR8u0bGSmYe20+e/zG6OCtyDULgROSbjweT1C1NdTWbBzQ/+ZYma2siK9FR6AMQmH2Nx0WL2if
        cDwJNvXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGJOb-003k4v-97; Wed, 18 Aug 2021 11:06:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 859E53012AD;
        Wed, 18 Aug 2021 13:06:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CF20200FBAE0; Wed, 18 Aug 2021 13:06:08 +0200 (CEST)
Date:   Wed, 18 Aug 2021 13:06:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: Re: [PATCH v11 08/16] sched: Allow task CPU affinity to be
 restricted on asymmetric systems
Message-ID: <YRzpoFdCqHHsjFpW@hirez.programming.kicks-ass.net>
References: <20210730112443.23245-1-will@kernel.org>
 <20210730112443.23245-9-will@kernel.org>
 <YRvRfZ/NnuNyIu3s@hirez.programming.kicks-ass.net>
 <20210818104227.GA13828@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818104227.GA13828@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 18, 2021 at 11:42:28AM +0100, Will Deacon wrote:

> Ah, sorry. I didn't realise you couldn't _free_ with a raw lock held in RT.
> Is there somewhere I can read up on that?

It's because the allocators use spinlock_t, which cannot nest inside
raw_spinlock_t.
