From: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH (resend)] block layer zero-copy: missing
 access_ok() check
Date: Thu, 21 Mar 2013 17:33:13 -0400 (EDT)
Message-ID: <20130321.173313.827411684773319604.davem@davemloft.net>
References: <CA+55aFxW0vkpgJCpJVJVqDmDG61P_AOoVMFVhfqVxM45Mj-LNA@mail.gmail.com>
	<20130315171000.GA2342@Krystal>
	<CA+55aFyrj9LsRp2gaoy1Lo6+s_brWjeKDG8F8JOLk2VaKndeaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:47336 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461Ab3CUVdQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Mar 2013 17:33:16 -0400
In-Reply-To: <CA+55aFyrj9LsRp2gaoy1Lo6+s_brWjeKDG8F8JOLk2VaKndeaQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: mathieu.desnoyers@efficios.com, linux-arch@vger.kernel.org, axboe@kernel.dk, security@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, npiggin@kernel.dk

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Mar 2013 10:21:41 -0700

> Adding linux-arch. Guys, can you check your architectures?
 ...
>> * sparc: access_ok missing in get_user_pages_fast,
>>   -> no indication of any _PAGE_USER flag.

Well, access_ok() returns 1 unconditionally on sparc64.  I can add a
call there if you want.  :-)

And that's because the user virtual address space is %100 segregated
from the privileged one.  There are no "user address ranges"
vs. kernel ones.

For example, we can and do give 64-bit processes the full 64-bit
virtual address space for user mappings.

The page tables, outside of swapper_pg_dir, only map user pages.
