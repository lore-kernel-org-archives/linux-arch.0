From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v8 0/8] Introduce the for_each_set_clump8 macro
Date: Fri, 8 Feb 2019 18:39:08 +0200
Message-ID: <20190208163908.GR9224@smile.fi.intel.com>
References: <cover.1547445576.git.vilhelm.gray@gmail.com>
 <20190129170734.688a6adf91267cc6f1b5fa08@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129170734.688a6adf91267cc6f1b5fa08@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>, linus.walleij@linaro.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 29, 2019 at 05:07:34PM -0800, Andrew Morton wrote:
> On Mon, 14 Jan 2019 15:19:17 +0900 William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> It's a shame that it doesn't actually dercease the kernel line count,
> but there are other benefits.
> 
> The patches are missing the hoped-for acks, but I think you maintain
> most/all of those drivers.

I'm okay with the code as well, so,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Do we have any expectation that these facilities will be used by
> anything other than GPIO?  If not then perhaps they should be sited
> within drivers/gpio (presumably as a standalone module) until such a
> need is found?

I think I have an example out of GPIO realm. But I need time to prove that.
In any case I tend to bend to the generic exposure than to local one.

-- 
With Best Regards,
Andy Shevchenko
