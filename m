From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch] mm: rewrite vmap layer
Date: Wed, 20 Aug 2008 18:59:47 +0200
Message-ID: <20080820165947.GA19656@wotan.suse.de>
References: <20080818133224.GA5258@wotan.suse.de> <48AADBDC.2000608@linux-foundation.org> <20080820090234.GA7018@wotan.suse.de> <48AC244F.1030104@linux-foundation.org> <20080820162235.GA26894@wotan.suse.de> <48AC4B41.8080908@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:51004 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756511AbYHTQ7t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Aug 2008 12:59:49 -0400
Content-Disposition: inline
In-Reply-To: <48AC4B41.8080908@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org

On Wed, Aug 20, 2008 at 11:50:09AM -0500, Christoph Lameter wrote:
> Nick Piggin wrote:
> 
> > Indeed that would be a good use for it if this general fallback mechanism
> > were to be merged.
> 
> Want me to rebase my virtualizable compound patchset on top of your vmap changes?

Is there much clash between them? Or just the fact that you'll have to
use vm_map_ram/vm_unmap_ram?

I probably wouldn't be able to find time to look at that patchset again
for a while... but anyway, I've been running the vmap rewrite for quite
a while on several different systems and workloads without problems, so
it should be stable enough to test out. And the APIs should not change.
