From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH 2/8] opeinrisc: switch to generic version of pte
 allocation
Date: Sun, 28 Jun 2020 06:23:35 +0900
Message-ID: <20200627212335.GJ1401039@lianli.shorne-pla.net>
References: <20200627143453.31835-1-rppt@kernel.org>
 <20200627143453.31835-3-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgF0VXj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Jun 2020 17:23:39 -0400
Content-Disposition: inline
In-Reply-To: <20200627143453.31835-3-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, Joerg Roedel <joro@8bytes.org>, Max Filippov <jcmvbkbc@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Steven Rostedt <rostedt@goodmis.org>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.

On Sat, Jun 27, 2020 at 05:34:47PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Replace pte_alloc_one(), pte_free() and pte_free_kernel() with the generic
> implementation. The only actual functional change is the addition of
> __GFP_ACCOUT for the allocation of the user page tables.
> 
> The pte_alloc_one_kernel() is kept back because its implementation on
> openrisc is different than the generic one.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Thank's for this.

Acked-by: Stafford Horne <shorne@gmail.com>
