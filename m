From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/6] mm: add coherence API for DMA to vmalloc/vmap areas
Date: Wed, 18 Nov 2009 15:38:15 +0100
Message-ID: <20091118143815.GA17146@linux-mips.org>
References: <1258477432-2513-1-git-send-email-James.Bottomley@suse.de> <1258477432-2513-2-git-send-email-James.Bottomley@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1258477432-2513-2-git-send-email-James.Bottomley@suse.de>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
