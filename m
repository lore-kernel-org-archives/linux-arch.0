Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40600 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753971AbeCFWr7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Mar 2018 17:47:59 -0500
Date: Tue, 6 Mar 2018 14:47:57 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v12 02/11] mm, swap: Add infrastructure for saving page
 metadata on swap
Message-ID: <20180306144757.8b1b4967bce500fca9bb6083@linux-foundation.org>
In-Reply-To: <f5316c71e645d99ffdd52963f1e9675de3fc6386.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
        <f5316c71e645d99ffdd52963f1e9675de3fc6386.1519227112.git.khalid.aziz@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: davem@davemloft.net, dave.hansen@linux.intel.com, arnd@arndb.de, kirill.shutemov@linux.intel.com, mhocko@suse.com, ross.zwisler@linux.intel.com, dave.jiang@intel.com, mgorman@techsingularity.net, willy@infradead.org, hughd@google.com, minchan@kernel.org, hannes@cmpxchg.org, shli@fb.com, mingo@kernel.org, jglisse@redhat.com, me@tobin.cc, anthony.yznaga@oracle.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
Message-ID: <20180306224757.YH4ompQ6_yKEPIAB46lK2K6NlCerYTG2EDQExF0FGGk@z>

On Wed, 21 Feb 2018 10:15:44 -0700 Khalid Aziz <khalid.aziz@oracle.com> wrote:

> If a processor supports special metadata for a page, for example ADI
> version tags on SPARC M7, this metadata must be saved when the page is
> swapped out. The same metadata must be restored when the page is swapped
> back in. This patch adds two new architecture specific functions -
> arch_do_swap_page() to be called when a page is swapped in, and
> arch_unmap_one() to be called when a page is being unmapped for swap
> out. These architecture hooks allow page metadata to be saved if the
> architecture supports it.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> Cc: Khalid Aziz <khalid@gonehiking.org>
> Acked-by: Jerome Marchand <jmarchan@redhat.com>
> Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>

Acked-by: Andrew Morton <akpm@linux-foundation.org>
