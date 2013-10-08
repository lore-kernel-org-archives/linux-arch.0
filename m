From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 3/3] sched: Remove ARCH specific fpu_counter from
 task_struct
Date: Tue, 8 Oct 2013 10:02:12 +0200
Message-ID: <20131008080212.GA6541@gmail.com>
References: <1381218389-16585-1-git-send-email-vgupta@synopsys.com>
 <1381218389-16585-4-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381218389-16585-4-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Paul Mundt <paul.mundt@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:

> From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> 
> fpu_counter in task_struct was used only by sh/x86.
> Both of these now carry it in ARCH specific thread_struct, hence this
> can now be removed from generic task_struct, shrinking it slightly for
> other arches.
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
