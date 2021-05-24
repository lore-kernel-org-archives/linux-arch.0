Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA23C04FF3
	for <linux-arch@archiver.kernel.org>; Mon, 24 May 2021 16:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1856113B
	for <linux-arch@archiver.kernel.org>; Mon, 24 May 2021 16:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhEXQXe (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 24 May 2021 12:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232918AbhEXQXe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 12:23:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75866613BF;
        Mon, 24 May 2021 16:22:03 +0000 (UTC)
Date:   Mon, 24 May 2021 17:22:01 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 21/21] Documentation: arm64: describe asymmetric
 32-bit support
Message-ID: <20210524162200.GH14645@arm.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-22-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518094725.7701-22-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 10:47:25AM +0100, Will Deacon wrote:
> Document support for running 32-bit tasks on asymmetric 32-bit systems
> and its impact on the user ABI when enabled.
> 
> Signed-off-by: Will Deacon <will@kernel.org>

The logic looks alright to me but I suspect most arguments are around
the scheduler behaviour.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
