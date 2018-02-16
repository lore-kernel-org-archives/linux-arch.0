From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 02/37] asm-generic/io.h: move
 ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU
Date: Fri, 16 Feb 2018 17:30:28 +0800
Message-ID: <201802161724.hKyflUz5%fengguang.wu@intel.com>
References: <ff404658ececd53f1bf111067c587c4e3eb695af.1518505384.git.greentime@andestech.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ff404658ececd53f1bf111067c587c4e3eb695af.1518505384.git.greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org, stefan.kristiansson-MbMCFXIvDHJFcC0YU169RA@public.gmane.org, shorne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greentime,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc1 next-20180216]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Greentime-Hu/Andes-nds32-Linux-Kernel-Port/20180216-155013
config: cris-etrax-100lx_v2_defconfig (attached as .config)
compiler: cris-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=cris 

All warnings (new ones prefixed by >>):

   In file included from arch/cris/include/asm/io.h:24:0,
                    from include/linux/io.h:25,
                    from arch/cris/mm/ioremap.c:14:
   include/asm-generic/io.h:864:15: error: conflicting types for 'ioremap'
    void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
                  ^~~~~~~
   In file included from include/linux/io.h:25:0,
                    from arch/cris/mm/ioremap.c:14:
   arch/cris/include/asm/io.h:15:30: note: previous definition of 'ioremap' was here
    static inline void __iomem * ioremap (unsigned long offset, unsigned long size)
                                 ^~~~~~~
   In file included from arch/cris/include/asm/io.h:24:0,
                    from include/linux/io.h:25,
                    from arch/cris/mm/ioremap.c:14:
   include/asm-generic/io.h:865:25: error: conflicting types for 'ioremap_nocache'
    #define ioremap_nocache ioremap_nocache
                            ^
   include/asm-generic/io.h:866:29: note: in expansion of macro 'ioremap_nocache'
    static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
                                ^~~~~~~~~~~~~~~
   In file included from include/linux/io.h:25:0,
                    from arch/cris/mm/ioremap.c:14:
   arch/cris/include/asm/io.h:22:23: note: previous declaration of 'ioremap_nocache' was here
    extern void __iomem * ioremap_nocache(unsigned long offset, unsigned long size);
                          ^~~~~~~~~~~~~~~
   In file included from arch/cris/include/asm/io.h:24:0,
                    from include/linux/io.h:25,
                    from arch/cris/mm/ioremap.c:14:
   include/asm-generic/io.h:865:25: error: conflicting types for 'ioremap_nocache'
    #define ioremap_nocache ioremap_nocache
                            ^
>> arch/cris/mm/ioremap.c:80:15: note: in expansion of macro 'ioremap_nocache'
    void __iomem *ioremap_nocache(unsigned long phys_addr, unsigned long size)
                  ^~~~~~~~~~~~~~~
   include/asm-generic/io.h:865:25: note: previous definition of 'ioremap_nocache' was here
    #define ioremap_nocache ioremap_nocache
                            ^
   include/asm-generic/io.h:866:29: note: in expansion of macro 'ioremap_nocache'
    static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
                                ^~~~~~~~~~~~~~~

vim +/ioremap_nocache +80 arch/cris/mm/ioremap.c

