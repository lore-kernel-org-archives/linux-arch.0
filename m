From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Date: Mon, 3 Jun 2019 11:43:20 -0700
Message-ID: <77b30ed2-3211-222b-1342-051a6cde4f77@synopsys.com>
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190531082112.GH2623@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190531082112.GH2623@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <Will.Deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, arcml <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 5/31/19 1:21 AM, Peter Zijlstra wrote:
> And I'll stand by my earlier conviction that any architecture that has a
> native u64 (be it a 64bit arch or a 32bit with double-width
> instructions) but has an ABI that allows u32 alignment on them is daft.

Why ? For 64-bit data on 32-bit systems, hardware doesn't claim to provide any
single-copy atomicity for such data and software doesn't expect either.
