From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 0/3] Virtual huge zero page
Date: Mon, 1 Oct 2012 21:56:11 +0300
Message-ID: <20121001185611.GA23132@shutemov.name>
References: <20120929134811.GC26989@redhat.com>
 <5069B804.6040902@linux.intel.com>
 <20121001163118.GC18051@redhat.com>
 <5069CCF9.7040309@linux.intel.com>
 <20121001172624.GD18051@redhat.com>
 <5069D3D8.9070805@linux.intel.com>
 <20121001173604.GC20915@shutemov.name>
 <5069D4D3.1040003@linux.intel.com>
 <20121001174420.GA21490@shutemov.name>
 <5069D846.6000104@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shutemov.name ([176.9.204.213]:59669 "EHLO shutemov.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221Ab2JASzj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 1 Oct 2012 14:55:39 -0400
Content-Disposition: inline
In-Reply-To: <5069D846.6000104@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org

On Mon, Oct 01, 2012 at 10:52:06AM -0700, H. Peter Anvin wrote:
> On 10/01/2012 10:44 AM, Kirill A. Shutemov wrote:
> > On Mon, Oct 01, 2012 at 10:37:23AM -0700, H. Peter Anvin wrote:
> >> One can otherwise argue that if hzp doesn't matter for except in a small
> >> number of cases that we shouldn't use it at all.
> > 
> > These small number of cases can easily trigger OOM if THP is enabled. :)
> > 
> 
> And that doesn't happen in any conditions that *aren't* helped by hzp?

Sure, OOM still can happen.
But if we can eliminate a class of problem why not to do so?

-- 
 Kirill A. Shutemov
