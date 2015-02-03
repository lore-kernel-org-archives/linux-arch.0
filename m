From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC] change non-atomic bitops method
Date: Tue, 3 Feb 2015 02:59:25 -0800
Message-ID: <20150203025925.d1c95fb8.akpm@linux-foundation.org>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
	<20150202152909.13bfd11f192fb0268b2ab4bf@linux-foundation.org>
	<20150203011730.GA15653@node.dhcp.inet.fi>
	<35FD53F367049845BC99AC72306C23D1044A02027E0B@CNBJMBX05.corpusers.net>
	<35FD53F367049845BC99AC72306C23D1044A02027E0C@CNBJMBX05.corpusers.net>
	<20150202223851.f30768d0.akpm@linux-foundation.org>
	<35FD53F367049845BC99AC72306C23D1044A02027E0D@CNBJMBX05.corpusers.net>
	<35FD53F367049845BC99AC72306C23D1044A02027E0E@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42831 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587AbbBCK7w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Feb 2015 05:59:52 -0500
In-Reply-To: <35FD53F367049845BC99AC72306C23D1044A02027E0E@CNBJMBX05.corpusers.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: "'Kirill A. Shutemov'" <kirill@shutemov.name>, "'arnd@arndb.de'" <arnd@arndb.de>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux@arm.linux.org.uk'" <linux@arm.linux.org.uk>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>

On Tue, 3 Feb 2015 16:42:14 +0800 "Wang, Yalin" <Yalin.Wang@sonymobile.com> wrote:

> I make a change in kernel to test hit/miss ratio:

Neat, thanks.

>
> ...
>
> After use the phone some time:
> root@D5303:/ # cat /proc/meminfo
> VmallocUsed:       10348 kB
> VmallocChunk:      75632 kB
> __set_bit_miss_count:10002 __set_bit_success_count:1096661
> __clear_bit_miss_count:359484 __clear_bit_success_count:3674617
> __test_and_set_bit_miss_count:7 __test_and_set_bit_success_count:221
> __test_and_clear_bit_miss_count:924611 __test_and_clear_bit_success_count:193
> 
> __test_and_clear_bit_miss_count has a very high miss rate.
> In fact, I think set/clear/test_and_set(clear)_bit atomic version can also
> Be investigated to see its miss ratio,
> I have not tested the atomic version,
> Because it reside in different architectures.

Hopefully misses in test_and_X_bit are not a problem.  The CPU
implementation would be pretty stupid to go and dirty the cacheline
when it knows it didn't change anything.  But maybe I'm wrong about
that.  

That we're running clear_bit against a cleared bit 10% of the time is a
bit alarming.  I wonder where that's coming from.

The enormous miss count in test_and_clear_bit() might indicate an
inefficiency somewhere.
