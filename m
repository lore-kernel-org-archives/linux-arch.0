Return-Path: <SRS0=iE4N=6I=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:39131 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbgDXQ2q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 12:28:46 -0400
Date: Fri, 24 Apr 2020 19:28:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/6] Introduce the for_each_set_clump macro
Message-ID: <20200424162843.GC185537@smile.fi.intel.com>
References: <20200424122407.GA5523@syed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424122407.GA5523@syed>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: akpm@linux-foundation.org, vilhelm.gray@gmail.com, michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, yamada.masahiro@socionext.com, rui.zhang@intel.com, daniel.lezcano@linaro.org, amit.kucheria@verdurent.com, linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Message-ID: <20200424162843.P4Ohgxt6zsILghpPkXsX-w0TtylV9zXrbO-WERNav2w@z>

On Fri, Apr 24, 2020 at 05:54:07PM +0530, Syed Nayyar Waris wrote:
> This patchset introduces a new generic version of for_each_set_clump. 
> The previous version of for_each_set_clump8 used a fixed size 8-bit
> clump, but the new generic version can work with clump of any size but
> less than or equal to BITS_PER_LONG. The patchset utilizes the new macro 
> in several GPIO drivers.

You have broken thread. Please, use --thread when run `git format-patch ...`.

-- 
With Best Regards,
Andy Shevchenko
