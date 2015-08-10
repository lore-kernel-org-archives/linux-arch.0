From: David Miller <davem@redhat.com>
Subject: Re: [PATCH v2 00/11] test_user_copy improvements
Date: Mon, 10 Aug 2015 15:29:38 -0700 (PDT)
Message-ID: <20150810.152938.1076489414700359615.davem@redhat.com>
References: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47759 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932929AbbHJW3m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 10 Aug 2015 18:29:42 -0400
In-Reply-To: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: james.hogan@imgtec.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, keescook@chromium.org, akpm@linux-foundation.org, monstr@monstr.eu, lftan@altera.com, jonas@southpole.se, chris@zankel.net, jcmvbkbc@gmail.com, nios2-dev@lists.rocketboards.org, linux@lists.openrisc.net, linux-xtensa@linux-xtensa.org

From: James Hogan <james.hogan@imgtec.com>
Date: Fri, 7 Aug 2015 16:21:53 +0100

> These patches extend the test_user_copy test module to handle lots more
> cases of user accessors which architectures can override separately, and
> in particular those which are important for checking the MIPS Enhanced
> Virtual Addressing (EVA) implementations, which need to handle
> overlapping user and kernel address spaces, with special instructions
> for accessing user address space from kernel mode.
> 
> - Checking that kernel pointers are accepted when user address limit is
>   set to KERNEL_DS, as done by the kernel when it internally invokes
>   system calls with kernel pointers.
> - Checking of the unchecked accessors (which don't call access_ok()).
>   Some of the tests are special cased for EVA at the moment which has
>   stricter hardware guarantees for bad user accesses than other
>   configurations.
> - Checking of other sets of user accessors, including the inatomic user
>   copies, clear_user, compatibility accessors (copy_in_user and
>   _unaligned), the user string accessors, and the user checksum
>   functions, all of which need special handling in arch code with EVA.
> 
> Tested on MIPS with and without EVA, and on x86_64.
> 
> Only build tested for arm, blackfin, metag, microblaze, openrisc,
> parisc, powerpc, sh, sparc, tile, i386 & xtensa.
> 
> All arches were audited for the appropriate exports, only score is known
> to still be missing some.

James, thanks for doing this work.

If I understand the MIPS EVA facility correctly, it operates exactly like
how sparc64 does.  Wherein user and kernel virtual addresses are fully
segregated, and one must use a specially tagged load or store to access
user addresses.

This actually creates problems for the tests as currently coded on
such systems (this problem existed before your changes).  You might
not be triggering this problem on MIPS EV but it certainly is there.

For example, consider this test:

	ret |= test(!copy_from_user(bad_usermem, (char __user *)kmem,
				    PAGE_SIZE),
		    "illegal reversed copy_from_user passed");

If the 'kmem' access faults, we will try to zero out PAGE_SIZE bytes
at 'bad_usermem'.  But this is not necessarily going to fail.

The user address 'bad_usermem', on MIPS EV and sparc64, could just as
equally happen to be a legitimate kernel address.  So this clear will
succeed and we will end up clearing memory at an arbitrary kernel
address.

There is no real way to trap this situation as a native load/store
will work just fine on these addresses.

I don't have a good suggestion other than to say that these tests
seem to only be valid in a combined kernel/user address space, ie.
for systems other than MIPS EV and sparc64.

Also, I think the tests you added and protected with MIPS ifdefs could
equally be enabled on sparc64.

Thanks!
