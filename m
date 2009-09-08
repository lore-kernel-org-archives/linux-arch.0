Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52553 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753788AbZIHOOt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2009 10:14:49 -0400
Date: Tue, 8 Sep 2009 07:13:55 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 7/8] mm: reinstate ZERO_PAGE
In-Reply-To: <20090908073119.GA29902@wotan.suse.de>
Message-ID: <alpine.LFD.2.01.0909080712200.7458@localhost.localdomain>
References: <Pine.LNX.4.64.0909072222070.15424@sister.anvils> <Pine.LNX.4.64.0909072238320.15430@sister.anvils> <20090908073119.GA29902@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh.dickins@tiscali.co.uk>, Andrew Morton <akpm@linux-foundation.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20090908141355.jjBS9ebrAGiifrv1MEEp_3zUb3dz4e9cdhjvUb7nC7c@z>



On Tue, 8 Sep 2009, Nick Piggin wrote:
> 
> Without looking closely, why is it a big problem to have a
> !HAVE PTE SPECIAL case? Couldn't it just be a check for
> pfn == zero_pfn that is conditionally compiled away for pte
> special architectures anyway?

At least traditionally, there wasn't a single zero_pfn, but multiple (for 
VIPT caches that have performance issues with aliases). But yeah, we could 
check just the pfn number, and allow any architecture to do it.

			Linus
