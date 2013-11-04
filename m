From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: RE: [PATCH] mm: create a separate slab for page->ptl allocation
Date: Mon,  4 Nov 2013 12:42:59 +0200 (EET)
Message-ID: <20131104104259.86AFEE0090@blue.fi.intel.com>
References: <1382442839-7458-1-git-send-email-kirill.shutemov@linux.intel.com>
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382442839-7458-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

Kirill A. Shutemov wrote:
> If DEBUG_SPINLOCK and DEBUG_LOCK_ALLOC are enabled spinlock_t on x86_64
> is 72 bytes. For page->ptl they will be allocated from kmalloc-96 slab,
> so we loose 24 on each. An average system can easily allocate few tens
> thousands of page->ptl and overhead is significant.
> 
> Let's create a separate slab for page->ptl allocation to solve this.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

ping?

-- 
 Kirill A. Shutemov
