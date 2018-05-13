From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH REPOST 1/5] thread_info: Port core code to use
 update_thread_flag() helpers
Date: Sun, 13 May 2018 18:12:32 +0200
Message-ID: <20180513161231.GA25642@redhat.com>
References: <1526051104-15995-1-git-send-email-Dave.Martin@arm.com>
 <1526051104-15995-2-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1526051104-15995-2-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 05/11, Dave Martin wrote:
>
> This patch ports a couple of relevant bits of the core kernel to
> use the new update_thread_flag() helpers.
>
> No functional change.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> ---
>  include/trace/syscall.h |  6 ++----
>  kernel/ptrace.c         | 13 +++++--------
>  2 files changed, 7 insertions(+), 12 deletions(-)

Acked-by: Oleg Nesterov <oleg@redhat.com>
