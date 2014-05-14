From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 00/25] Change time_t and clock_t to 64 bit
Date: Wed, 14 May 2014 14:04:03 -0700
Message-ID: <5373DA43.8070704@zytor.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com> <6202090.0OtAjefIFT@wuerfel> <CAFiDJ5-No1Uw6gxSDXvsv60iyxH=dZKaVTckyZLVEWYUpR504w@mail.gmail.com> <4803676.5b3DxkdLDT@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60240 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbaENVEo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 May 2014 17:04:44 -0400
In-Reply-To: <4803676.5b3DxkdLDT@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <lftan@altera.com>
Cc: Christoph Hellwig <hch@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>

On 05/14/2014 03:33 AM, Arnd Bergmann wrote:
>>
>> Hi Arnd,
>>
>> From your comment above, can I assume we don't need this patchset any more?
> 
> I won't require it, but it's not just my decision to make.
> 

Linus has pushed extremely hard for it, and it *is* his decision to
make.  If you want an authoritative answer I guess we need to wait until
Linus comes back.

> Let's see what Peter Anvin and Thomas Gleixner think about it, as they
> have argued strongly in favor of using 64-bit time_t for new architectures
> in the past.

I think it is downright looney to introduce a new ABI without a 64-bit
time_t at this point.

You are talking about a ktime_t; that is a kernel internal
implementation detail which can be changed later once the appropriate
kernel infrastructure is there, but we should make the change now to get
the external ABIs right, then we can microoptimize the kernel internal
implementation later.

	-hpa
