From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v18 01/14] bitops: Introduce the for_each_set_clump8 macro
Date: Wed, 9 Oct 2019 14:18:55 -0700
Message-ID: <20191009141855.310f1fa8bde58df0df27b8f0@linux-foundation.org>
References: <cover.1570641097.git.vilhelm.gray@gmail.com>
 <893c3b4f03266c9496137cc98ac2b1bd27f92c73.1570641097.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <893c3b4f03266c9496137cc98ac2b1bd27f92c73.1570641097.git.vilhelm.gray@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-arch@vger.kernel.org, preid@electromag.com.au, Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org, yamada.masahiro@socionext.com, linus.walleij@linaro.org, linux-pm@vger.kernel.org, linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org, bgolaszewski@baylibre.com, Andy Shevchenko <andy.shevchenko@gmail.com>, lukas@wunner.de, geert@linux-m68k.org, andriy.shevchenko@linux.intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed,  9 Oct 2019 13:14:37 -0400 William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.
> 
> ...
>  
> +#define for_each_set_clump8(start, clump, bits, size) \
> +	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
> +	     (start) < (size); \
> +	     (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
> +

It wouldn't hurt to give this some documentation.  In kerneldoc form, I
guess.
