From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 0/3] Virtual huge zero page
Date: Sat, 29 Sep 2012 07:30:06 -0700
Message-ID: <20120929143006.GC4110@tassilo.jf.intel.com>
References: <1348875441-19561-1-git-send-email-kirill.shutemov@linux.intel.com>
 <20120929134811.GC26989@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57289 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371Ab2I2OaG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 29 Sep 2012 10:30:06 -0400
Content-Disposition: inline
In-Reply-To: <20120929134811.GC26989@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, "H. Peter Anvin" <hpa@linux.intel.com>, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill@shutemov.name>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org

On Sat, Sep 29, 2012 at 03:48:11PM +0200, Andrea Arcangeli wrote:
> On Sat, Sep 29, 2012 at 02:37:18AM +0300, Kirill A. Shutemov wrote:
> > Cons:
> >  - increases TLB pressure;
> 
> I generally don't like using 4k tlb entries ever. This only has the

From theory I would also prefer the 2MB huge page.

But some numbers comparing between the two alternatives are definitely
interesting.  Numbers are often better than theory.

> There would be a small cache benefit here... but even then some first
> level caches are virtually indexed IIRC (always physically tagged to

Modern x86 doesn't have virtually indexed caches.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only
