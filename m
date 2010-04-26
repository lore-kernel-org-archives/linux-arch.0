Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:52468 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab0DZPAt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 26 Apr 2010 11:00:49 -0400
Date: Mon, 26 Apr 2010 11:00:43 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [patch 10/14] parisc: invoke oom-killer from page fault
Message-ID: <20100426150042.GR12768@bombadil.infradead.org>
References: <20100422160613.723698029@suse.de> <20100422161224.322033236@suse.de> <alpine.DEB.2.00.1004221356150.25350@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1004221356150.25350@chino.kir.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: npiggin@suse.de, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-parisc@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>
Message-ID: <20100426150043.O15iiX-rMIfoK-jEt37TLUMxvFsxIPoK6Pe68O969_U@z>

On Thu, Apr 22, 2010 at 01:56:26PM -0700, David Rientjes wrote:
> On Fri, 23 Apr 2010, npiggin@suse.de wrote:
> 
> > As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> > oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> > simply killing current.
> > 
> > Cc: linux-parisc@vger.kernel.org
> > Cc: Kyle McMartin <kyle@mcmartin.ca>
> > Cc: linux-arch@vger.kernel.org
> > Signed-off-by: Nick Piggin <npiggin@suse.de>
> 
> Acked-by: David Rientjes <rientjes@google.com>

Thanks, applied.
