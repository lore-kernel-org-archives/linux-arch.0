From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/8] mm: cleanup usage of <asm/pgalloc.h>
Date: Sat, 27 Jun 2020 19:31:10 +0100
Message-ID: <20200627183110.GE25039@casper.infradead.org>
References: <20200627143453.31835-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200627143453.31835-1-rppt@kernel.org>
Sender: linux-ia64-owner@vger.kernel.org
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, Joerg Roedel <joro@8bytes.org>, Max Filippov <jcmvbkbc@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, Stafford Horne <shorne@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Steven Rostedt <rostedt@goodmis.org>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mi
List-Id: linux-arch.vger.kernel.org

On Sat, Jun 27, 2020 at 05:34:45PM +0300, Mike Rapoport wrote:
> Most architectures have very similar versions of pXd_alloc_one() and
> pXd_free_one() for intermediate levels of page table. 
> These patches add generic versions of these functions in
> <asm-generic/pgalloc.h> and enable use of the generic functions where
> appropriate.

For the series:

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
