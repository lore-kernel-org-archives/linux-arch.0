Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:12717 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889Ab0J0K2D (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Oct 2010 06:28:03 -0400
Message-ID: <849307$a582r7@azsmga001.ch.intel.com>
Date: Wed, 27 Oct 2010 11:27:57 +0100
Subject: Re: [PATCH 0/5] mm, highmem: kmap_atomic rework -v3
References: <20100918155326.478277313@chello.nl>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20100918155326.478277313@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20101027102757.xuUEW-w_zyJuzNV4svWfNGLINkF6qcbWUt1NusVvjXg@z>

On Sat, 18 Sep 2010 17:53:26 +0200, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> Next version of the kmap_atomic rework using Andrew's fancy CPP trickery to
> avoid having to convert the whole tree at once.
> 
> This is compile tested for i386-allmodconfig, frv, mips-sb1250-swarm,
> powerpc-ppc6xx_defconfig, sparc32_defconfig, arm-omap3 (all with
> HIGHEM=y).

This break on x86, HIGHMEM=n:

arch/x86/mm/iomap_32.c: In function ‘kmap_atomic_prot_pfn’:
arch/x86/mm/iomap_32.c:64: error: implicit declaration of function
‘kmap_atomic_idx_push’
arch/x86/mm/iomap_32.c: In function ‘iounmap_atomic’:
arch/x86/mm/iomap_32.c:101: error: implicit declaration of function
‘kmap_atomic_idx_pop’

The use of the kmap idx there looks a little delicate so I'm not sure how
to fix this.
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
