Return-Path: <SRS0=bFu9=BY=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85342C433DF
	for <linux-arch@archiver.kernel.org>; Fri, 14 Aug 2020 11:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67EB720771
	for <linux-arch@archiver.kernel.org>; Fri, 14 Aug 2020 11:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgHNLby (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:31:54 -0400
Received: from foss.arm.com ([217.140.110.172]:33318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgHNLby (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Aug 2020 07:31:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 177651063;
        Fri, 14 Aug 2020 04:31:54 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.33.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E25063F6CF;
        Fri, 14 Aug 2020 04:31:51 -0700 (PDT)
Date:   Fri, 14 Aug 2020 12:31:49 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 8/8] locking/atomics: Use read-write instrumentation for
 atomic RMWs
Message-ID: <20200814113149.GC68877@C02TD0UTHF1T.local>
References: <20200721103016.3287832-1-elver@google.com>
 <20200721103016.3287832-9-elver@google.com>
 <20200721141859.GC10769@hirez.programming.kicks-ass.net>
 <CANpmjNM6C6QtrtLhRkbmfc3jLqYaQOvvM_vKA6UyrkWadkdzNQ@mail.gmail.com>
 <20200814112826.GB68877@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814112826.GB68877@C02TD0UTHF1T.local>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 14, 2020 at 12:28:26PM +0100, Mark Rutland wrote:
> Hi,
> 
> Sorry to come to this rather late -- this comment equally applies to v2
> so I'm replying here to have context.

... and now I see that was already applied, so please ignore this!

Mark.
