Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:55466 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab3JKFvC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Oct 2013 01:51:02 -0400
Date: Fri, 11 Oct 2013 07:50:58 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 01/34] x86: add missed pgtable_pmd_page_ctor/dtor calls
 for preallocated pmds
Message-ID: <20131011055058.GA4838@gmail.com>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1381428359-14843-2-git-send-email-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1381428359-14843-2-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20131011055058.wWXtuSz0-rMyFHxBhycen1Xwcxq4DfkkLQncSVIXews@z>


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> I've missed that we preallocate few pmds on pgd_alloc() if X86_PAE
> enabled. Let's add missed constructor/destructor calls.
> 
> I haven't noticed it during testing since prep_new_page() clears
> page->mapping and therefore page->ptl. It's effectively equal to
> spin_lock_init(&page->ptl).
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
