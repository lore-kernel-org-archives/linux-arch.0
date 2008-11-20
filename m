From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: O_DIRECT patch for processors with VIPT cache for mainline kernel (specifically arm in our case)
Date: Thu, 20 Nov 2008 17:59:00 +1100
Message-ID: <200811201759.01039.nickpiggin@yahoo.com.au>
References: <d8dd82df0811180606w503563ach8650ab07dcd0a35c@mail.gmail.com> <200811191740.23638.nickpiggin@yahoo.com.au> <20081119204315.GB17209@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20081119204315.GB17209@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: Naval Saini <navalnovel@gmail.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, naval.saini@nxp.com
List-Id: linux-arch.vger.kernel.org

On Thursday 20 November 2008 07:43, Russell King - ARM Linux wrote:
> On Wed, Nov 19, 2008 at 05:40:23PM +1100, Nick Piggin wrote:
> > It would be interesting to know exactly what problem you are seeing.
> >
> > ARM I think is supposed to handle aliasing problems by flushing
> > caches at appropriate points. It would be nice to know what's going
> > wrong and whether we can cover those holes.
>
> I think there's a problem here: the existing cache handling API is
> designed around the MM's manipulation of page tables.  It is generally
> not designed to handle aliasing between multiple mappings of the same
> page, except with one exception: page cache pages mmap'd into userspace,
> which is handled via flush_dcache_page().

Right, flush_dcache_page.


> O_DIRECT on ARM is probably completely untested for the most part.  It's
> not something that is encountered very often, and as such gets zero
> testing.  I've certainly never had the tools to be able to test it out,
> so even on VIVT it's probably completely buggy.  Bear in mind that most
> of my modern platforms use MTD (either cramfs or in the rare case jffs2)
> so I'm not sure that I could sensibly even test O_DIRECT - isn't O_DIRECT
> for use with proper block devices?

Yes, although there are other things that use get_user_pages as well
(eg. splice, ptrace). So it would be interesting if they have corner
case problems as well.


> As it's probably clear, I've no clue of the O_DIRECT implementation or
> how it's supposed to work.  At a guess, it probably needs a new cache
> handling API to be designed, since the existing flush_cache_(range|page)
> are basically no-ops on VIPT.  Or maybe we need some way to mark the
> userspace pages as being write-through or uncacheable depending on the
> features we have available on the processor.  Or something.  Don't know.
>
> So, what is O_DIRECT, and where can I find some information about it?
> I don't see anything in Documentation/ describing it.

(open(2), with O_DIRECT flag)

O_DIRECT uses "get_user_pages()" pages (user mapped pages) to feed the
block layer with rather than pagecache pages. However pagecache pages
can also be user mapped, so I'm thinking there should be enough cache
flushing APIs to be able to handle either case.

Basically, an O_DIRECT write involves:

- The program storing into some virtual address, then passing that virtual
  address as the buffer to write(2).

- The kernel will get_user_pages() to get the struct page * of that user
  virtual address. At this point, get_user_pages does flush_dcache_page.
  (Which should write back the user caches?)

- Then the struct page is sent to the block layer (it won't tend to be
  touched by the kernel via the kernel linear map, unless we have like an
  "emulated" block device block device like 'brd').

- Even if it is read via the kernel linear map, AFAIKS, we should be OK
  due to the flush_dcache_page().

An O_DIRECT read involves:

- Same first 2 steps as O_DIRECT write, including flush_dcache_page. So the
  user mapping should not have any previously dirtied lines around.

- The page is sent to the block layer, which stores into the page. Some
  block devices like 'brd' will potentially store via the kernel linear map
  here, and they probably don't do enough cache flushing. But a regular
  block device should go via DMA, which AFAIK should be OK? (the user address
  should remain invalidated because it would be a bug to read from the buffer
  before the read has completed)

So I can't see exactly where the problem would be. Can you?
