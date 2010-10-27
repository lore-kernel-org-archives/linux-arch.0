Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10998 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755732Ab0J0LPu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Oct 2010 07:15:50 -0400
Message-ID: <b9dded$gtgeib@orsmga002.jf.intel.com>
Date: Wed, 27 Oct 2010 12:15:45 +0100
Subject: Re: [PATCH] mm,x86: fix kmap_atomic_push vs ioremap_32.c
References: <20100918155326.478277313@chello.nl> <849307$a582r7@azsmga001.ch.intel.com> <1288175638.15336.1538.camel@twins>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <1288175638.15336.1538.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Message-ID: <20101027111545.VZAP52WnrHLzRauXwFa_0pRU-L7f9rFRrc9mkkyKBvc@z>

On Wed, 27 Oct 2010 12:33:58 +0200, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> Christoph just complained about the same on IRC, the below seems to cure
> things for i386-defconfig with CONFIG_HIGHMEM=n

Compiles and boots on the misbehaving box.
Thanks,
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
