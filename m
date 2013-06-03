From: Will Deacon <will.deacon@arm.com>
Subject: Re: A bug about system call on ARM
Date: Mon, 3 Jun 2013 10:54:25 +0100
Message-ID: <20130603095425.GA32242@mudshark.cambridge.arm.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:56745 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755981Ab3FCJzj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jun 2013 05:55:39 -0400
Content-Disposition: inline
In-Reply-To: <35FD53F367049845BC99AC72306C23D1610991B87B@CNBJMBX05.corpusers.net>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: 'richard -rw- weinberger' <richard.weinberger@gmail.com>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>

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

No, because we don't have OABI-compat support for Thumb applications and
force everything down the EABI path instead.

Did you manage to test the patch?

Will
