From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [patch] mm: rewrite vmap layer
Date: Wed, 20 Aug 2008 12:05:36 -0500
Message-ID: <48AC4EE0.4050603@linux-foundation.org>
References: <20080818133224.GA5258@wotan.suse.de> <48AADBDC.2000608@linux-foundation.org> <20080820090234.GA7018@wotan.suse.de> <48AC244F.1030104@linux-foundation.org> <20080820162235.GA26894@wotan.suse.de> <48AC4B41.8080908@linux-foundation.org> <20080820165947.GA19656@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54960 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757671AbYHTRFy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Aug 2008 13:05:54 -0400
In-Reply-To: <20080820165947.GA19656@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org

Nick Piggin wrote:
> On Wed, Aug 20, 2008 at 11:50:09AM -0500, Christoph Lameter wrote:
>> Nick Piggin wrote:
>>
>>> Indeed that would be a good use for it if this general fallback mechanism
>>> were to be merged.
>> Want me to rebase my virtualizable compound patchset on top of your vmap changes?
> 
> Is there much clash between them? Or just the fact that you'll have to
> use vm_map_ram/vm_unmap_ram?

There is not much of a clash. If you would make vmap/unmap atomic then there
is barely any overlap at all and the patchset becomes much smaller and even
the initial version of it can support in interrupt alloc / free.

> I probably wouldn't be able to find time to look at that patchset again
> for a while... but anyway, I've been running the vmap rewrite for quite
> a while on several different systems and workloads without problems, so
> it should be stable enough to test out. And the APIs should not change.

Yes I think this is good stuff. Hopefully I will get enough time to check it
out in detail.
