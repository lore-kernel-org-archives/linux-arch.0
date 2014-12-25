Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-am1on0055.outbound.protection.outlook.com ([157.56.112.55]:44065
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751637AbaLYDe7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Dec 2014 22:34:59 -0500
Message-ID: <549B7D2C.4000201@ezchip.com>
Date: Wed, 24 Dec 2014 21:57:48 -0500
From: Chris Metcalf <cmetcalf@ezchip.com>
MIME-Version: 1.0
Subject: Re: [PATCH 34/38] tile: drop pte_file()-related helpers
References: <1419423766-114457-1-git-send-email-kirill.shutemov@linux.intel.com> <1419423766-114457-35-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1419423766-114457-35-git-send-email-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, akpm@linux-foundation.org
Cc: peterz@infradead.org, mingo@kernel.org, davej@redhat.com, sasha.levin@oracle.com, hughd@google.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20141225025748.5hcXUrGe8Y7SG0Fh3UJ6kFy1wJPuJ9q10u2QXSw5KrM@z>

On 12/24/2014 7:22 AM, Kirill A. Shutemov wrote:
> We've replaced remap_file_pages(2) implementation with emulation.
> Nobody creates non-linear mapping anymore.
>
> Signed-off-by: Kirill A. Shutemov<kirill.shutemov@linux.intel.com>
> Cc: Chris Metcalf<cmetcalf@ezchip.com>
> ---
>   arch/tile/include/asm/pgtable.h | 11 -----------
>   arch/tile/mm/homecache.c        |  4 ----
>   2 files changed, 15 deletions(-)

Acked-by: Chris Metcalf <cmetcalf@ezchip.com>

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com

