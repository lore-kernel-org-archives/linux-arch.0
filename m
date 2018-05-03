From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH v2 5/5] asm-generic: fix build error in fix_to_virt with
 CONFIG_DEBUG_EXPERIENCE
Date: Thu, 3 May 2018 21:25:08 +0800
Message-ID: <20180503132508.qudxf67tyijvjndo@intel.com>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
 <1525268700-10631-6-git-send-email-changbin.du@intel.com>
 <20180502101930.25a5437d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180502101930.25a5437d@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: changbin.du@intel.com, yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org, rdunlap@infradead.org, x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, May 02, 2018 at 10:19:30AM -0400, Steven Rostedt wrote:
> On Wed,  2 May 2018 21:45:00 +0800
> changbin.du@intel.com wrote:
> 
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > With '-Og' optimization level, GCC would not optimize a count for a loop
> > as a constant value. But BUILD_BUG_ON() only accept compile-time constant
> > values.
> > 
> > arch/arm/mm/mmu.o: In function `fix_to_virt':
> > /home/changbin/work/linux/./include/asm-generic/fixmap.h:31: undefined reference to `__compiletime_assert_31'
> > Makefile:1051: recipe for target 'vmlinux' failed
> > make: *** [vmlinux] Error 1
> > 
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > ---
> >  include/asm-generic/fixmap.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
> > index 827e4d3..a6576d4 100644
> > --- a/include/asm-generic/fixmap.h
> > +++ b/include/asm-generic/fixmap.h
> > @@ -28,7 +28,8 @@
> >   */
> >  static __always_inline unsigned long fix_to_virt(const unsigned int idx)
> >  {
> > -	BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
> > +	BUILD_BUG_ON(__builtin_constant_p(idx) &&
> > +		     idx >= __end_of_fixed_addresses);
> 
> Hmm, this changes the check slightly. Perhaps we should only do this
> when your config is active:
> 
> {
> 	BUILD_BUG_ON(
> /* CONFIG_DEBUG_OPTIMIZE may cause idx not to be constant */
> #ifdef CONFIG_DEBUG_OPTIMIZE
> 		__builtin_constant_p(idx) &&
> #endif
> 		idx >= __end_of_fixed_addresses);
> 
> }
I think fix_to_virt() is designed for constant idx only. So I think we should
fix it at the caller side by replacing it with __fix_to_virt().

--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1599,7 +1599,7 @@ static void __init early_fixmap_shutdown(void)
                pte_t *pte;
                struct map_desc map;

-               map.virtual = fix_to_virt(i);
+               map.virtual = __fix_to_virt(i);
                pte = pte_offset_early_fixmap(pmd_off_k(map.virtual), map.virtual);

> 
> -- Steve
> 
> >  	return __fix_to_virt(idx);
> >  }
> >  
> 

-- 
Thanks,
Changbin Du
