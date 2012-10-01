Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17754 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab2JARdN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 1 Oct 2012 13:33:13 -0400
Message-ID: <5069D3D8.9070805@linux.intel.com>
Date: Mon, 01 Oct 2012 10:33:12 -0700
From: "H. Peter Anvin" <hpa@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Virtual huge zero page
References: <1348875441-19561-1-git-send-email-kirill.shutemov@linux.intel.com> <20120929134811.GC26989@redhat.com> <5069B804.6040902@linux.intel.com> <20121001163118.GC18051@redhat.com> <5069CCF9.7040309@linux.intel.com> <20121001172624.GD18051@redhat.com>
In-Reply-To: <20121001172624.GD18051@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill@shutemov.name>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20121001173312.1tX8uEbdrg64tUfGJL1KsiBUTaYH_kYjvXw5tTMUmd0@z>

On 10/01/2012 10:26 AM, Andrea Arcangeli wrote:
> 
>> It is well known that microbenchmarks can be horribly misleading.  What
>> led to Kirill investigating huge zero page in the first place was the
>> fact that some applications/macrobenchmarks benefit, and I think those
>> are the right thing to look at.
> 
> The whole point of the two microbenchmarks was to measure the worst
> cases for both scenarios and I think that was useful. Real life using
> zero pages are going to be somewhere in that range.
> 

... and I think it would be worthwhile to know which effect dominates
(or neither, in which case it doesn't matter).

Overall, I'm okay with either as long as we don't lock down 2 MB when
there isn't a huge zero page in use.

	-hpa

