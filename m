From: Chris Metcalf <cmetcalf@ezchip.com>
Subject: Re: [PATCH 34/38] tile: drop pte_file()-related helpers
Date: Wed, 24 Dec 2014 21:57:48 -0500
Message-ID: <549B7D2C.4000201@ezchip.com>
References: <1419423766-114457-1-git-send-email-kirill.shutemov@linux.intel.com> <1419423766-114457-35-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1419423766-114457-35-git-send-email-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, akpm@linux-foundation.org
Cc: peterz@infradead.org, mingo@kernel.org, davej@redhat.com, sasha.levin@oracle.com, hughd@google.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
