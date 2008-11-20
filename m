From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: O_DIRECT patch for processors with VIPT cache for mainline kernel
	(specifically arm in our case)
Date: Thu, 20 Nov 2008 09:19:23 +0000
Message-ID: <20081120091923.GA2515@flint.arm.linux.org.uk>
References: <d8dd82df0811180606w503563ach8650ab07dcd0a35c@mail.gmail.com>
	<200811191740.23638.nickpiggin@yahoo.com.au>
	<20081119204315.GB17209@flint.arm.linux.org.uk>
	<200811201759.01039.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <200811201759.01039.nickpiggin@yahoo.com.au>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-fsdevel@vger.kernel.org, Naval Saini <navalnovel@gmail.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, naval.saini@nxp.com
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 20, 2008 at 05:59:00PM +1100, Nick Piggin wrote:
> Basically, an O_DIRECT write involves:
> 
> - The program storing into some virtual address, then passing that virtual
>   address as the buffer to write(2).
> 
> - The kernel will get_user_pages() to get the struct page * of that user
>   virtual address. At this point, get_user_pages does flush_dcache_page.
>   (Which should write back the user caches?)
> 
> - Then the struct page is sent to the block layer (it won't tend to be
>   touched by the kernel via the kernel linear map, unless we have like an
>   "emulated" block device block device like 'brd').
> 
> - Even if it is read via the kernel linear map, AFAIKS, we should be OK
>   due to the flush_dcache_page().

That seems sane, and yes, flush_dcache_page() will write back and
invalidate dirty cache lines in both the kernel and user mappings.

> An O_DIRECT read involves:
> 
> - Same first 2 steps as O_DIRECT write, including flush_dcache_page. So the
>   user mapping should not have any previously dirtied lines around.
> 
> - The page is sent to the block layer, which stores into the page. Some
>   block devices like 'brd' will potentially store via the kernel linear map
>   here, and they probably don't do enough cache flushing. But a regular
>   block device should go via DMA, which AFAIK should be OK? (the user address
>   should remain invalidated because it would be a bug to read from the buffer
>   before the read has completed)

This is where things get icky with lots of drivers - DMA is fine, but
many PIO based drivers don't handle the implications of writing to the
kernel page cache page when there may be CPU cache side effects.

If the cache is in read allocate mode, then in this case there shouldn't
be any dirty cache lines.  (That's not always the case though, esp. via
conventional IO.)  If the cache is in write allocate mode, PIO data will
sit in the kernel mapping and won't be visible to userspace.

That is a years-old bug, one that I've been unable to run tests for here
(because my platforms don't have the right combinations of CPUs supporting
write alloc and/or a problem block driver.)  I've even been accused of
being uncooperative over testing possible bug fixes by various people
(if I don't have hardware which can show the problem, how can I test
possible fixes?)  So I've given up with that issue - as far as I'm
concerned, it's a problem for others to sort out.

Do we know what hardware, which IO drivers are being used, and any
relevent configuration of the drivers?

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
