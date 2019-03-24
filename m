From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v10 00/10] Introduce the for_each_set_clump8 macro
Date: Sun, 24 Mar 2019 13:08:09 +0900
Message-ID: <20190324040704.GA8285@icarus>
References: <cover.1552566113.git.vilhelm.gray@gmail.com>
 <20190322191202.GC9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190322191202.GC9224@smile.fi.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Phil Reid <preid@electromag.com.au>
Cc: linux-arch@vger.kernel.org, yamada.masahiro@socionext.com, linus.walleij@linaro.org, linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 22, 2019 at 09:12:02PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 14, 2019 at 09:29:32PM +0900, William Breathitt Gray wrote:
> > Changes in v10:
> >   - Fix off-by-one error in bitmap initialization in the
> >     test_for_each_set_clump8 function
> >   - Fix typos in clump_exp array definition in test_bitmap.c ("0x28"
> >     should have been "0x38")
> >   - Utilize for_each_set_clump8 macro in intel_soc_dts_iosf.c
> 
> One more, can you look at gen_74x164_set_multiple() ? It seems a candidate as
> well, if I'm not mistaken.

We can utilize the for_each_set_clump8 macro in the
gen_74x164_set_multiple function, but I skipped over it earlier since I
noticed it used the BITS_PER_BYTE define rather than a hardcoded 8. If
it always loops 8 bits at a time, then we can use the
for_each_set_clump8 macro; otherwise we would need the more generic
for_each_set_clump macro to handle the non-8-bit looping cases.

Will BITS_PER_BYTE always be defined as 8 bits?

William Breathitt Gray

> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
