From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: O_DIRECT patch for processors with VIPT cache for mainline kernel
	(specifically arm in our case)
Date: Thu, 20 Nov 2008 19:30:49 +0000
Message-ID: <20081120193049.GC14686@flint.arm.linux.org.uk>
References: <d8dd82df0811180606w503563ach8650ab07dcd0a35c@mail.gmail.com>
	<200811201759.01039.nickpiggin@yahoo.com.au>
	<b647ffbd0811200428u2b41b108ifb02872563c871ab@mail.gmail.com>
	<200811210025.39568.nickpiggin@yahoo.com.au>
	<20081120135558.GB24308@linux-mips.org>
	<20081120152719.GS1617@parisc-linux.org>
	<20081120171713.GB27398@linux-mips.org>
	<20081120174054.GU1617@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20081120174054.GU1617@parisc-linux.org>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Matthew Wilcox <matthew@wil.cx>
Cc: Ralf Baechle <ralf@linux-mips.org>, Nick Piggin <nickpiggin@yahoo.com.au>, Dmitry Adamushko <dmitry.adamushko@gmail.com>, linux-fsdevel@vger.kernel.org, Naval Saini <navalnovel@gmail.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, naval.saini@nxp.com, James Bottomley <James.Bottomley@HansenPartnership.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 20, 2008 at 10:40:54AM -0700, Matthew Wilcox wrote:
> On Thu, Nov 20, 2008 at 05:17:14PM +0000, Ralf Baechle wrote:
> > On Thu, Nov 20, 2008 at 08:27:19AM -0700, Matthew Wilcox wrote:
> > > I'm not quite sure why you need kmap_coherent().  If a page is mapped into
> > > userspace, you can find what address it's mapped to from
> > > page->mapping->i_mmap and page->index.  OTOH, that's potentially
> > 
> > Even if we know the userspace address of a page we do not necessarily have
> > a usable mapping for kernel purposes.  The userspace mapping might be r/o
> > when we need r/w or it might be in another process.  kmap_coherent takes
> > the job of creating a r/w mapping on a suitable kernel virtual address
> > that will avoid any aliases.
> 
> Ah, I didn't do a good enough job of explaining.  My question was why
> you needed the 'address' argument to kmap_coherent (and thus had a
> different prototype from kmap) instead of just implementing kmap() on
> mips.

Ok, having discussed this with Matthew, I'm beginning to really warm
to the idea of always kmapping page cache accesses.

That nicely means that we never touch the page cache via the kernel
direct mapping, which in turn means we can reduce the amount of RAM
mapped, freeing up space for kmap in the virtual address space.

I think this should work really nicely, and make flush_dcache_page()
almost a no-op for aliasing VIPT caches (on ARM, we still have a
problem with instruction/data cache aliasing, but that's a far easier
issue to solve.)

Ralf: were you saying that you already had an implementation similar
to Matthew's?  As I see it, if you use page->index to determine the
userspace mapping colouring (which we do on ARM) then kmap() already
has access the necessary information to correctly place the page...

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
