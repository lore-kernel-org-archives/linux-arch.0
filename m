From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v4 33/36] net: faraday add nds32 support.
Date: Wed, 20 Dec 2017 19:03:34 +0800
Message-ID: <201712201849.V1uJdj6R%fengguang.wu@intel.com>
References: <95be78502aa406f106ecbe87e751a45333883b1f.1513577007.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <95be78502aa406f106ecbe87e751a45333883b1f.1513577007.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, pombredanne@nexb.com, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

Hi Greentime,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/timers/core]
[cannot apply to linus/master v4.15-rc4 next-20171220]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Greentime-Hu/Andes-nds32-Linux-Kernel/20171220-155937
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


vim +205 drivers/net/ethernet/faraday/ftmac100.c

8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  199  
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  200  /******************************************************************************
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  201   * internal functions (receive descriptor)
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  202   *****************************************************************************/
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  203  static bool ftmac100_rxdes_first_segment(struct ftmac100_rxdes *rxdes)
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  204  {
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28 @205  	return rxdes->rxdes0 & cpu_to_le32(FTMAC100_RXDES0_FRS);
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  206  }
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  207  
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  208  static bool ftmac100_rxdes_last_segment(struct ftmac100_rxdes *rxdes)
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  209  {
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  210  	return rxdes->rxdes0 & cpu_to_le32(FTMAC100_RXDES0_LRS);
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  211  }
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  212  
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  213  static bool ftmac100_rxdes_owned_by_dma(struct ftmac100_rxdes *rxdes)
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  214  {
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28 @215  	return rxdes->rxdes0 & cpu_to_le32(FTMAC100_RXDES0_RXDMA_OWN);
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  216  }
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  217  
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  218  static void ftmac100_rxdes_set_dma_own(struct ftmac100_rxdes *rxdes)
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  219  {
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  220  	/* clear status bits */
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28 @221  	rxdes->rxdes0 = cpu_to_le32(FTMAC100_RXDES0_RXDMA_OWN);
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  222  }
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  223  
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  224  static bool ftmac100_rxdes_rx_error(struct ftmac100_rxdes *rxdes)
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  225  {
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  226  	return rxdes->rxdes0 & cpu_to_le32(FTMAC100_RXDES0_RX_ERR);
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  227  }
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  228  
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  229  static bool ftmac100_rxdes_crc_error(struct ftmac100_rxdes *rxdes)
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  230  {
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  231  	return rxdes->rxdes0 & cpu_to_le32(FTMAC100_RXDES0_CRC_ERR);
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  232  }
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  233  
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  234  static bool ftmac100_rxdes_frame_too_long(struct ftmac100_rxdes *rxdes)
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  235  {
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  236  	return rxdes->rxdes0 & cpu_to_le32(FTMAC100_RXDES0_FTL);
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  237  }
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  238  
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  239  static bool ftmac100_rxdes_runt(struct ftmac100_rxdes *rxdes)
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  240  {
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  241  	return rxdes->rxdes0 & cpu_to_le32(FTMAC100_RXDES0_RUNT);
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  242  }
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  243  
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  244  static bool ftmac100_rxdes_odd_nibble(struct ftmac100_rxdes *rxdes)
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  245  {
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  246  	return rxdes->rxdes0 & cpu_to_le32(FTMAC100_RXDES0_RX_ODD_NB);
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  247  }
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  248  
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  249  static unsigned int ftmac100_rxdes_frame_length(struct ftmac100_rxdes *rxdes)
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  250  {
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28 @251  	return le32_to_cpu(rxdes->rxdes0) & FTMAC100_RXDES0_RFL;
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  252  }
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  253  
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  254  static bool ftmac100_rxdes_multicast(struct ftmac100_rxdes *rxdes)
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  255  {
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  256  	return rxdes->rxdes0 & cpu_to_le32(FTMAC100_RXDES0_MULTICAST);
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  257  }
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  258  
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  259  static void ftmac100_rxdes_set_buffer_size(struct ftmac100_rxdes *rxdes,
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  260  					   unsigned int size)
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  261  {
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28 @262  	rxdes->rxdes1 &= cpu_to_le32(FTMAC100_RXDES1_EDORR);
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  263  	rxdes->rxdes1 |= cpu_to_le32(FTMAC100_RXDES1_RXBUF_SIZE(size));
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  264  }
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  265  
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  266  static void ftmac100_rxdes_set_end_of_ring(struct ftmac100_rxdes *rxdes)
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  267  {
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  268  	rxdes->rxdes1 |= cpu_to_le32(FTMAC100_RXDES1_EDORR);
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  269  }
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  270  
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  271  static void ftmac100_rxdes_set_dma_addr(struct ftmac100_rxdes *rxdes,
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  272  					dma_addr_t addr)
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  273  {
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28 @274  	rxdes->rxdes2 = cpu_to_le32(addr);
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  275  }
8d77c036 drivers/net/ftmac100.c Po-Yu Chuang 2011-02-28  276  

:::::: The code at line 205 was first introduced by commit
:::::: 8d77c036b57cf813d838f859e11b6a188acdb1fb net: add Faraday FTMAC100 10/100 Ethernet driver

:::::: TO: Po-Yu Chuang <ratbert@faraday-tech.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
