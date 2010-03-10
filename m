From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [to-be-updated]
	add-a-kernel_address-that-works-for-data-too.patch removed from -mm
	tree
Date: Wed, 10 Mar 2010 20:43:47 +0000
Message-ID: <20100310204346.GC24353@flint.arm.linux.org.uk>
References: <201003102029.o2AKTg4K001911@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40868 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab0CJUom (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Mar 2010 15:44:42 -0500
Content-Disposition: inline
In-Reply-To: <201003102029.o2AKTg4K001911@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: andi@firstfloor.org, ak@linux.intel.com, ebiederm@xmission.com, linux-arch@vger.kernel.org, rusty@rustcorp.com.au, sam@ravnborg.org, mm-commits@vger.kernel.org

On Wed, Mar 10, 2010 at 12:29:42PM -0800, akpm@linux-foundation.org wrote:
> 
> The patch titled
>      add a kernel_address() that works for data too
> has been removed from the -mm tree.  Its filename was
>      add-a-kernel_address-that-works-for-data-too.patch
> 
> This patch was dropped because an updated version will be merged
> 
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: add a kernel_address() that works for data too
> From: Andi Kleen <andi@firstfloor.org>
> 
> Add a variant of kernel_text_address() that includes kernel data.
> 
> Assumes kernel is _text ... _end - init section. True everywhere?

No, it is not.  ARM XIP has text in one area, and the data in RAM.

There are two distinct sections:

_text .. _etext
_data .. _end

They both exclude the init sections on ARM, except when XIP is enabled
where the init data appears inside _data .. _end, and is demarked by
__init_begin .. __init_end.

Final point is that we end up with the Dwarf2 unwind tables after the
_etext, but not included in _data - I don't think that matters though.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
