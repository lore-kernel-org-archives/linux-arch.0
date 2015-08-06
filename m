From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/7] test_user_copy improvements
Date: Thu, 6 Aug 2015 02:50:09 -0700
Message-ID: <20150806095009.GA8498@roeck-us.net>
References: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53957 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753433AbbHFJuO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Aug 2015 05:50:14 -0400
Content-Disposition: inline
In-Reply-To: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>

Hi James,

On Wed, Aug 05, 2015 at 04:48:48PM +0100, James Hogan wrote:
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
>   copies, copy_in_user, clear_user, the user string accessors, and the
>   user checksum functions, all of which need special handling in arch
>   code with EVA.
> 
> Tested on MIPS with and without EVA, and on x86_64.
> 
The series causes several build failures with other architectures.

From next-20150806:

Build results:
	total: 152 pass: 138 fail: 14
Failed builds:
	alpha:allmodconfig (*)
	arm:allmodconfig (*)
	arm:omap2plus_defconfig
	arm64:allmodconfig
	i386:allyesconfig (*)
	i386:allmodconfig (*)
	m68k:defconfig (*)
	m68k:allmodconfig (*)
	m68k:sun3_defconfig (*)
	mips:allmodconfig
	parisc:allmodconfig
	s390:allmodconfig
	sparc32:allmodconfig (*)
	xtensa:allmodconfig (*)

The builds marked with (*) fail because of your patch series.

Guenter
