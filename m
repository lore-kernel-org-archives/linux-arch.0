From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: new architectures, time_t __kernel_long_t
Date: Thu, 15 Nov 2012 07:10:12 -0800
Message-ID: <50A505D4.1080606@zytor.com>
References: <201211141218.02105.arnd@arndb.de> <201211150914.22835.arnd@arndb.de> <CAMe9rOpziKa6QLfjX9iXtfj_X2QAyDAV2p8NEd8Wd7yFwTrpNg@mail.gmail.com> <201211151436.23088.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:51204 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768222Ab2KOPKd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Nov 2012 10:10:33 -0500
In-Reply-To: <201211151436.23088.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, linux-arch@vger.kernel.org, Vineet.Gupta1@synopsys.com, linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>

On 11/15/2012 06:36 AM, Arnd Bergmann wrote:
>>
>> Glibc has been providing its own types for years.
>> Kernel provided types used to be wrong for ia32
>> on x86-64.
>
> What about ioctls and other calls then that actually do rely on the
> kernel headers and use the __kernel_*_t types?
>

Now, glibc *shouldn't* have to do that... it is an indication of failure 
on our part.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
