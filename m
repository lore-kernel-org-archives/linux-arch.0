Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266386AbUHIJLc@vger.kernel.org>
Received: from holomorphy.com ([207.189.100.168]:7902 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266381AbUHIJLc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Aug 2004 05:11:32 -0400
Date: Mon, 9 Aug 2004 02:04:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: copy_page_range()
Message-ID: <20040809090458.GO11200@holomorphy.com>
References: <20040807000529.5ca6e8fe.davem@redhat.com> <16663.15729.828367.307053@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16663.15729.828367.307053@napali.hpl.hp.com>
To: davidm@hpl.hp.com
Cc: "David S. Miller" <davem@redhat.com>, torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Aug 09, 2004 at 02:01:37AM -0700, David Mosberger wrote:
> I didn't recall copy_page_range() being so high on ia64, but it's been
> a while since looked at this, so I ran it again (this is with a simple
> fork() loop; lmbench is trying to be too clever for me so I don't like
> profiling it...):
> % time      self     cumul     calls self/call  tot/call name
>  36.89     10.78     10.78      267k     40.4u     40.4u clear_page_tables
>  25.99      7.59     18.37      573k     13.2u     13.2u copy_page
>  11.42      3.34     21.70     2.07M     1.61u     1.61u clear_page
> I suspect some reasons for the different profile may be:
>  - 16KB page-size vs. 4KB page-size
>  - My binary was statically linked
> The good news is that your proposal should help clear_page_tables()
> just as easily as copy_page_range(). ;-)

These results are actually consistent with large-memory ia32.
Instruction-level profiles showed that the largest overhead in
copy_page_range() on such ia32 boxen appeared to be mm->rss++.


-- wli
