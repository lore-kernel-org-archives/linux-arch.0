From: Will Deacon <will.deacon@arm.com>
Subject: Re: A bug about system call on ARM
Date: Fri, 31 May 2013 09:46:38 +0100
Message-ID: <20130531084638.GB4928@mudshark.cambridge.arm.com>
References: <CAFLxGvy39xWdZmtiVHP+y=zH1coCVmMuREcmD25wSb=w-VK7Xg@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D1610991B85D@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1610991B85E@CNBJMBX05.corpusers.net>
 <CAFLxGvyy=73dGQqG8W6SXZah7WQZ4gJAeeHXN8opKaOuG-5yUQ@mail.gmail.com>
 <20130529094826.GD13095@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B865@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1610991B866@CNBJMBX05.corpusers.net>
 <20130530090949.GC7483@mudshark.cambridge.arm.com>
 <20130530114112.GH7483@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B86D@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:59729 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751489Ab3EaIrU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 31 May 2013 04:47:20 -0400
Content-Disposition: inline
In-Reply-To: <35FD53F367049845BC99AC72306C23D1610991B86D@CNBJMBX05.corpusers.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: 'richard -rw- weinberger' <richard.weinberger@gmail.com>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>

On Fri, May 31, 2013 at 03:56:31AM +0100, Wang, Yalin wrote:
> Hi Will,
> 
> Thanks for your patch ,
> 
> But I found  I don't have ct_user_exit  macro 
> In my arch/arm/kernel/entry-common.S 
> 
> My kernel version is 3.4.0 

Well things have moved on this since then (we're approaching 3.10, so you
might consider an upgrade!).

For the purposes of this patch, you can just delete the ct_user_exit line.

Will
