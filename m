Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12FBC47082
	for <linux-arch@archiver.kernel.org>; Thu,  3 Jun 2021 17:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85312613F1
	for <linux-arch@archiver.kernel.org>; Thu,  3 Jun 2021 17:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFCR0g (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 3 Jun 2021 13:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhFCR0g (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Jun 2021 13:26:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF47B613BA;
        Thu,  3 Jun 2021 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622741091;
        bh=s8c3WYNwEnlcHkonES0jC3l/FFhEH+u3QYZlANfbx6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJDX284AfuG0YWVhlRQCSz+oB/P4kCVP2uvC2hSXl7NTozHsPv4v3xgdWN/W3MHnh
         8COToyhYoqHvAaNKVl9xJmFy9JWrCnxiw8MLknbpqnORo3U2YMOUv3DDqKCzYUzKUc
         gkQvltPQJSstJlLUiv9437VgvZvSqYnOl+AQFkkM0yWlRW/My5bCUZXft8smh8th9i
         seCac16lWvKiwlac0gjsU9C8c93nDgFWG2d7PcTeE6cM90TGx/kNprwQ1Uk4MeSPpv
         BMyj2nAcHLj8ZrvyUKk7JnuV3nTgNUyQQBAzooyeARPg4m+HKf8AKr4VW0ojBCCNoN
         QerM5LDQDbMxw==
Date:   Thu, 3 Jun 2021 18:24:44 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        kernel-team@android.com
Subject: Re: [PATCH v8 01/19] arm64: cpuinfo: Split AArch32 registers out
 into a separate struct
Message-ID: <20210603172444.GA1170@willie-the-truck>
References: <20210602164719.31777-1-will@kernel.org>
 <20210602164719.31777-2-will@kernel.org>
 <20210603123852.GB48596@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603123852.GB48596@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 03, 2021 at 01:38:52PM +0100, Mark Rutland wrote:
> On Wed, Jun 02, 2021 at 05:47:01PM +0100, Will Deacon wrote:
> > In preparation for late initialisation of the "sanitised" AArch32 register
> > state, move the AArch32 registers out of 'struct cpuinfo' and into their
> > own struct definition.
> > 
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> Makes sense to me; if it's not too painful to change, I'd suggest
> `aarch32` rather than `32bit` in the name, but either way:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks. "32bit" is already pervasive in cpufeature.c and we're using arm64
instead of aarch64 in cpuinfo_arm64, so I'll leave this as-is and offer
somebody else the refactoring opportunity ;)

Will
