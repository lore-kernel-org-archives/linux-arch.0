From: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Subject: RE: A bug about system call on ARM
Date: Mon, 3 Jun 2013 13:25:26 +0800
Message-ID: <35FD53F367049845BC99AC72306C23D1610991B87B@CNBJMBX05.corpusers.net>
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
 <20130531111305.GI4928@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B876@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cnbjrel01.sonyericsson.com ([219.141.167.165]:2388 "EHLO
	cnbjrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750896Ab3FCFZa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 3 Jun 2013 01:25:30 -0400
In-Reply-To: <35FD53F367049845BC99AC72306C23D1610991B876@CNBJMBX05.corpusers.net>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>, 'Will Deacon' <will.deacon@arm.com>
Cc: 'richard -rw- weinberger' <richard.weinberger@gmail.com>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>

Hi  Will,

I have a question about this patch .

If the user space is thumb mode,
The PC should be rewind by 2 bytes,
So the fix_up code should be 

Sub lr, lr, #2 .


Am I right ?


Thanks for your help .

-----Original Message-----
From: Wang, Yalin 
Sent: Friday, May 31, 2013 7:31 PM
To: 'Will Deacon'
Cc: 'richard -rw- weinberger'; 'linux-arch@vger.kernel.org'; 'linux-kernel@vger.kernel.org'; 'linux-arm-kernel@lists.infradead.org'
Subject: RE: A bug about system call on ARM

Hi Will,

I see,
I will make one more test .

Thanks for your clarification .

-----Original Message-----
From: Will Deacon [mailto:will.deacon@arm.com] 
Sent: Friday, May 31, 2013 7:13 PM
To: Wang, Yalin
Cc: 'richard -rw- weinberger'; 'linux-arch@vger.kernel.org'; 'linux-kernel@vger.kernel.org'; 'linux-arm-kernel@lists.infradead.org'
Subject: Re: A bug about system call on ARM

On Fri, May 31, 2013 at 12:02:49PM +0100, Wang, Yalin wrote:
> Hi  Will,
> 
> I have merge your code ,
> But there is a different ,
> 
> +	
> +	ct_user_exit

I thought you didn't have ct_user_exit? In which case, just delete this line.

> +#ifdef CONFIG_ALIGNMENT_TRAP
> +	ldr	ip, __cr_alignment
> +	ldr	ip, [ip]
> +	mcr	p15, 0, ip, c1, c0		@ update control register
> +#endif
> 
> +	enable_irq
> +	get_thread_info tsk

Hard to tell without context. You can take a look at my git tree if you like (I fixed it up based on Nico's comment):

  https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/commit/?h=misc-patches

Will
