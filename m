Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:54560 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbdFSWBl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jun 2017 18:01:41 -0400
Date: Mon, 19 Jun 2017 15:01:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 0/8] Support for contiguous pte hugepages
Message-ID: <20170619150133.cb4173220e4e3abd02c6f6d0@linux-foundation.org>
In-Reply-To: <20170619170145.25577-1-punit.agrawal@arm.com>
References: <20170619170145.25577-1-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, n-horiguchi@ah.jp.nec.com, kirill.shutemov@linux.intel.com, mike.kravetz@oracle.com, steve.capper@arm.com, mark.rutland@arm.com, linux-arch@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20170619220133.GWnyQZ5-DISDpXTDOZNRq0CvYd_yGPe6cbc_coJB9Po@z>

On Mon, 19 Jun 2017 18:01:37 +0100 Punit Agrawal <punit.agrawal@arm.com> wrote:

> This is v5 of the patchset to update the hugetlb code to support
> contiguous hugepages. Previous version of the patchset can be found at
> [0].

Dumb question: is there a handy description anywhere which describes
how arm64 implements huge pages?  "contiguous 4k ptes" doesn't sound
like a huge page at all - what's going on here?
