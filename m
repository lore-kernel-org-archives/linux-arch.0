From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.29 -mm merge plans
Date: Tue, 6 Jan 2009 15:08:04 -0800
Message-ID: <20090106150804.2697e0c2.akpm@linux-foundation.org>
References: <20090105004300.19ed52d1.akpm@linux-foundation.org>
	<20090106225744.GA10553@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39348 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750923AbZAFXIm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jan 2009 18:08:42 -0500
In-Reply-To: <20090106225744.GA10553@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <npiggin@suse.de>, linux-arch@vger.kernel.org

(suitable cc's added)

On Tue, 6 Jan 2009 17:57:44 -0500
Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Jan 05, 2009 at 12:43:00AM -0800, Andrew Morton wrote:
> > mm-invoke-oom-killer-from-page-fault.patch
> > mm-invoke-oom-killer-from-page-fault-fix.patch
> > mm-invoke-oom-killer-from-page-fault-fix-fix-2.patch
> 
> Just implementing this behaviour for x86 and uml is extremly
> counter-productive.  Please fix up all architectures as this
> behaviour needs to be the same on all ports (at least those
> with a MMU)

Yes, that would be nice.  
