Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:52576 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731223AbfCYNMG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Mar 2019 09:12:06 -0400
Date: Mon, 25 Mar 2019 15:11:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v12 11/11] gpio: 74x164: Utilize the for_each_set_clump8
 macro
Message-ID: <20190325131159.GV9224@smile.fi.intel.com>
References: <cover.1553494625.git.vilhelm.gray@gmail.com>
 <d3cc8680aa3d0d741649ac7402a213db1a789583.1553494625.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3cc8680aa3d0d741649ac7402a213db1a789583.1553494625.git.vilhelm.gray@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, Geert Uytterhoeven <geert+renesas@glider.be>
Message-ID: <20190325131159.34gAmBHmwV1mlclvGuaKGpsFR6Ooy8tcz2I5KqRzZ9Q@z>

On Mon, Mar 25, 2019 at 03:26:18PM +0900, William Breathitt Gray wrote:
> Replace verbose implementation in set_multiple callback with
> for_each_set_clump8 macro to simplify code and improve clarity.

I guess it's better to group this with other GPIO related patches.

-- 
With Best Regards,
Andy Shevchenko
