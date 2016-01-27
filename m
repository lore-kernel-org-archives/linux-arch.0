Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41580 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893AbcA0JRG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2016 04:17:06 -0500
Date: Wed, 27 Jan 2016 10:16:01 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/3] x86: query dynamic DEBUG_PAGEALLOC setting
In-Reply-To: <1453884618-33852-3-git-send-email-borntraeger@de.ibm.com>
Message-ID: <alpine.DEB.2.11.1601271015380.3886@nanos>
References: <1453884618-33852-1-git-send-email-borntraeger@de.ibm.com> <1453884618-33852-3-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, Joonsoo Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk
Message-ID: <20160127091601.vOpRRvTx_nUpTgD68Dq5-ahybp9EuQmP9yBbzAlHT2Q@z>

On Wed, 27 Jan 2016, Christian Borntraeger wrote:

> We can use debug_pagealloc_enabled() to check if we can map
> the identity mapping with 2MB pages. We can also add the state
> into the dump_stack output.
> 
> The patch does not touch the code for the 1GB pages, which ignored
> CONFIG_DEBUG_PAGEALLOC. Do we need to fence this as well?
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
