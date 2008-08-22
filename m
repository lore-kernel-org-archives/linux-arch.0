From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: + separate-atomic_t-declaration-from-asm-atomich-into-asm-atomic_defh.patch added to -mm tree
Date: Fri, 22 Aug 2008 15:36:25 -0600
Message-ID: <20080822213624.GX8318@parisc-linux.org>
References: <200808222056.m7MKucHA016131@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:34024 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758592AbYHVVg0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Aug 2008 17:36:26 -0400
Content-Disposition: inline
In-Reply-To: <200808222056.m7MKucHA016131@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, ying.huang@intel.com, linux-arch@vger.kernel.org

On Fri, Aug 22, 2008 at 01:56:38PM -0700, akpm@linux-foundation.org wrote:
> Subject: Separate atomic_t declaration from asm/atomic.h into asm/atomic_def.h
> From: Huang Ying <ying.huang@intel.com>
> 
> asm/atomic.h contains both declaration and implementation of atomic_t.  So
> there are some implementation related files included in asm/atomic.h.  And
> atomic_t is a typedef.  Combination of above makes it impossible to use
> atomic_t in files included by atomic.h.  Such as atomic_t can not be used
> in linux/kernel.h on i386, because it is included by asm/atomic.h.
> 
> It is reasonable to separate declaration from implementation.  So a new
> file atomic_def.h is added for every architecture to accommodate the
> declaration of atomic_t.

Seems to me like all architectures could use:

+++ include/linux/atomic_type.h
+typedef struct { volatile int counter; } atomic_t;
+#ifdef CONFIG_64BIT
+typedef struct { volatile long counter; } atomic64_t;
+#endif

S390 has an __aligned__((4)) on theirs -- is this really necessary?
Doesn't s390 align ints to 4 bytes automatically?  If it doesn't, it
shouldn't be harmful to add it to other architectures (iirc m68k only
requires 2-byte alignment for ints ... hmm, wonder if their atomic_t is
really atomic if, say, it cross a page boundary ...)

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
