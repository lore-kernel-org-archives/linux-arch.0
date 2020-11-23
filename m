Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C4CC63697
	for <linux-arch@archiver.kernel.org>; Mon, 23 Nov 2020 14:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6F020782
	for <linux-arch@archiver.kernel.org>; Mon, 23 Nov 2020 14:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBmYLN3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgKWOsc (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 23 Nov 2020 09:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbgKWOsa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2020 09:48:30 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6065EC061A4D
        for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2020 06:48:29 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r3so551624wrt.2
        for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2020 06:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j3w1GqHE08GStM/FLoVxqtcruKl7crLd6tb2/zrsaZo=;
        b=HBmYLN3XpZuXc+k7o3oPHKUiBOVZVGKMLlUtlZYnuMYguOXjuS7k+Y3qtnx9wY/UmJ
         a5gcLYQmvATwN3KcQAL2GNy/JOUBnWvNttq0kl0MtuxVaT1Bset1PUM0wRQe7efukfH4
         zFVekyFAz0HROoZGdmVZrLKicLJNXNXPLmsoyHkar8xpZZhnYl0sOLL5x4QQ+oK7ztYd
         kvnye4dIrZNljZ5iEWLH6DvobUmKXXjDrKJI3xeAdnQwFGCkrU0WlwNFUhpNbYI+t1t6
         jOuSI9LT3vYQ+Qo/401gZ84DarbWpSFRzoImCb6m4AlMD+e6gX2ww5L5GHUZ/IyQPs0L
         Ro8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j3w1GqHE08GStM/FLoVxqtcruKl7crLd6tb2/zrsaZo=;
        b=psLz6S6J3gRcsUu0DgP81jFSNajy7OjGVqhrvNbj1hTWZ6tlDuO7quMnsQ75PfA7CQ
         hk4Ec3S67NWb88+oPuwyGO7vyh8nm1I0IQOYmxgNvlHx47cvs78pZ1RSXW7fSFjQQ8Nv
         AN/Bt1NU7OXKT4cZhd0rJuvqOQyHEWqHzMu1+s20Hsigd5N4MiF557/C/2romd3o4cMI
         wd6PqlsFMf3LkoW2coffRqfgFqgpDAR0Cd8VUuHJZBukxxeZpxE6e1B2Demh2dAIQpq+
         0Z+PGDU5ZSvy616qTkJdXep0QXd1cmkk9pcWfUcVAyAXD5X1M/XNowYMP+xWCdjGmbL2
         HOog==
X-Gm-Message-State: AOAM531wRUgyevjZQRKRBnQoyfkI4ilyFQoeALvnzNH4TdhaLjf56QFt
        /eh5r6kOFdWVWzCwJTqGK2whtkHnxXdryj2M
X-Google-Smtp-Source: ABdhPJx6nTEwiFj8zZhxXBuJbb4oSybAB3dPrXTH+w6ewGwc/0dai1XkAj+mvfJ/6d3uF5/5kpr7Hw==
X-Received: by 2002:adf:e481:: with SMTP id i1mr22651329wrm.282.1606142907911;
        Mon, 23 Nov 2020 06:48:27 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id x2sm19346846wru.44.2020.11.23.06.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 06:48:27 -0800 (PST)
Date:   Mon, 23 Nov 2020 14:48:24 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 10/14] sched: Introduce arch_cpu_allowed_mask() to
 limit fallback rq selection
Message-ID: <20201123144824.GA586782@google.com>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-11-will@kernel.org>
 <20201119093850.GD2416649@google.com>
 <20201119110709.GD3946@willie-the-truck>
 <20201119203906.GA5099@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119203906.GA5099@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thursday 19 Nov 2020 at 20:39:07 (+0000), Will Deacon wrote:
> Ah, so in doing this I realised I don't like arch_cpu_possible_mask() so
> much because it makes it sound like a back-end to cpu_possible_mask, but
> the two are really different things.
> 
> arch_task_cpu_possible_mask() might work?

Yes, making it explicit in the name that this is a task-specific thing
doesn't hurt.

Thanks,
Quentin
