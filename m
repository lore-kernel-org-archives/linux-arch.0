From: Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH] alpha: provide ioread64 and iowrite64 implementations
Date: Sat, 24 Jun 2017 08:25:30 -0700
Message-ID: <787b4be1-ce9e-6838-27b6-0cd9f8d7805f@twiddle.net>
References: <20170624115707.30095-1-horia.geanta@nxp.com>
 <20170624151308.6348-1-rth@twiddle.net>
 <dfc70cc1-09a9-f6d0-83a8-c8ca5d7a232b@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34076 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdFXPZd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Jun 2017 11:25:33 -0400
In-Reply-To: <dfc70cc1-09a9-f6d0-83a8-c8ca5d7a232b@deltatee.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org
Cc: linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>

On 06/24/2017 08:19 AM, Logan Gunthorpe wrote:
> Hey,
> 
> On 24/06/17 09:13 AM, Richard Henderson wrote:
>> All Alpha hosts except for Jensen provide 64-bit I/O operations.
>>
>> Jensen is EISA only, so there ought not be any devices that even
>> attempt such operations.  But just in case, use 2 32-bit operations.
> 
> Thanks for this, Richard.
> 
> However, I was recently enlightened by the existence of the
> linux/io-64-nonatomic* headers. This is where the 2 32-bit operation
> functions belong. So you should probably remove them from this patch and
> let drivers that need them just include those headers.

This has nothing to do with drivers.

This is all about providing 64-bit operations for the 99.999% of alphas that do 
have them.


r~
