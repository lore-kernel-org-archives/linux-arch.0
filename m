Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:40118 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbYCCGWk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Mar 2008 01:22:40 -0500
Message-ID: <47CB96D5.3030509@zytor.com>
Date: Sun, 02 Mar 2008 22:12:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] Add C99-style constructor macros for specific-sized
 integers
References: <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org> <20080303023851.GF24386@parisc-linux.org> <47CB81EA.8070802@zytor.com> <20080303062007.GY27894@ZenIV.linux.org.uk>
In-Reply-To: <20080303062007.GY27894@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>
Message-ID: <20080303061237.83tsKXQ2Cz-HFEY_0LOPA6WLpS8SGKLlTthDbqyg6sU@z>

Al Viro wrote:
> On Sun, Mar 02, 2008 at 08:43:22PM -0800, H. Peter Anvin wrote:
>>>> +#define S64_C(x) x ## LL
>>>> +#define U64_C(x) x ## ULL
>>> but can't we use the latter for all arches?
>>>
>> You really don't want to, as the whole point is that you want it to 
>> match what u64/s64 is defined as, in order to avoid spurious warnings.
> 
> Excuse me, in which contexts?  Where does replacement of explicitly long
> constant with explicitly long long one generate warnings on a host that has
> range(long) equal to range(long long)?

printf, for example.

	-hpa
