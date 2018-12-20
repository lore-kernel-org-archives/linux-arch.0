From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 2/2] ARC: show_regs: fix lockdep splat for good
Date: Thu, 20 Dec 2018 14:04:50 +0100
Message-ID: <20181220130450.GB17350@dhcp22.suse.cz>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-3-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545159239-30628-3-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <vineet.gupta1@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Tue 18-12-18 10:53:59, Vineet Gupta wrote:
> signal handling core calls ARCH show_regs() with preemption disabled
> which causes __might_sleep functions such as mmput leading to lockdep
> splat.  Workaround by re-enabling preemption temporarily.
> 
> This may not be as bad as it sounds since the preemption disabling
> itself was introduced for a supressing smp_processor_id() warning in x86
> code by commit 3a9f84d354ce ("signals, debug: fix BUG: using
> smp_processor_id() in preemptible code in print_fatal_signal()")

The commit you are referring to here sounds dubious in itself. We do not
want to stick a preempt_disable just to silence a warning. show_regs is
called from preemptible context at several places (e.g. __warn). Maybe
this was not the case in 2009 when the change was introduced but this
seems like a relict from the past. So can we fix the actual problem
rather than build on top of it instead?

Or maybe I am just missing something here.
-- 
Michal Hocko
SUSE Labs
