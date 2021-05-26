Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DACC47082
	for <linux-arch@archiver.kernel.org>; Wed, 26 May 2021 16:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EC8613E6
	for <linux-arch@archiver.kernel.org>; Wed, 26 May 2021 16:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbhEZQhE (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 26 May 2021 12:37:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234693AbhEZQhD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 May 2021 12:37:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8458B613CE;
        Wed, 26 May 2021 16:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622046931;
        bh=RENKLcEHhu959JDvFspwaYEtf68i2Lx50KgXzCU65WQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aFk7znWTc04PVrql1zNgqykTtI/3LSeJa18g/JoMeOfVTpYCQ3B3+lQh64rYcBElS
         M9cHSquWwUPVcIVRRfl2k4nRS7Nf45JJ/9ghznU9niPdlofALWbZ260qvGiZd3nWXi
         ZihXHTRH0PVX8As6yAHFwirK4Rj1GKw2b+wenAHTwMrP7lyhGYl4c4qEDHyNeUluIA
         qUPiXxtgmkdyGkJvPQ3N7tuDFm4cysHwCNAJv5qnIHZ0+uGqmKbKdPiBEoLUpRhM4d
         2j23drlhmHaL+MjGA2w19b6l0rOUNnRUdPYXvJzBzumCqdXN+Vh7SPaWKSq1UIe2DF
         q3jaG7017X/sA==
Date:   Wed, 26 May 2021 17:35:25 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
        kernel-team@android.com
Subject: Re: [PATCH v7 13/22] sched: Allow task CPU affinity to be restricted
 on asymmetric systems
Message-ID: <20210526163523.GA19758@willie-the-truck>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-14-will@kernel.org>
 <YK51SSUvL2psb3OL@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK51SSUvL2psb3OL@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 26, 2021 at 06:20:25PM +0200, Peter Zijlstra wrote:
> On Tue, May 25, 2021 at 04:14:23PM +0100, Will Deacon wrote:
> > +static int restrict_cpus_allowed_ptr(struct task_struct *p,
> > +				     struct cpumask *new_mask,
> > +				     const struct cpumask *subset_mask)
> > +{
> > +	struct rq_flags rf;
> > +	struct rq *rq;
> > +	int err;
> > +	struct cpumask *user_mask = NULL;
> > +
> > +	if (!p->user_cpus_ptr) {
> > +		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
> 
> 		if (!user_mask)
> 			return -ENOMEM;
> 	}
> 
> ?

We won't blow up if we continue without user_mask here, but I agree that
it's more straightforward to return an error and have
force_compatible_cpus_allowed_ptr() noisily override the mask.

We're in pretty deep trouble if we're failing this allocation anyway.

Will
