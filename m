From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH Documentation/memory-barriers.txt] Clarify limited
 control-dependency scope
Date: Fri, 17 Jun 2016 09:53:50 +0200
Message-ID: <20160617075350.GA28894@gmail.com>
References: <20160615230817.GA18039@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34055 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbcFQHxz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2016 03:53:55 -0400
Content-Disposition: inline
In-Reply-To: <20160615230817.GA18039@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, corbet@lwn.net, will.deacon@arm.com, peterz@infradead.org


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> Nothing in the control-dependencies section of memory-barriers.txt
> says that control dependencies don't extend beyond the end of the
> if-statement containing the control dependency.  Worse yet, in many
> situations, they do extend beyond that if-statement.  In particular,
> the compiler cannot destroy the control dependency given proper use of
> READ_ONCE() and WRITE_ONCE().  However, a weakly ordered system having
> a conditional-move instruction provides the control-dependency guarantee
> only to code within the scope of the if-statement itself.
> 
> This commit therefore adds words and an example demonstrating this
> limitation of control dependencies.
> 
> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 147ae8ec836f..a4d0a99de04d 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -806,6 +806,41 @@ out-guess your code.  More generally, although READ_ONCE() does force
>  the compiler to actually emit code for a given load, it does not force
>  the compiler to use the results.
>  
> +In addition, control dependencies apply only to the then-clause and
> +else-clause of the if-statement in question.  In particular, it does
> +not necessarily apply to code following the if-statement:
> +
> +	q = READ_ONCE(a);
> +	if (q) {
> +		WRITE_ONCE(b, p);
> +	} else {
> +		WRITE_ONCE(b, r);
> +	}
> +	WRITE_ONCE(c, 1);  /* BUG: No ordering against the read from "a". */
> +
> +It is tempting to argue that there in fact is ordering because the
> +compiler cannot reorder volatile accesses and also cannot reorder
> +the writes to "b" with the condition.  Unfortunately for this line
> +of reasoning, the compiler might compile the two writes to "b" as
> +conditional-move instructions, as in this fanciful pseudo-assembly
> +language:

While CMOV would be the typical situation, even without CMOV the compiler could 
also internally transform it to:

> +	if (q)
> +		WRITE_ONCE(b, p);
> +	if (!q)
> +		WRITE_ONCE(b, r);

... and CPU speculation flow could get past the two branches without seeing any 
ordering constraint with the writes to 'b'.

I.e. conditions are not 'atomic', they can be 'torn' by the compiler just as much 
as reads or writes can be torn.

Thanks,

	Ingo
