Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:49887 "EHLO
	eddie.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757273AbZKROiM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2009 09:38:12 -0500
Date: Wed, 18 Nov 2009 15:38:15 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/6] mm: add coherence API for DMA to vmalloc/vmap areas
Message-ID: <20091118143815.GA17146@linux-mips.org>
References: <1258477432-2513-1-git-send-email-James.Bottomley@suse.de> <1258477432-2513-2-git-send-email-James.Bottomley@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1258477432-2513-2-git-send-email-James.Bottomley@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@suse.de>
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
Message-ID: <20091118143815.ePpr4reZ0zHHyEFzK7DwLOvi70NNZPvLS8sv7wg0Npw@z>

On Tue, Nov 17, 2009 at 11:03:47AM -0600, James Bottomley wrote:

> On Virtually Indexed architectures (which don't do automatic alias
> resolution in their caches), we have to flush via the correct
> virtual address to prepare pages for DMA.  On some architectures
> (like arm) we cannot prevent the CPU from doing data movein along
> the alias (and thus giving stale read data), so we not only have to
> introduce a flush API to push dirty cache lines out, but also an invalidate
> API to kill inconsistent cache lines that may have moved in before
> DMA changed the data

The API looks right for MIPS and trivial to implement based on existing
code, so feel free to throw in my Ack on the generic parts.

The new APIs deserve documentation in Documentation/cachetlb.txt.

  Ralf
