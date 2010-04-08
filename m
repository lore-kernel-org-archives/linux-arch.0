From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 03/13] x86: Remove last traces of quicklist usage
Date: Thu, 08 Apr 2010 16:51:25 -0400
Message-ID: <4BBE41CD.1020802@redhat.com>
References: <20100408191737.296180458@chello.nl> <20100408192722.729787846@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3384 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933678Ab0DHUwJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 8 Apr 2010 16:52:09 -0400
In-Reply-To: <20100408192722.729787846@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>

On 04/08/2010 03:17 PM, Peter Zijlstra wrote:
> We still have a stray quicklist header included even though we axed
> quicklist usage quite a while back.
>
> Signed-off-by: Peter Zijlstra<a.p.zijlstra@chello.nl>

Reviewed-by: Rik van Riel <riel@redhat.com>
