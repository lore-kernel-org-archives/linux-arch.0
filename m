From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH REPOST 5/5] sparc: Use update_thread_flag()
Date: Fri, 11 May 2018 11:10:18 -0400 (EDT)
Message-ID: <20180511.111018.1869809966358964133.davem@davemloft.net>
References: <1526051104-15995-1-git-send-email-Dave.Martin@arm.com>
        <1526051104-15995-6-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526051104-15995-6-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave.Martin@arm.com
Cc: linux-kernel@vger.kernel.org, ralf@linux-mips.org, jhogan@kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, oleg@redhat.com, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Dave Martin <Dave.Martin@arm.com>
Date: Fri, 11 May 2018 16:05:04 +0100

> This patch uses the new update_thread_flag() helper to simplify an
> if () set; else clear; construct.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
