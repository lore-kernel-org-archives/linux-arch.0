Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:53544 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeLSVgy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Dec 2018 16:36:54 -0500
Subject: Re: [PATCH 1/2] ARC: show_regs: avoid page allocator
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-2-git-send-email-vgupta@synopsys.com>
 <114881A8-8960-4436-AAE4-DE40BFFCFB4B@oracle.com>
From: Vineet Gupta <vineet.gupta1@synopsys.com>
Message-ID: <d58e8389-3e27-b1cf-7787-52808a0c22a7@synopsys.com>
Date: Wed, 19 Dec 2018 13:36:43 -0800
MIME-Version: 1.0
In-Reply-To: <114881A8-8960-4436-AAE4-DE40BFFCFB4B@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: William Kucharski <william.kucharski@oracle.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20181219213643.Wf9yGQ9SWxkoTv12kYx5gqsguMuYu_TlqqgGeyUZx7Y@z>

On 12/19/18 12:46 PM, William Kucharski wrote:
> I would rather see 256 as a #define somewhere rather than a magic number sprinkled
> around arch/arc/kernel/troubleshoot.c.

That bothered me as well, but I was too lazy to define one and the existing ones
don't apply. PATH_MAX is 4K which will blow up the stack usage.
> 
> Still, that's what the existing code does, so I suppose it's OK.

I'll define one locally.

> Otherwise the change looks good.

Thx for taking a look.

> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

I'll add this to the patch.

Thx,
-Vineet
