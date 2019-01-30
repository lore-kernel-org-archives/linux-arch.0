From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 0/8] Introduce the for_each_set_clump8 macro
Date: Tue, 29 Jan 2019 17:07:34 -0800
Message-ID: <20190129170734.688a6adf91267cc6f1b5fa08@linux-foundation.org>
References: <cover.1547445576.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1547445576.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
List-Id: linux-arch.vger.kernel.org

On Mon, 14 Jan 2019 15:19:17 +0900 William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> While adding GPIO get_multiple/set_multiple callback support for various
> drivers, I noticed a pattern of looping manifesting that would be useful
> standardized as a macro.
> 
> This patchset introduces the for_each_set_clump8 macro and utilizes it
> in several GPIO drivers. The for_each_set_clump macro8 facilitates a
> for-loop syntax that iterates over a memory region entire groups of set
> bits at a time.
> 
> For example, suppose you would like to iterate over a 32-bit integer 8
> bits at a time, skipping over 8-bit groups with no set bit, where
> XXXXXXXX represents the current 8-bit group:
> 
>     Example:        10111110 00000000 11111111 00110011
>     First loop:     10111110 00000000 11111111 XXXXXXXX
>     Second loop:    10111110 00000000 XXXXXXXX 00110011
>     Third loop:     XXXXXXXX 00000000 11111111 00110011
> 
> Each iteration of the loop returns the next 8-bit group that has at
> least one set bit.
> 
> The for_each_set_clump8 macro has four parameters:
> 
>     * start: set to the bit offset of the current clump
>     * clump: set to the current clump value
>     * bits: bitmap to search within
>     * size: bitmap size in number of bits
> 
> In this version of the patchset, the for_each_set_clump macro has been
> reimplemented and simplified based on the suggestions provided by Rasmus
> Villemoes and Andy Shevchenko in the version 4 submission.
> 
> In particular, the function of the for_each_set_clump macro has been
> restricted to handle only 8-bit clumps; the drivers that use the
> for_each_set_clump macro only handle 8-bit ports so a generic
> for_each_set_clump implementation is not necessary. Thus, a solution for
> large clumps (i.e. those larger than the width of a bitmap word) can be
> postponed until a driver appears that actually requires such a generic
> for_each_set_clump implementation.
> 
> For what it's worth, a semi-generic for_each_set_clump (i.e. for clumps
> smaller than the width of a bitmap word) can be implemented by simply
> replacing the hardcoded '8' and '0xFF' instances with respective
> variables. I have not yet had a need for such an implementation, and
> since it falls short of a true generic for_each_set_clump function, I
> have decided to forgo such an implementation for now.
> 
> In addition, the bitmap_get_value8 and bitmap_set_value8 functions are
> introduced to get and set 8-bit values respectively. Their use is based
> on the behavior suggested in the patchset version 4 review.

Nice-looking code.

>  drivers/gpio/gpio-104-dio-48e.c   |  73 ++++++--------------
>  drivers/gpio/gpio-104-idi-48.c    |  37 +++-------
>  drivers/gpio/gpio-gpio-mm.c       |  73 ++++++--------------
>  drivers/gpio/gpio-pci-idio-16.c   |  75 ++++++++------------
>  drivers/gpio/gpio-pcie-idio-24.c  | 111 +++++++++++-------------------
>  drivers/gpio/gpio-ws16c48.c       |  72 ++++++-------------
>  include/asm-generic/bitops/find.h |  14 ++++
>  include/linux/bitops.h            |   5 ++
>  lib/find_bit.c                    |  81 ++++++++++++++++++++++
>  lib/test_bitmap.c                 |  65 +++++++++++++++++
>  10 files changed, 307 insertions(+), 299 deletions(-)

It's a shame that it doesn't actually dercease the kernel line count,
but there are other benefits.

The patches are missing the hoped-for acks, but I think you maintain
most/all of those drivers.

Do we have any expectation that these facilities will be used by
anything other than GPIO?  If not then perhaps they should be sited
within drivers/gpio (presumably as a standalone module) until such a
need is found?
