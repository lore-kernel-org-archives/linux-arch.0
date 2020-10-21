Return-Path: <SRS0=59OF=D4=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456FBC388F9
	for <linux-arch@archiver.kernel.org>; Wed, 21 Oct 2020 12:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D145622384
	for <linux-arch@archiver.kernel.org>; Wed, 21 Oct 2020 12:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406558AbgJUMQF (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 21 Oct 2020 08:16:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406506AbgJUMQF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 08:16:05 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 600622224B;
        Wed, 21 Oct 2020 12:16:02 +0000 (UTC)
Date:   Wed, 21 Oct 2020 13:15:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201021121559.GB3976@gaia>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63fead90e91e08a1b173792b06995765@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 12:09:58PM +0100, Marc Zyngier wrote:
> On 2020-10-21 11:46, Qais Yousef wrote:
> > Example output. I was surprised that the 2nd field (bits[7:4]) is
> > printed out
> > although it's set as FTR_HIDDEN.
> > 
> > # cat /sys/devices/system/cpu/cpu*/regs/identification/id_aa64pfr0
> > 0x0000000000000011
> > 0x0000000000000011
> > 0x0000000000000011
> > 0x0000000000000011
> > 0x0000000000000011
> > 0x0000000000000011
> > 
> > # echo 1 > /proc/sys/kernel/enable_asym_32bit
> > 
> > # cat /sys/devices/system/cpu/cpu*/regs/identification/id_aa64pfr0
> > 0x0000000000000011
> > 0x0000000000000011
> > 0x0000000000000012
> > 0x0000000000000012
> > 0x0000000000000011
> > 0x0000000000000011
> 
> This looks like a terrible userspace interface. It exposes unrelated
> features,

Not sure why the EL1 field ended up in here, that's not relevant to the
user.

> and doesn't expose the single useful information that the kernel has:
> the cpumask describing the CPUs supporting  AArch32 at EL0. Why not expose
> this synthetic piece of information which requires very little effort from
> userspace and doesn't spit out unrelated stuff?

I thought the whole idea is to try and avoid the "very little effort"
part ;).

> Not to mention the discrepancy with what userspace gets while reading
> the same register via the MRS emulation.
> 
> Granted, the cpumask doesn't fit the cpu*/regs/identification hierarchy,
> but I don't think this fits either.

We already expose MIDR and REVIDR via the current sysfs interface. We
can expand it to include _all_ the other ID_* regs currently available
to user via the MRS emulation and we won't have to debate what a new
interface would look like. The MRS emulation and the sysfs info should
probably match, though that means we need to expose the
ID_AA64PFR0_EL1.EL0 field which we currently don't.

I do agree that an AArch32 cpumask is an easier option both from the
kernel implementation perspective and from the application usability
one, though not as easy as automatic task placement by the scheduler (my
first preference, followed by the id_* regs and the aarch32 mask, though
not a strong preference for any).

-- 
Catalin
