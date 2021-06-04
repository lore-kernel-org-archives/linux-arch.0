Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5C0C4743D
	for <linux-arch@archiver.kernel.org>; Fri,  4 Jun 2021 17:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 225B961405
	for <linux-arch@archiver.kernel.org>; Fri,  4 Jun 2021 17:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFDRMn (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 4 Jun 2021 13:12:43 -0400
Received: from foss.arm.com ([217.140.110.172]:43740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhFDRMn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 13:12:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D020B1063;
        Fri,  4 Jun 2021 10:10:56 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11AEF3F73D;
        Fri,  4 Jun 2021 10:10:53 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
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
        kernel-team@android.com
Subject: Re: [PATCH v8 05/19] sched: Introduce task_cpu_possible_mask() to limit fallback rq selection
In-Reply-To: <20210602164719.31777-6-will@kernel.org>
References: <20210602164719.31777-1-will@kernel.org> <20210602164719.31777-6-will@kernel.org>
Date:   Fri, 04 Jun 2021 18:10:46 +0100
Message-ID: <878s3peesp.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02/06/21 17:47, Will Deacon wrote:
> Asymmetric systems may not offer the same level of userspace ISA support
> across all CPUs, meaning that some applications cannot be executed by
> some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
> not feature support for 32-bit applications on both clusters.
>
> On such a system, we must take care not to migrate a task to an
> unsupported CPU when forcefully moving tasks in select_fallback_rq()
> in response to a CPU hot-unplug operation.
>
> Introduce a task_cpu_possible_mask() hook which, given a task argument,
> allows an architecture to return a cpumask of CPUs that are capable of
> executing that task. The default implementation returns the
> cpu_possible_mask, since sane machines do not suffer from per-cpu ISA
> limitations that affect scheduling. The new mask is used when selecting
> the fallback runqueue as a last resort before forcing a migration to the
> first active CPU.
>

Nit: Some uses of this mask (cpu_is_allowed(), __set_cpus_allowed_ptr())
don't apply to kthreads. This makes sense for the 32-bit@EL0 faff, but it
wouldn't hurt to point this out somewhere IMO.

Also, that's an odd place for the definitions, but IIRC there isn't a much
better choice.

Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
