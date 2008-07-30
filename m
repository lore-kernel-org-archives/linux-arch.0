From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: MMU notifiers review and some proposals
Date: Wed, 30 Jul 2008 10:42:12 -0500
Message-ID: <48908BD4.10408@linux-foundation.org>
References: <20080724143949.GB12897@wotan.suse.de> <20080725214552.GB21150@duo.random> <20080726030810.GA18896@wotan.suse.de> <20080726113813.GD21150@duo.random> <20080726122826.GA17958@wotan.suse.de> <20080726130202.GA9598@duo.random> <20080726131450.GC21820@wotan.suse.de> <48907880.3020105@linux-foundation.org> <20080730145436.GJ11494@duo.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42236 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753722AbYG3Pmf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Jul 2008 11:42:35 -0400
In-Reply-To: <20080730145436.GJ11494@duo.random>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Arcangeli <andrea@qumranet.com>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org, steiner@sgi.com

Andrea Arcangeli wrote:

> I think the current implementation is fine for the long run, it can
> provide the fastest performance when armed, and each invalidate either
> requires IPIs or it may may need to access the southbridge, so when
> freeing large areas of memory it's good being able to do a single
> invalidate.

Right. A couple of months ago we had this discussion and agreed that the begin / end was the way to go. I still support that decision.
