Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:48749 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757296Ab0JHKmF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Oct 2010 06:42:05 -0400
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1P4AOq-00065t-BA
	for linux-arch@vger.kernel.org; Fri, 08 Oct 2010 10:42:04 +0000
Date: Fri, 8 Oct 2010 06:24:33 -0400
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/5] bitops: add generic implementation of ext2 atomic
 bitops by test_and_{set,clear}_bit
Message-ID: <20101008102433.GA24208@infradead.org>
References: <1286532193-29814-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1286532193-29814-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20101008102433.02g6QoU_PbwzIsj8Sjb3Zx5BD4Xb4mjDDt1ObVPi5CU@z>

On Fri, Oct 08, 2010 at 07:03:09PM +0900, Akinobu Mita wrote:
> This introduces asm-generic header file for generic implementation of
> ext2 atomic bit operations by test_and_set_bit() and test_and_clear_bit().
> 
> alpha, arm, cris, frv, ia64, m68k, mn10300, parisc, powerpc, s390,
> sparc64, x86, xtensa can use this header file in its asm/bitops.h.

Care to rename the functions to le_* instead of ext2_* while you're at
it and documenting their semantics?

