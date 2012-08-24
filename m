Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:54809 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349Ab2HXWBz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Aug 2012 18:01:55 -0400
Date: Fri, 24 Aug 2012 15:01:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm: hugetlb: add arch hook for clearing page flags
 before entering pool
Message-ID: <20120824150154.fc16a78e.akpm@linux-foundation.org>
In-Reply-To: <20120823173602.GA3117@mudshark.cambridge.arm.com>
References: <1345739833-25008-1-git-send-email-will.deacon@arm.com>
	<20120823171156.GE19968@dhcp22.suse.cz>
	<20120823173602.GA3117@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Michal Hocko <mhocko@suse.cz>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20120824220154.z1RsLvNfPoyF7_F04jBvqkNmrYe8sdmVfADXDL4i14o@z>

On Thu, 23 Aug 2012 18:36:02 +0100
Will Deacon <will.deacon@arm.com> wrote:

> On Thu, Aug 23, 2012 at 06:11:56PM +0100, Michal Hocko wrote:
> > On Thu 23-08-12 17:37:13, Will Deacon wrote:
> > > The core page allocator ensures that page flags are zeroed when freeing
> > > pages via free_pages_check. A number of architectures (ARM, PPC, MIPS)
> > > rely on this property to treat new pages as dirty with respect to the
> > > data cache and perform the appropriate flushing before mapping the pages
> > > into userspace.
> > > 
> > > This can lead to cache synchronisation problems when using hugepages,
> > > since the allocator keeps its own pool of pages above the usual page
> > > allocator and does not reset the page flags when freeing a page into
> > > the pool.
> > > 
> > > This patch adds a new architecture hook, arch_clear_hugepage_flags, so
> > > that architectures which rely on the page flags being in a particular
> > > state for fresh allocations can adjust the flags accordingly when a
> > > page is freed into the pool.

You could have used __weak here quite neatly, but whatever.

> Next step: start posting the ARM code!

I suggest you keep this patch in whichever tree holds that arm code.  If
I see this patch turn up in linux-next then I'll just drop my copy,
expecting that this patch will be merged alongside the ARM changes.

