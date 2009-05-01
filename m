From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC][PATCH 32/35] Move users to asm-generic/ptemap.h
Date: Fri, 1 May 2009 13:43:31 -0400
Message-ID: <20090501174331.GA8104@infradead.org>
References: <20090501144201.D31EF417@kernel> <20090501144251.62441D55@kernel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:50461 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754417AbZEARnc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 13:43:32 -0400
Content-Disposition: inline
In-Reply-To: <20090501144251.62441D55@kernel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 01, 2009 at 07:42:51AM -0700, Dave Hansen wrote:
> 
> Now that we have everyone using pte_offset_kernel(),
> we can plainy see that almost all the users are
> exactly the same.
> 
> This takes all of those users and moves them over to
> using asm-generic/ptemap.h instead.

s/users/implementations/g ?

Also asm-generic/ptemap.h really wants a comment when architectures
can use this generic version.
