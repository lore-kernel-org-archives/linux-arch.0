Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:34107 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbXIDMmO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Sep 2007 08:42:14 -0400
Date: Tue, 4 Sep 2007 06:42:12 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Removal of dma_cache_* functions?
Message-ID: <20070904124212.GR14130@parisc-linux.org>
References: <20070904115615.GA14986@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070904115615.GA14986@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 04, 2007 at 12:56:16PM +0100, Ralf Baechle wrote:
> Most architectures implement the dma_cache_wback, dma_cache_wback_inv
> and dma_cache_wback_inv functions even though there is the more modern
> and much better designed DMA API and only two MIPS-specific users (one of
> which I just fixed) do remain.  So should we finally start removing it?

There's still some users in arch/, but yes, let's remove it from the
arches that don't use it internally.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
