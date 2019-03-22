From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v10 00/10] Introduce the for_each_set_clump8 macro
Date: Fri, 22 Mar 2019 21:12:02 +0200
Message-ID: <20190322191202.GC9224@smile.fi.intel.com>
References: <cover.1552566113.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1552566113.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linus.walleij@linaro.org, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, bgolaszewski@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 14, 2019 at 09:29:32PM +0900, William Breathitt Gray wrote:
> Changes in v10:
>   - Fix off-by-one error in bitmap initialization in the
>     test_for_each_set_clump8 function
>   - Fix typos in clump_exp array definition in test_bitmap.c ("0x28"
>     should have been "0x38")
>   - Utilize for_each_set_clump8 macro in intel_soc_dts_iosf.c

One more, can you look at gen_74x164_set_multiple() ? It seems a candidate as
well, if I'm not mistaken.


-- 
With Best Regards,
Andy Shevchenko
