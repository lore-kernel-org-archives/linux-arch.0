From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC][PATCH 3/3] math128, x86_64: Implement {mult,add}_u128 in
 64bit asm
Date: Tue, 24 Apr 2012 10:20:43 -0700
Message-ID: <4F96E0EB.7030904@zytor.com>
References: <20120424161039.293018424@chello.nl>   <20120424162224.588822231@chello.nl> <4F96D604.5050709@zytor.com>  <1335285395.28150.204.camel@twins> <4F96E01E.6040109@zytor.com> <1335287973.28150.213.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:35918 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755811Ab2DXRU6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Apr 2012 13:20:58 -0400
In-Reply-To: <1335287973.28150.213.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On 04/24/2012 10:19 AM, Peter Zijlstra wrote:
>>
>> Yes, but this is specific to x86-64.  If gcc can generate the code it
>> can also schedule the code, which it can't for assembly...
> 
> Ok, but are you sure unsigned __int128 works for all gcc versions we
> support?
> 

I have been told __int128 works for all versions of gcc which support
x86-64, but I haven't verified it myself, no.

	-hpa
