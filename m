From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 00/11] test_user_copy improvements
Date: Tue, 11 Aug 2015 10:32:28 -0700 (PDT)
Message-ID: <20150811.103228.1155026747582145108.davem@davemloft.net>
References: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
	<20150810.152938.1076489414700359615.davem@redhat.com>
	<55C9D768.7060409@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:50403 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbbHKRca (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 11 Aug 2015 13:32:30 -0400
In-Reply-To: <55C9D768.7060409@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: james.hogan@imgtec.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, keescook@chromium.org, akpm@linux-foundation.org, monstr@monstr.eu, lftan@altera.com, jonas@southpole.se, chris@zankel.net, jcmvbkbc@gmail.com, nios2-dev@lists.rocketboards.org, linux@lists.openrisc.net, linux-xtensa@linux-xtensa.org

From: James Hogan <james.hogan@imgtec.com>
Date: Tue, 11 Aug 2015 12:07:20 +0100

> Out of interest, is the zeroing a strict requirement for correct use, or
> a safety precaution to prevent data leakage in case of bad error checking?
> 
> (A quick look reveals that for copy_from_user() when access_ok() fails,
> only arm, arm64, frv, m32r, m68k, sparc, tile, x86, and xtensa do this).

It is required, otherwise the kernel buffer is left partially initialized
which can lead to security bugs.

> That's a good point. The reversed tests aren't really safe in that case.
> With MIPS EVA the user address is very likely to be a valid
> non-TLB-mapped address to kernel mode, and will zero arbitrary memory.
> They could also potentially crash the kernel if user memory isn't
> normally kernel accessible and the arch doesn't fix up faults for the
> kernel accesses (not EVA, but maybe sparc64?).

Sparc64 would fault on an invalid kernel address, but the problem here
is that the addresses are actually valid kernel ones.

> It is also possible (though less likely) that the kernel address will
> have a valid user mapping at the same address, so the reversed
> copy_to_user test may well leak arbitrary kernel memory to user memory
> without faulting.

Yes, this is also a problem.

>> Also, I think the tests you added and protected with MIPS ifdefs could
>> equally be enabled on sparc64.
> 
> Yes, it sounds like it. I'll try the ARCH_SPLIT_VA_SPACE idea.

Great!
