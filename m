From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 32/35] Move users to asm-generic/ptemap.h
Date: Fri, 01 May 2009 11:08:58 -0700
Message-ID: <1241201338.29485.205.camel@nimitz>
References: <20090501144201.D31EF417@kernel>
	 <20090501144251.62441D55@kernel>  <20090501174331.GA8104@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:48199 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755527AbZEASJB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 1 May 2009 14:09:01 -0400
In-Reply-To: <20090501174331.GA8104@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2009-05-01 at 13:43 -0400, Christoph Hellwig wrote:
> On Fri, May 01, 2009 at 07:42:51AM -0700, Dave Hansen wrote:
> > Now that we have everyone using pte_offset_kernel(),
> > we can plainy see that almost all the users are
> > exactly the same.
> > 
> > This takes all of those users and moves them over to
> > using asm-generic/ptemap.h instead.
> 
> s/users/implementations/g ?

Yeah, that's clearer.

> Also asm-generic/ptemap.h really wants a comment when architectures
> can use this generic version.

/*
 * If your architecture has direct-mapped PTE pages (no HIGHPTE)
 * then you just need to implement pte_offset_kernel() and include
 * this in your asm/ptemap.h.
 *
 * To support HIGHPTE, you need to have implementations of
 * kmap_atomic_pte() (which usually just calls kmap_atomic()),
 * pmd_page() and pmd_index().
 */


-- Dave
