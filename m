From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 2/4] mm: Add arch hooks for saving/restoring tags
Date: Wed, 22 Apr 2020 11:08:10 -0700
Message-ID: <edd132f8-c39b-9586-1714-19a335ccea5c@intel.com>
References: <20200422142530.32619-1-steven.price@arm.com>
 <20200422142530.32619-3-steven.price@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31197 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgDVSIM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 14:08:12 -0400
In-Reply-To: <20200422142530.32619-3-steven.price@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Price <steven.price@arm.com>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Hugh Dickins <hughd@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>

On 4/22/20 7:25 AM, Steven Price wrote:
> Three new hooks are added to the swap code:
>  * arch_prepare_to_swap() and
>  * arch_swap_invalidate_page() / arch_swap_invalidate_area().
> One new hook is added to shmem:
>  * arch_swap_restore_tags()

How do the tags get restored outside of the shmem path?  I was expecting
to see more arch_swap_restore_tags() sites.
