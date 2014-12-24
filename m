Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:53520 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbaLXRXK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Dec 2014 12:23:10 -0500
Date: Wed, 24 Dec 2014 17:23:00 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 11/38] arm64: drop PTE_FILE and pte_file()-related helpers
Message-ID: <20141224172300.GF13399@e104818-lin.cambridge.arm.com>
References: <1419423766-114457-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1419423766-114457-12-git-send-email-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1419423766-114457-12-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@kernel.org" <mingo@kernel.org>, "davej@redhat.com" <davej@redhat.com>, "sasha.levin@oracle.com" <sasha.levin@oracle.com>, "hughd@google.com" <hughd@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>
Message-ID: <20141224172300.F9RytCnQ4npsqA-aOFZnt8z9mnbMp4fNVZt1X1GRChY@z>

On Wed, Dec 24, 2014 at 12:22:19PM +0000, Kirill A. Shutemov wrote:
> We've replaced remap_file_pages(2) implementation with emulation.
> Nobody creates non-linear mapping anymore.
> 
> This patch also adjust __SWP_TYPE_SHIFT and increase number of bits
> availble for swap offset.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

I haven't looked at the remap_file_pages() code but since the pte_file
is no longer needed:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
