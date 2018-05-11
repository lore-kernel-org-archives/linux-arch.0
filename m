Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:46782 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeEKPKV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 May 2018 11:10:21 -0400
Date: Fri, 11 May 2018 11:10:18 -0400 (EDT)
Message-ID: <20180511.111018.1869809966358964133.davem@davemloft.net>
Subject: Re: [PATCH REPOST 5/5] sparc: Use update_thread_flag()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526051104-15995-6-git-send-email-Dave.Martin@arm.com>
References: <1526051104-15995-1-git-send-email-Dave.Martin@arm.com>
        <1526051104-15995-6-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave.Martin@arm.com
Cc: linux-kernel@vger.kernel.org, ralf@linux-mips.org, jhogan@kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, oleg@redhat.com, linux-arch@vger.kernel.org
Message-ID: <20180511151018.x5Tx2wwh8qnSZg2dt-308Z-lSdliljauoYzF-IkXXlk@z>

From: Dave Martin <Dave.Martin@arm.com>
Date: Fri, 11 May 2018 16:05:04 +0100

> This patch uses the new update_thread_flag() helper to simplify an
> if () set; else clear; construct.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
