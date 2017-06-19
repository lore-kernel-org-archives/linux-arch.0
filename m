From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 0/8] Support for contiguous pte hugepages
Date: Mon, 19 Jun 2017 15:01:33 -0700
Message-ID: <20170619150133.cb4173220e4e3abd02c6f6d0@linux-foundation.org>
References: <20170619170145.25577-1-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170619170145.25577-1-punit.agrawal@arm.com>
Sender: owner-linux-mm@kvack.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, n-horiguchi@ah.jp.nec.com, kirill.shutemov@linux.intel.com, mike.kravetz@oracle.com, steve.capper@arm.com, mark.rutland@arm.com, linux-arch@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

On Mon, 19 Jun 2017 18:01:37 +0100 Punit Agrawal <punit.agrawal@arm.com> wrote:

> This is v5 of the patchset to update the hugetlb code to support
> contiguous hugepages. Previous version of the patchset can be found at
> [0].

Dumb question: is there a handy description anywhere which describes
how arm64 implements huge pages?  "contiguous 4k ptes" doesn't sound
like a huge page at all - what's going on here?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
