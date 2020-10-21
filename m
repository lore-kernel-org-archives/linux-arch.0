Return-Path: <SRS0=59OF=D4=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C76C388F9
	for <linux-arch@archiver.kernel.org>; Wed, 21 Oct 2020 14:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C552224E
	for <linux-arch@archiver.kernel.org>; Wed, 21 Oct 2020 14:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441679AbgJUOb6 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 21 Oct 2020 10:31:58 -0400
Received: from foss.arm.com ([217.140.110.172]:36012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441648AbgJUOb6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 10:31:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF398D6E;
        Wed, 21 Oct 2020 07:31:57 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E3783F66B;
        Wed, 21 Oct 2020 07:31:56 -0700 (PDT)
Date:   Wed, 21 Oct 2020 15:31:53 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201021143153.7ef7n7gdd42l4rbc@e107158-lin>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021133316.GF8004@e123083-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021133316.GF8004@e123083-lin>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/21/20 15:33, Morten Rasmussen wrote:
> On Wed, Oct 21, 2020 at 01:15:59PM +0100, Catalin Marinas wrote:
> > one, though not as easy as automatic task placement by the scheduler (my
> > first preference, followed by the id_* regs and the aarch32 mask, though
> > not a strong preference for any).
> 
> Automatic task placement by the scheduler would mean giving up the
> requirement that the user-space affinity mask must always be honoured.
> Is that on the table?
> 
> Killing aarch32 tasks with an empty intersection between the user-space
> mask and aarch32_mask is not really "automatic" and would require the
> aarch32 capability to be exposed anyway.

I just noticed this nasty corner case too.


Documentation/admin-guide/cgroup-v1/cpusets.rst: Section 1.9

"If such a task had been bound to some subset of its cpuset using the
sched_setaffinity() call, the task will be allowed to run on any CPU allowed in
its new cpuset, negating the effect of the prior sched_setaffinity() call."


So user space must put the tasks into a valid cpuset to fix the problem. Or
make the scheduler behave like the affinity is associated with a cpuset.

Can user space put the task into the correct cpuset without a race? Clone3
syscall learnt to specify a cgroup to attach to when forking. Should we do the
same for execve()?


Thanks

--
Qais Yousef
