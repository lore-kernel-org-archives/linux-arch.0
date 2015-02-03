From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC] change non-atomic bitops method
Date: Mon, 2 Feb 2015 22:38:51 -0800
Message-ID: <20150202223851.f30768d0.akpm@linux-foundation.org>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
	<20150202152909.13bfd11f192fb0268b2ab4bf@linux-foundation.org>
	<20150203011730.GA15653@node.dhcp.inet.fi>
	<35FD53F367049845BC99AC72306C23D1044A02027E0B@CNBJMBX05.corpusers.net>
	<35FD53F367049845BC99AC72306C23D1044A02027E0C@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:39392 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932187AbbBCGjR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Feb 2015 01:39:17 -0500
In-Reply-To: <35FD53F367049845BC99AC72306C23D1044A02027E0C@CNBJMBX05.corpusers.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: "'Kirill A. Shutemov'" <kirill@shutemov.name>, "'arnd@arndb.de'" <arnd@arndb.de>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux@arm.linux.org.uk'" <linux@arm.linux.org.uk>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>

On Tue, 3 Feb 2015 13:42:45 +0800 "Wang, Yalin" <Yalin.Wang@sonymobile.com> wrote:
>
> ...
>
> #ifdef CHECK_BEFORE_SET
> 			if (p[i] != times)
> #endif
>
> ...
>
> ----
> One run on CPU0, reader thread run on CPU1,
> Test result:
> sudo ./cache_test
> reader:8.426228173
> 8.672198335
> 
> With -DCHECK_BEFORE_SET
> sudo ./cache_test_check
> reader:7.537036819
> 10.799746531
> 

You aren't measuring the right thing.  You should compare

	if (p[i] != x)
		p[i] = x;

versus

	p[i] = x;

and you should do this for two cases:

a) p[i] == x

b) p[i] != x


The first code sequence will be slower when (p[i] != x) and faster when
(p[i] == x).


Next, we should instrument the kernel to work out the frequency of
set_bit on an already-set bit.

It is only with both these ratios that we can work out whether the
patch is a net gain.  My suspicion is that set_bit on an already-set
bit is so rare that the patch will be a loss.
