From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: The type of bitops
Date: Mon, 06 May 2013 18:36:32 -0700
Message-ID: <51885AA0.4090807@zytor.com>
References: <51884263.4020608@zytor.com> <CA+55aFzwjQ03ZA71rgKMhCqh_+1fcMbPJUK3upcOacX2F8+Z9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:49235 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758214Ab3EGBgt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 6 May 2013 21:36:49 -0400
In-Reply-To: <CA+55aFzwjQ03ZA71rgKMhCqh_+1fcMbPJUK3upcOacX2F8+Z9A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On 05/06/2013 05:51 PM, Linus Torvalds wrote:
> 
>> 4. Do some macro hacks so the bitops are dependent on the size of the
>>    argument.
> 
> That sounds insane. Just *how* could the size of the argument even
> matter? Seriously, there's no *difference* between a 32-bit or a
> 64-bit index. The code is the same, there's no possible reason to make
> it be different.
> 

The only reason on x86 would be to avoid the REX prefix.  Hardly worth
it, though.

	-hpa