e32cbc3d Haavard Skinnemoen 2006-09-30 @14  #include <linux/io.h>
^1da177e Linus Torvalds     2005-04-16  15  #include <asm/pgalloc.h>
556dcee7 Jesper Nilsson     2008-10-21  16  #include <arch/memmap.h>
^1da177e Linus Torvalds     2005-04-16  17  
^1da177e Linus Torvalds     2005-04-16  18  /*
^1da177e Linus Torvalds     2005-04-16  19   * Generic mapping function (not visible outside):
^1da177e Linus Torvalds     2005-04-16  20   */
^1da177e Linus Torvalds     2005-04-16  21  
^1da177e Linus Torvalds     2005-04-16  22  /*
^1da177e Linus Torvalds     2005-04-16  23   * Remap an arbitrary physical address space into the kernel virtual
^1da177e Linus Torvalds     2005-04-16  24   * address space. Needed when the kernel wants to access high addresses
^1da177e Linus Torvalds     2005-04-16  25   * directly.
^1da177e Linus Torvalds     2005-04-16  26   *
^1da177e Linus Torvalds     2005-04-16  27   * NOTE! We need to allow non-page-aligned mappings too: we will obviously
^1da177e Linus Torvalds     2005-04-16  28   * have to convert them into an offset in a page-aligned mapping, but the
^1da177e Linus Torvalds     2005-04-16  29   * caller shouldn't need to know that small detail.
^1da177e Linus Torvalds     2005-04-16  30   */
4f18cfbf Mikael Starvik     2005-07-27  31  void __iomem * __ioremap_prot(unsigned long phys_addr, unsigned long size, pgprot_t prot)
^1da177e Linus Torvalds     2005-04-16  32  {
4f18cfbf Mikael Starvik     2005-07-27  33  	void __iomem * addr;
^1da177e Linus Torvalds     2005-04-16  34  	struct vm_struct * area;
^1da177e Linus Torvalds     2005-04-16  35  	unsigned long offset, last_addr;
^1da177e Linus Torvalds     2005-04-16  36  
^1da177e Linus Torvalds     2005-04-16  37  	/* Don't allow wraparound or zero size */
^1da177e Linus Torvalds     2005-04-16  38  	last_addr = phys_addr + size - 1;
^1da177e Linus Torvalds     2005-04-16  39  	if (!size || last_addr < phys_addr)
^1da177e Linus Torvalds     2005-04-16  40  		return NULL;
^1da177e Linus Torvalds     2005-04-16  41  
^1da177e Linus Torvalds     2005-04-16  42  	/*
^1da177e Linus Torvalds     2005-04-16  43  	 * Mappings have to be page-aligned
^1da177e Linus Torvalds     2005-04-16  44  	 */
^1da177e Linus Torvalds     2005-04-16  45  	offset = phys_addr & ~PAGE_MASK;
^1da177e Linus Torvalds     2005-04-16  46  	phys_addr &= PAGE_MASK;
^1da177e Linus Torvalds     2005-04-16  47  	size = PAGE_ALIGN(last_addr+1) - phys_addr;
^1da177e Linus Torvalds     2005-04-16  48  
^1da177e Linus Torvalds     2005-04-16  49  	/*
^1da177e Linus Torvalds     2005-04-16  50  	 * Ok, go for it..
^1da177e Linus Torvalds     2005-04-16  51  	 */
^1da177e Linus Torvalds     2005-04-16  52  	area = get_vm_area(size, VM_IOREMAP);
^1da177e Linus Torvalds     2005-04-16  53  	if (!area)
^1da177e Linus Torvalds     2005-04-16  54  		return NULL;
4f18cfbf Mikael Starvik     2005-07-27  55  	addr = (void __iomem *)area->addr;
e32cbc3d Haavard Skinnemoen 2006-09-30  56  	if (ioremap_page_range((unsigned long)addr, (unsigned long)addr + size,
e32cbc3d Haavard Skinnemoen 2006-09-30  57  			       phys_addr, prot)) {
4f18cfbf Mikael Starvik     2005-07-27  58  		vfree((void __force *)addr);
^1da177e Linus Torvalds     2005-04-16  59  		return NULL;
^1da177e Linus Torvalds     2005-04-16  60  	}
4f18cfbf Mikael Starvik     2005-07-27  61  	return (void __iomem *) (offset + (char __iomem *)addr);
4f18cfbf Mikael Starvik     2005-07-27  62  }
4f18cfbf Mikael Starvik     2005-07-27  63  
4f18cfbf Mikael Starvik     2005-07-27  64  void __iomem * __ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
4f18cfbf Mikael Starvik     2005-07-27  65  {
4f18cfbf Mikael Starvik     2005-07-27  66  	return __ioremap_prot(phys_addr, size,
4f18cfbf Mikael Starvik     2005-07-27  67  		              __pgprot(_PAGE_PRESENT | __READABLE |
4f18cfbf Mikael Starvik     2005-07-27  68  				       __WRITEABLE | _PAGE_GLOBAL |
4f18cfbf Mikael Starvik     2005-07-27  69  				       _PAGE_KERNEL | flags));
4f18cfbf Mikael Starvik     2005-07-27  70  }
4f18cfbf Mikael Starvik     2005-07-27  71  
4f18cfbf Mikael Starvik     2005-07-27  72  /**
4f18cfbf Mikael Starvik     2005-07-27  73   * ioremap_nocache     -   map bus memory into CPU space
4f18cfbf Mikael Starvik     2005-07-27  74   * @offset:    bus address of the memory
4f18cfbf Mikael Starvik     2005-07-27  75   * @size:      size of the resource to map
4f18cfbf Mikael Starvik     2005-07-27  76   *
4f18cfbf Mikael Starvik     2005-07-27  77   * Must be freed with iounmap.
4f18cfbf Mikael Starvik     2005-07-27  78   */
4f18cfbf Mikael Starvik     2005-07-27  79  
4f18cfbf Mikael Starvik     2005-07-27 @80  void __iomem *ioremap_nocache(unsigned long phys_addr, unsigned long size)
4f18cfbf Mikael Starvik     2005-07-27  81  {
4f18cfbf Mikael Starvik     2005-07-27  82          return __ioremap(phys_addr | MEM_NON_CACHEABLE, size, 0);
^1da177e Linus Torvalds     2005-04-16  83  }
82e6df1e Jesper Nilsson     2014-10-01  84  EXPORT_SYMBOL(ioremap_nocache);
^1da177e Linus Torvalds     2005-04-16  85  

:::::: The code at line 80 was first introduced by commit
:::::: 4f18cfbf0990bfc2e8e7706eeb9e5bef898ae923 [PATCH] CRIS update: mm

:::::: TO: Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>
:::::: CC: Linus Torvalds <torvalds-hNm40g4Ew95AfugRpC6u6w@public.gmane.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--AqsLC8rIMeq19msA
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
3WvPWNC5D/9/KaDsGkqGAAA=

--AqsLC8rIMeq19msA--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
