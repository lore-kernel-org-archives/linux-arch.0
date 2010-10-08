From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/5] bitops: add generic implementation of ext2 atomic
 bitops by test_and_{set,clear}_bit
Date: Fri, 8 Oct 2010 06:24:33 -0400
Message-ID: <20101008102433.GA24208@infradead.org>
References: <1286532193-29814-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1286532193-29814-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 08, 2010 at 07:03:09PM +0900, Akinobu Mita wrote:
> This introduces asm-generic header file for generic implementation of
> ext2 atomic bit operations by test_and_set_bit() and test_and_clear_bit().
> 
> alpha, arm, cris, frv, ia64, m68k, mn10300, parisc, powerpc, s390,
> sparc64, x86, xtensa can use this header file in its asm/bitops.h.

Care to rename the functions to le_* instead of ext2_* while you're at
it and documenting their semantics?
