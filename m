Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38361 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714AbZCFJOf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 6 Mar 2009 04:14:35 -0500
Subject: Re: [PATCH] generic debug pagealloc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090303133610.cb771fef.akpm@linux-foundation.org>
References: <20090303160103.GB5812@localhost.localdomain>
	 <20090303133610.cb771fef.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 06 Mar 2009 20:14:20 +1100
Message-ID: <1236330860.7260.128.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20090306091420.a3Rd0SFH8ZXuUUybMKFKVUTBShgXTUqWa6OAjI_Ok-g@z>

On Tue, 2009-03-03 at 13:36 -0800, Andrew Morton wrote:
> Alternatively, we could just not do the kmap_atomic() at all.  i386
> won't be using this code and IIRC the only other highmem architecture
> is powerpc32, and ppc32 appears to also have its own DEBUG_PAGEALLOC
> implementation.  So you could remove the kmap_atomic() stuff and put
> 
Actually, ppc32 DEBUG_PAGEALLOC is busted in several ways and probably
unfixable (though this is still being debated).

Cheers,
Ben.


