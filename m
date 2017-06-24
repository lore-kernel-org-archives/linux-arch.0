From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] alpha: provide ioread64 and iowrite64 implementations
Date: Sat, 24 Jun 2017 09:32:01 -0600
Message-ID: <721fd59b-b807-86bf-a39c-bab0b33c57c0@deltatee.com>
References: <20170624115707.30095-1-horia.geanta@nxp.com>
 <20170624151308.6348-1-rth@twiddle.net>
 <dfc70cc1-09a9-f6d0-83a8-c8ca5d7a232b@deltatee.com>
 <787b4be1-ce9e-6838-27b6-0cd9f8d7805f@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:60785 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751338AbdFXPcJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 24 Jun 2017 11:32:09 -0400
In-Reply-To: <787b4be1-ce9e-6838-27b6-0cd9f8d7805f@twiddle.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Cc: linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>



On 24/06/17 09:25 AM, Richard Henderson wrote:
> On 06/24/2017 08:19 AM, Logan Gunthorpe wrote:
>> Hey,
>>
>> On 24/06/17 09:13 AM, Richard Henderson wrote:
>>> All Alpha hosts except for Jensen provide 64-bit I/O operations.
>>>
>>> Jensen is EISA only, so there ought not be any devices that even
>>> attempt such operations.  But just in case, use 2 32-bit operations.
>>
>> Thanks for this, Richard.
>>
>> However, I was recently enlightened by the existence of the
>> linux/io-64-nonatomic* headers. This is where the 2 32-bit operation
>> functions belong. So you should probably remove them from this patch and
>> let drivers that need them just include those headers.
> 
> This has nothing to do with drivers.
> 
> This is all about providing 64-bit operations for the 99.999% of alphas
> that do have them.

As per the discussion with Arnd and Alan, that's not what they want.
Arches that have native 64bit operations should supply them. For drivers
that want to use them in the presence of arches that don't supply them,
they simply include one of the linux/io-64-nonatomic helper headers.

So, IMO, the Jensen inq and outq funtions in your patch, which I did
read, should probably just not be provided.

Logan
