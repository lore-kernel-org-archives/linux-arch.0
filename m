From: David Howells <dhowells@redhat.com>
Subject: Re: memory barrier question
Date: Thu, 16 Sep 2010 18:59:14 +0100
Message-ID: <18367.1284659954@redhat.com>
References: <1284653939.2275.578.camel@laptop> <E1Ovt6F-0005CS-RU@pomaz-ex.szeredi.hu> <3777.1284638136@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11661 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755485Ab0IPR7d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2010 13:59:33 -0400
In-Reply-To: <1284653939.2275.578.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> wrote:

> Therefore:
> 
>   A = 5
>   LOCK
> 
>   UNLOCK
>   B = 6
> 
> May be observed as:
> 
>    LOCK
>    B = 6
>    A = 5
>    UNLOCK

Yeah, you're right.

David
