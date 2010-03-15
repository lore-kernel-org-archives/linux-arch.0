From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 64-syscall args on 32-bit vs syscall()
Date: Mon, 15 Mar 2010 12:41:27 -0700
Message-ID: <4B9E8D67.8040209@zytor.com>
References: <20100315134449.GB1653@linux-mips.org>	<4B9E4EB1.9010800@zytor.com>	<4B9E59B7.6060405@redhat.com> <20100315.120004.209998642.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:52317 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932117Ab0COTpt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Mar 2010 15:45:49 -0400
In-Reply-To: <20100315.120004.209998642.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: drepper@redhat.com, ralf@linux-mips.org, benh@kernel.crashing.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@teksavvy.com, torvalds@linux-foundation.org, munroesj@linux.vnet.ibm.com

On 03/15/2010 12:00 PM, David Miller wrote:
> From: Ulrich Drepper <drepper@redhat.com>
> Date: Mon, 15 Mar 2010 09:00:55 -0700
> 
>> On 03/15/2010 08:13 AM, H. Peter Anvin wrote:
>>> One option would be to do a libkernel.so,
>>
>> No need.  Put it in the vdso.  And name it something other than syscall.
>>  The syscall() API is fixed, you cannot change it.
>>
>> All this only if it makes sense for ALL archs.  If it cannot work for
>> just one arch then it's not worth it at all.
> 
> There are many archs that still lack VDSO.

Putting it into the vdso is also rather annoyingly heavyweight for what
is nothing other than an ordinary shared library.  Just making it an
ordinary shared library seems a lot saner.

I don't see why syscall() can't change the type for its first argument
-- it seems to be exactly what symbol versioning is for.

Doesn't change the fact that it is fundamentally broken, of course.

	-hpa
