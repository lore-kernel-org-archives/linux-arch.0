From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH -mm] clean up duplicated alloc/free_thread_info
Date: Wed, 4 Jun 2008 07:58:31 +0900
Message-ID: <20080604080135N.fujita.tomonori@lab.ntt.co.jp>
References: <20080603140620S.fujita.tomonori@lab.ntt.co.jp>
	<84144f020806022306h236a48cbv32b82cfa83fe4ee6@mail.gmail.com>
	<18500.59345.230174.727316@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:50925 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755925AbYFCW7M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Jun 2008 18:59:12 -0400
In-Reply-To: <18500.59345.230174.727316@cargo.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulus@samba.org
Cc: penberg@cs.helsinki.fi, fujita.tomonori@lab.ntt.co.jp, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org

On Tue, 3 Jun 2008 16:42:25 +1000
Paul Mackerras <paulus@samba.org> wrote:

> Pekka Enberg writes:
> 
> > Yeah, I too have wondered why some architectures use kmalloc() whereas
> > others use the page allocator. Is THREAD_SIZE significantly smaller
> > than PAGE_SIZE for those?
> 
> 64-bit powerpc uses 16k kernel stacks and either 4k or 64k page size.
> If the page size is 64k then we don't want to allocate a whole page
> for a kernel stack.

On powerpc, the patch defines __HAVE_ARCH_THREAD_INFO_ALLOCATOR on the
THREAD_SHIFT < PAGE_SHIFT case so it doesn't change anything.
