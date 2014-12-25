From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 26/38] nios2: drop _PAGE_FILE and pte_file()-related
 helpers
Date: Thu, 25 Dec 2014 13:30:15 +0100
Message-ID: <20141225123014.GO16916@distanz.ch>
References: <1419423766-114457-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1419423766-114457-27-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:42409 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbaLYMaS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 Dec 2014 07:30:18 -0500
Content-Disposition: inline
In-Reply-To: <1419423766-114457-27-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, mingo@kernel.org, davej@redhat.com, sasha.levin@oracle.com, hughd@google.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ley Foon Tan <lftan@altera.com>

On 2014-12-24 at 13:22:34 +0100, Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:
> We've replaced remap_file_pages(2) implementation with emulation.
> Nobody creates non-linear mapping anymore.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Ley Foon Tan <lftan@altera.com>

Reviewed-by: Tobias Klauser <tklauser@distanz.ch>
