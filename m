Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751617AbeEMQMg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 13 May 2018 12:12:36 -0400
Date: Sun, 13 May 2018 18:12:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH REPOST 1/5] thread_info: Port core code to use
 update_thread_flag() helpers
Message-ID: <20180513161231.GA25642@redhat.com>
References: <1526051104-15995-1-git-send-email-Dave.Martin@arm.com>
 <1526051104-15995-2-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526051104-15995-2-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org
Message-ID: <20180513161232.3ANXMbuTU0i9rNwXa6mKkUtTUGxDAnRo9YNbgzmiZ9I@z>

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
