From: Will Deacon <will.deacon@arm.com>
Subject: Re: A bug about system call on ARM
Date: Fri, 31 May 2013 12:13:05 +0100
Message-ID: <20130531111305.GI4928@mudshark.cambridge.arm.com>
References: <35FD53F367049845BC99AC72306C23D1610991B85E@CNBJMBX05.corpusers.net>
 <CAFLxGvyy=73dGQqG8W6SXZah7WQZ4gJAeeHXN8opKaOuG-5yUQ@mail.gmail.com>
 <20130529094826.GD13095@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B865@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1610991B866@CNBJMBX05.corpusers.net>
 <20130530090949.GC7483@mudshark.cambridge.arm.com>
 <20130530114112.GH7483@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B86D@CNBJMBX05.corpusers.net>
 <20130531084638.GB4928@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B874@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:63179 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752526Ab3EaLNh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 31 May 2013 07:13:37 -0400
Content-Disposition: inline
In-Reply-To: <35FD53F367049845BC99AC72306C23D1610991B874@CNBJMBX05.corpusers.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: 'richard -rw- weinberger' <richard.weinberger@gmail.com>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>

On Fri, May 31, 2013 at 12:02:49PM +0100, Wang, Yalin wrote:
> Hi  Will,
> 
> I have merge your code ,
> But there is a different ,
> 
> +	
> +	ct_user_exit

I thought you didn't have ct_user_exit? In which case, just delete this
line.

> +#ifdef CONFIG_ALIGNMENT_TRAP
> +	ldr	ip, __cr_alignment
> +	ldr	ip, [ip]
> +	mcr	p15, 0, ip, c1, c0		@ update control register
> +#endif 
> 
> +	enable_irq
> +	get_thread_info tsk

Hard to tell without context. You can take a look at my git tree if you
like (I fixed it up based on Nico's comment):

  https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/commit/?h=misc-patches

Will
