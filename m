Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:59210 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbaLXOQU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Dec 2014 09:16:20 -0500
Date: Wed, 24 Dec 2014 15:15:24 +0100
From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 13/38] avr32: drop _PAGE_FILE and pte_file()-related
 helpers
Message-ID: <20141224141524.GA3091@samfundet.no>
References: <1419423766-114457-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1419423766-114457-14-git-send-email-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1419423766-114457-14-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, mingo@kernel.org, davej@redhat.com, sasha.levin@oracle.com, hughd@google.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@gmail.com>
Message-ID: <20141224141524.j2Wp_4diVD8renZUP3WFhivwrtBlWLr8O88_eC7SB8E@z>

Around Wed 24 Dec 2014 14:22:21 +0200 or thereabout, Kirill A. Shutemov wrote:
> We've replaced remap_file_pages(2) implementation with emulation.
> Nobody creates non-linear mapping anymore.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> ---
>  arch/avr32/include/asm/pgtable.h | 25 -------------------------
>  1 file changed, 25 deletions(-)

Oooh, 25 lines less code, fantastic.

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

<snipp diff>

-- 
HcE
