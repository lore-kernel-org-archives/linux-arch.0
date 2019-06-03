Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:42344 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbfFCSn3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jun 2019 14:43:29 -0400
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190531082112.GH2623@hirez.programming.kicks-ass.net>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <77b30ed2-3211-222b-1342-051a6cde4f77@synopsys.com>
Date: Mon, 3 Jun 2019 11:43:20 -0700
MIME-Version: 1.0
In-Reply-To: <20190531082112.GH2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <Will.Deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, arcml <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190603184320.il3YPtOEDx32oGH079TYwC3ATQXtbv2MKeCU1HyewXk@z>

On 5/31/19 1:21 AM, Peter Zijlstra wrote:
> And I'll stand by my earlier conviction that any architecture that has a
> native u64 (be it a 64bit arch or a 32bit with double-width
> instructions) but has an ABI that allows u32 alignment on them is daft.

Why ? For 64-bit data on 32-bit systems, hardware doesn't claim to provide any
single-copy atomicity for such data and software doesn't expect either.
