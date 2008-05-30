From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 27/41] cpu alloc: Remove the allocpercpu functionality
Date: Thu, 29 May 2008 21:58:50 -0700
Message-ID: <20080529215850.7c95356e.akpm@linux-foundation.org>
References: <20080530035620.587204923@sgi.com>
	<20080530040020.139375468@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51326 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754428AbYE3E7H (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 00:59:07 -0400
In-Reply-To: <20080530040020.139375468@sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

On Thu, 29 May 2008 20:56:47 -0700 Christoph Lameter <clameter@sgi.com> wrote:

> There is no user of allocpercpu left after all the earlier patches were
> applied. Remove the allocpercpu code.

Wow.

y:/usr/src/25> grep alloc_percpu patches/*.patch
y:/usr/src/25> 

we might just be able to get away with doing this.

But it might make life easier to defer the removal of the old stuff for
a while.  This can be worked out later.
