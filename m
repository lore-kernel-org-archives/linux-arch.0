From: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Subject: RE: A bug about system call on ARM
Date: Mon, 3 Jun 2013 17:58:18 +0800
Message-ID: <35FD53F367049845BC99AC72306C23D1610991B87E@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D1610991B865@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1610991B866@CNBJMBX05.corpusers.net>
 <20130530090949.GC7483@mudshark.cambridge.arm.com>
 <20130530114112.GH7483@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B86D@CNBJMBX05.corpusers.net>
 <20130531084638.GB4928@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B874@CNBJMBX05.corpusers.net>
 <20130531111305.GI4928@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B876@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1610991B87B@CNBJMBX05.corpusers.net>
 <20130603095425.GA32242@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cnbjrel02.sonyericsson.com ([219.141.167.166]:9546 "EHLO
	cnbjrel02.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753722Ab3FCJ6Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 3 Jun 2013 05:58:24 -0400
In-Reply-To: <20130603095425.GA32242@mudshark.cambridge.arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Will Deacon' <will.deacon@arm.com>
Cc: 'richard -rw- weinberger' <richard.weinberger@gmail.com>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>

Hi  Will

Oh  I see,
Thanks for your reply 

Yes ,  we are testing for it ,
But need some time to wait for the result ,
Because The stability test need some time to reproduce
this issue , And this issue doesn't reproduce 100% .


-----Original Message-----
From: Will Deacon [mailto:will.deacon@arm.com] 
Sent: Monday, June 03, 2013 5:54 PM
To: Wang, Yalin
Cc: 'richard -rw- weinberger'; 'linux-arch@vger.kernel.org'; 'linux-kernel@vger.kernel.org'; 'linux-arm-kernel@lists.infradead.org'
Subject: Re: A bug about system call on ARM

On Mon, Jun 03, 2013 at 06:25:26AM +0100, Wang, Yalin wrote:
> Hi  Will,
> 
> I have a question about this patch .
> 
> If the user space is thumb mode,
> The PC should be rewind by 2 bytes,
> So the fix_up code should be
> 
> Sub lr, lr, #2 .
> 
> 
> Am I right ?

No, because we don't have OABI-compat support for Thumb applications and force everything down the EABI path instead.

Did you manage to test the patch?

Will
