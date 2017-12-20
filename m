From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v4 01/36] asm-generic/io.h: move
 ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU
Date: Wed, 20 Dec 2017 18:09:08 +0800
Message-ID: <201712201836.XDtv2JdK%fengguang.wu@intel.com>
References: <d25ea659bc370a6bb24c4d42416f890a34051df1.1513577007.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d25ea659bc370a6bb24c4d42416f890a34051df1.1513577007.git.green.hu@gmail.com>
Sender: netdev-owner@vger.kernel.org
Cc: kbuild-all@01.org, greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, pombredanne@nexb.com, green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greentime,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on v4.15-rc4 next-20171220]
[cannot apply to linus/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Greentime-Hu/Andes-nds32-Linux-Kernel/20171220-155937
config: sparc-defconfig (attached as .config)
compiler: sparc-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc 

All error/warnings (new ones prefixed by >>):

   In file included from arch/sparc/include/asm/io.h:6:0,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from arch/sparc/kernel/kernel.h:4,
                    from arch/sparc/kernel/traps_32.c:30:
>> arch/sparc/include/asm/io_32.h:129:15: error: conflicting types for 'ioremap'
    void __iomem *ioremap(unsigned long offset, unsigned long size);
                  ^~~~~~~
   In file included from arch/sparc/include/asm/io_32.h:13:0,
                    from arch/sparc/include/asm/io.h:6,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from arch/sparc/kernel/kernel.h:4,
                    from arch/sparc/kernel/traps_32.c:30:
   include/asm-generic/io.h:864:15: note: previous declaration of 'ioremap' was here
    void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
                  ^~~~~~~
   In file included from arch/sparc/include/asm/io.h:6:0,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from arch/sparc/kernel/kernel.h:4,
                    from arch/sparc/kernel/traps_32.c:30:
   arch/sparc/include/asm/io_32.h:130:0: error: "ioremap_nocache" redefined [-Werror]
    #define ioremap_nocache(X,Y) ioremap((X),(Y))
    
   In file included from arch/sparc/include/asm/io_32.h:13:0,
                    from arch/sparc/include/asm/io.h:6,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from arch/sparc/kernel/kernel.h:4,
                    from arch/sparc/kernel/traps_32.c:30:
   include/asm-generic/io.h:865:0: note: this is the location of the previous definition
    #define ioremap_nocache ioremap_nocache
    
   In file included from arch/sparc/include/asm/io.h:6:0,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from arch/sparc/kernel/kernel.h:4,
                    from arch/sparc/kernel/traps_32.c:30:
   arch/sparc/include/asm/io_32.h:131:0: error: "ioremap_wc" redefined [-Werror]
    #define ioremap_wc(X,Y)  ioremap((X),(Y))
    
   In file included from arch/sparc/include/asm/io_32.h:13:0,
                    from arch/sparc/include/asm/io.h:6,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from arch/sparc/kernel/kernel.h:4,
                    from arch/sparc/kernel/traps_32.c:30:
   include/asm-generic/io.h:881:0: note: this is the location of the previous definition
    #define ioremap_wc ioremap_wc
    
   In file included from arch/sparc/include/asm/io.h:6:0,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from arch/sparc/kernel/kernel.h:4,
                    from arch/sparc/kernel/traps_32.c:30:
   arch/sparc/include/asm/io_32.h:132:0: error: "ioremap_wt" redefined [-Werror]
    #define ioremap_wt(X,Y)  ioremap((X),(Y))
    
   In file included from arch/sparc/include/asm/io_32.h:13:0,
                    from arch/sparc/include/asm/io.h:6,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from arch/sparc/kernel/kernel.h:4,
                    from arch/sparc/kernel/traps_32.c:30:
   include/asm-generic/io.h:889:0: note: this is the location of the previous definition
    #define ioremap_wt ioremap_wt
    
   cc1: all warnings being treated as errors
--
   In file included from arch/sparc/include/asm/io.h:6:0,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc/kernel/ioport.c:36:
>> arch/sparc/include/asm/io_32.h:129:15: error: conflicting types for 'ioremap'
    void __iomem *ioremap(unsigned long offset, unsigned long size);
                  ^~~~~~~
   In file included from arch/sparc/include/asm/io_32.h:13:0,
                    from arch/sparc/include/asm/io.h:6,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc/kernel/ioport.c:36:
   include/asm-generic/io.h:864:15: note: previous declaration of 'ioremap' was here
    void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
                  ^~~~~~~
   In file included from arch/sparc/include/asm/io.h:6:0,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc/kernel/ioport.c:36:
   arch/sparc/include/asm/io_32.h:130:0: error: "ioremap_nocache" redefined [-Werror]
    #define ioremap_nocache(X,Y) ioremap((X),(Y))
    
   In file included from arch/sparc/include/asm/io_32.h:13:0,
                    from arch/sparc/include/asm/io.h:6,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc/kernel/ioport.c:36:
   include/asm-generic/io.h:865:0: note: this is the location of the previous definition
    #define ioremap_nocache ioremap_nocache
    
   In file included from arch/sparc/include/asm/io.h:6:0,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc/kernel/ioport.c:36:
   arch/sparc/include/asm/io_32.h:131:0: error: "ioremap_wc" redefined [-Werror]
    #define ioremap_wc(X,Y)  ioremap((X),(Y))
    
   In file included from arch/sparc/include/asm/io_32.h:13:0,
                    from arch/sparc/include/asm/io.h:6,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc/kernel/ioport.c:36:
   include/asm-generic/io.h:881:0: note: this is the location of the previous definition
    #define ioremap_wc ioremap_wc
    
   In file included from arch/sparc/include/asm/io.h:6:0,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc/kernel/ioport.c:36:
   arch/sparc/include/asm/io_32.h:132:0: error: "ioremap_wt" redefined [-Werror]
    #define ioremap_wt(X,Y)  ioremap((X),(Y))
    
   In file included from arch/sparc/include/asm/io_32.h:13:0,
                    from arch/sparc/include/asm/io.h:6,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc/kernel/ioport.c:36:
   include/asm-generic/io.h:889:0: note: this is the location of the previous definition
    #define ioremap_wt ioremap_wt
    
>> arch/sparc/kernel/ioport.c:124:15: error: conflicting types for 'ioremap'
    void __iomem *ioremap(unsigned long offset, unsigned long size)
                  ^~~~~~~
   In file included from arch/sparc/include/asm/io_32.h:13:0,
                    from arch/sparc/include/asm/io.h:6,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc/kernel/ioport.c:36:
   include/asm-generic/io.h:864:15: note: previous declaration of 'ioremap' was here
    void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
                  ^~~~~~~
   In file included from include/linux/linkage.h:6:0,
                    from include/linux/kernel.h:6,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from arch/sparc/kernel/ioport.c:28:
   arch/sparc/kernel/ioport.c:131:15: error: conflicting types for 'ioremap'
    EXPORT_SYMBOL(ioremap);
                  ^
   include/linux/export.h:65:21: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;      \
                        ^~~
>> arch/sparc/kernel/ioport.c:131:1: note: in expansion of macro 'EXPORT_SYMBOL'
    EXPORT_SYMBOL(ioremap);
    ^~~~~~~~~~~~~
   In file included from arch/sparc/include/asm/io_32.h:13:0,
                    from arch/sparc/include/asm/io.h:6,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc/kernel/ioport.c:36:
   include/asm-generic/io.h:864:15: note: previous declaration of 'ioremap' was here
    void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
                  ^~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from arch/sparc/include/asm/io.h:6:0,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc//kernel/ioport.c:36:
>> arch/sparc/include/asm/io_32.h:129:15: error: conflicting types for 'ioremap'
    void __iomem *ioremap(unsigned long offset, unsigned long size);
                  ^~~~~~~
   In file included from arch/sparc/include/asm/io_32.h:13:0,
                    from arch/sparc/include/asm/io.h:6,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc//kernel/ioport.c:36:
   include/asm-generic/io.h:864:15: note: previous declaration of 'ioremap' was here
    void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
                  ^~~~~~~
   In file included from arch/sparc/include/asm/io.h:6:0,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc//kernel/ioport.c:36:
   arch/sparc/include/asm/io_32.h:130:0: error: "ioremap_nocache" redefined [-Werror]
    #define ioremap_nocache(X,Y) ioremap((X),(Y))
    
   In file included from arch/sparc/include/asm/io_32.h:13:0,
                    from arch/sparc/include/asm/io.h:6,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc//kernel/ioport.c:36:
   include/asm-generic/io.h:865:0: note: this is the location of the previous definition
    #define ioremap_nocache ioremap_nocache
    
   In file included from arch/sparc/include/asm/io.h:6:0,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc//kernel/ioport.c:36:
   arch/sparc/include/asm/io_32.h:131:0: error: "ioremap_wc" redefined [-Werror]
    #define ioremap_wc(X,Y)  ioremap((X),(Y))
    
   In file included from arch/sparc/include/asm/io_32.h:13:0,
                    from arch/sparc/include/asm/io.h:6,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc//kernel/ioport.c:36:
   include/asm-generic/io.h:881:0: note: this is the location of the previous definition
    #define ioremap_wc ioremap_wc
    
   In file included from arch/sparc/include/asm/io.h:6:0,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc//kernel/ioport.c:36:
   arch/sparc/include/asm/io_32.h:132:0: error: "ioremap_wt" redefined [-Werror]
    #define ioremap_wt(X,Y)  ioremap((X),(Y))
    
   In file included from arch/sparc/include/asm/io_32.h:13:0,
                    from arch/sparc/include/asm/io.h:6,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from include/asm-generic/hardirq.h:12,
                    from arch/sparc/include/asm/hardirq_32.h:10,
                    from arch/sparc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from include/linux/pci.h:31,
                    from arch/sparc//kernel/ioport.c:36:
   include/asm-generic/io.h:889:0: note: this is the location of the previous definition
    #define ioremap_wt ioremap_wt
    
   arch/sparc//kernel/ioport.c:124:15: error: conflicting types for 'ioremap'
    void __iomem *ioremap(unsigned long offset, unsigned long size)
                  ^~~~~~~

vim +/ioremap +129 arch/sparc/include/asm/io_32.h

f5e706ad include/asm-sparc/io_32.h      Sam Ravnborg    2008-07-17  124  
f5e706ad include/asm-sparc/io_32.h      Sam Ravnborg    2008-07-17  125  /*
f5e706ad include/asm-sparc/io_32.h      Sam Ravnborg    2008-07-17  126   * Bus number may be embedded in the higher bits of the physical address.
f5e706ad include/asm-sparc/io_32.h      Sam Ravnborg    2008-07-17  127   * This is why we have no bus number argument to ioremap().
f5e706ad include/asm-sparc/io_32.h      Sam Ravnborg    2008-07-17  128   */
f05a6865 arch/sparc/include/asm/io_32.h Sam Ravnborg    2014-05-16 @129  void __iomem *ioremap(unsigned long offset, unsigned long size);
f5e706ad include/asm-sparc/io_32.h      Sam Ravnborg    2008-07-17  130  #define ioremap_nocache(X,Y)	ioremap((X),(Y))
428695b8 include/asm-sparc/io_32.h      David S. Miller 2008-07-22  131  #define ioremap_wc(X,Y)		ioremap((X),(Y))
556269c1 arch/sparc/include/asm/io_32.h Toshi Kani      2015-06-04  132  #define ioremap_wt(X,Y)		ioremap((X),(Y))
f05a6865 arch/sparc/include/asm/io_32.h Sam Ravnborg    2014-05-16  133  void iounmap(volatile void __iomem *addr);
f5e706ad include/asm-sparc/io_32.h      Sam Ravnborg    2008-07-17  134  

:::::: The code at line 129 was first introduced by commit
:::::: f05a68653e56ca2f23bccf7e50be69486886f052 sparc: drop use of extern for prototypes in arch/sparc/include/asm

:::::: TO: Sam Ravnborg <sam@ravnborg.org>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--oyUTqETQ0mS9luUI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
nS6JU4Fp72xIWvZ+Dmwt/gNzIwmflr4AAA==

--oyUTqETQ0mS9luUI--
