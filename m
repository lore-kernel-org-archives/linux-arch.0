From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 10/13] lockdep, mutex: Provide mutex_lock_nest_lock
Date: Fri, 09 Apr 2010 11:36:09 -0400
Message-ID: <4BBF4969.3090906@redhat.com>
References: <20100408191737.296180458@chello.nl> <20100408192723.030209643@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25410 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391Ab0DIPhI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Apr 2010 11:37:08 -0400
In-Reply-To: <20100408192723.030209643@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>

On 04/08/2010 03:17 PM, Peter Zijlstra wrote:
> Provide the mutex_lock_nest_lock() annotation.
>
> Signed-off-by: Peter Zijlstra<a.p.zijlstra@chello.nl>

Reviewed-by: Rik van Riel <riel@redhat.com>
