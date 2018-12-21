Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:43358 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731150AbeLURzo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Dec 2018 12:55:44 -0500
Subject: Re: [PATCH 2/2] ARC: show_regs: fix lockdep splat for good
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-3-git-send-email-vgupta@synopsys.com>
 <20181220130450.GB17350@dhcp22.suse.cz>
 <C2D7FE5348E1B147BCA15975FBA23075014642389B@US01WEMBX2.internal.synopsys.com>
 <20181221130404.GF16107@dhcp22.suse.cz>
From: Vineet Gupta <vineet.gupta1@synopsys.com>
Message-ID: <8b3739f1-a7d5-7253-362a-3a1c707b0f6d@synopsys.com>
Date: Fri, 21 Dec 2018 09:55:34 -0800
MIME-Version: 1.0
In-Reply-To: <20181221130404.GF16107@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20181221175534.ZogA1DoSlp7KTi0KvaWEuUj7JINUrZjFAgfNasvYWIo@z>

On 12/21/18 5:04 AM, Michal Hocko wrote:
>> I presume you are referring to original commit, not my anti-change in ARC code,
>> which is actually re-enabling it.
> 
> Yes, but you are building on a broken concept I believe.

Not sure where this is heading. Broken concept was introduced by disabling
preemption around show_regs() to silence x86 smp_processor_id() splat in 2009.

> What
> implications does re-enabling really have ? Now you could reschedule and> you can move to another CPU. Is this really safe?
