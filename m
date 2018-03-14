From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 07/16] CRIS: Drop support for the CRIS port
Date: Wed, 14 Mar 2018 15:36:56 +0100
Message-ID: <20180314143656.1495602-7-arnd@arndb.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <20180314143656.1495602-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314143656.1495602-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jesper Nilsson <jesper@jni.nu>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-arch.vger.kernel.org

From: Jesper Nilsson <jesper@jni.nu>

The port was added back in 2000 so it's no longer even a good source
of inspiration for newer ports (if it ever was)

The last SoC (ARTPEC-3) with a CRIS main CPU was launched in 2008.

Coupled with time and working developer board hardware being
in low supply, it's time to drop the port from Linux.

So long and thanks for all the fish!

Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
 Documentation/00-INDEX                             |    2 -
 Documentation/cris/README                          |  195 -
 Documentation/devicetree/bindings/cris/axis.txt    |    9 -
 Documentation/devicetree/bindings/cris/boards.txt  |    8 -
 .../interrupt-controller/axis,crisv32-intc.txt     |   23 -
 MAINTAINERS                                        |   10 -
 arch/cris/Kconfig                                  |  595 --
 arch/cris/Kconfig.debug                            |   41 -
 arch/cris/Makefile                                 |  104 -
 arch/cris/arch-v10/Kconfig                         |  399 --
 arch/cris/arch-v10/README.mm                       |  244 -
 arch/cris/arch-v10/drivers/Kconfig                 |  561 --
 arch/cris/arch-v10/drivers/Makefile                |   11 -
 arch/cris/arch-v10/drivers/axisflashmap.c          |  413 --
 arch/cris/arch-v10/drivers/eeprom.c                |  852 ---
 arch/cris/arch-v10/drivers/gpio.c                  |  857 ---
 arch/cris/arch-v10/drivers/i2c.c                   |  699 --
 arch/cris/arch-v10/drivers/i2c.h                   |   18 -
 arch/cris/arch-v10/drivers/sync_serial.c           | 1463 ----
 arch/cris/arch-v10/kernel/Makefile                 |   18 -
 arch/cris/arch-v10/kernel/crisksyms.c              |   17 -
 arch/cris/arch-v10/kernel/debugport.c              |  560 --
 arch/cris/arch-v10/kernel/dma.c                    |  288 -
 arch/cris/arch-v10/kernel/entry.S                  |  978 ---
 arch/cris/arch-v10/kernel/fasttimer.c              |  835 ---
 arch/cris/arch-v10/kernel/head.S                   |  620 --
 arch/cris/arch-v10/kernel/io_interface_mux.c       | 1183 ----
 arch/cris/arch-v10/kernel/irq.c                    |  236 -
 arch/cris/arch-v10/kernel/kgdb.c                   | 1128 ---
 arch/cris/arch-v10/kernel/process.c                |  180 -
 arch/cris/arch-v10/kernel/ptrace.c                 |  204 -
 arch/cris/arch-v10/kernel/setup.c                  |  107 -
 arch/cris/arch-v10/kernel/shadows.c                |   37 -
 arch/cris/arch-v10/kernel/signal.c                 |  440 --
 arch/cris/arch-v10/kernel/time.c                   |  268 -
 arch/cris/arch-v10/kernel/traps.c                  |  134 -
 arch/cris/arch-v10/lib/Makefile                    |    6 -
 arch/cris/arch-v10/lib/checksum.S                  |  119 -
 arch/cris/arch-v10/lib/checksumcopy.S              |  127 -
 arch/cris/arch-v10/lib/csumcpfruser.S              |   65 -
 arch/cris/arch-v10/lib/dram_init.S                 |  147 -
 arch/cris/arch-v10/lib/hw_settings.S               |   61 -
 arch/cris/arch-v10/lib/memset.c                    |  259 -
 arch/cris/arch-v10/lib/string.c                    |  236 -
 arch/cris/arch-v10/lib/usercopy.c                  |  511 --
 arch/cris/arch-v10/mm/Makefile                     |    6 -
 arch/cris/arch-v10/mm/fault.c                      |   96 -
 arch/cris/arch-v10/mm/init.c                       |  256 -
 arch/cris/arch-v10/mm/tlb.c                        |  179 -
 arch/cris/arch-v10/output_arch.ld                  |    2 -
 arch/cris/arch-v32/Kconfig                         |  211 -
 arch/cris/arch-v32/drivers/Kconfig                 |  263 -
 arch/cris/arch-v32/drivers/Makefile                |   12 -
 arch/cris/arch-v32/drivers/axisflashmap.c          |  592 --
 arch/cris/arch-v32/drivers/cryptocop.c             | 3522 ----------
 arch/cris/arch-v32/drivers/iop_fw_load.c           |  230 -
 arch/cris/arch-v32/drivers/mach-a3/Makefile        |    5 -
 arch/cris/arch-v32/drivers/mach-a3/nandflash.c     |  177 -
 arch/cris/arch-v32/drivers/mach-fs/Makefile        |    5 -
 arch/cris/arch-v32/drivers/mach-fs/nandflash.c     |  171 -
 arch/cris/arch-v32/drivers/pci/Makefile            |    5 -
 arch/cris/arch-v32/drivers/pci/bios.c              |   74 -
 arch/cris/arch-v32/drivers/sync_serial.c           | 1715 -----
 arch/cris/arch-v32/kernel/Makefile                 |   18 -
 arch/cris/arch-v32/kernel/cache.c                  |   34 -
 arch/cris/arch-v32/kernel/cacheflush.S             |  100 -
 arch/cris/arch-v32/kernel/crisksyms.c              |   26 -
 arch/cris/arch-v32/kernel/debugport.c              |  232 -
 arch/cris/arch-v32/kernel/entry.S                  |  909 ---
 arch/cris/arch-v32/kernel/fasttimer.c              |  793 ---
 arch/cris/arch-v32/kernel/head.S                   |  439 --
 arch/cris/arch-v32/kernel/irq.c                    |  520 --
 arch/cris/arch-v32/kernel/kgdb.c                   | 1593 -----
 arch/cris/arch-v32/kernel/kgdb_asm.S               |  552 --
 arch/cris/arch-v32/kernel/process.c                |  180 -
 arch/cris/arch-v32/kernel/ptrace.c                 |  492 --
 arch/cris/arch-v32/kernel/setup.c                  |  163 -
 arch/cris/arch-v32/kernel/signal.c                 |  541 --
 arch/cris/arch-v32/kernel/time.c                   |  345 -
 arch/cris/arch-v32/kernel/traps.c                  |  196 -
 arch/cris/arch-v32/lib/Makefile                    |    7 -
 arch/cris/arch-v32/lib/checksum.S                  |   89 -
 arch/cris/arch-v32/lib/checksumcopy.S              |   95 -
 arch/cris/arch-v32/lib/csumcpfruser.S              |   70 -
 arch/cris/arch-v32/lib/delay.c                     |   29 -
 arch/cris/arch-v32/lib/memset.c                    |  259 -
 arch/cris/arch-v32/lib/strcmp.S                    |   21 -
 arch/cris/arch-v32/lib/string.c                    |  236 -
 arch/cris/arch-v32/lib/usercopy.c                  |  458 --
 arch/cris/arch-v32/mach-a3/Kconfig                 |  111 -
 arch/cris/arch-v32/mach-a3/Makefile                |    8 -
 arch/cris/arch-v32/mach-a3/arbiter.c               |  635 --
 arch/cris/arch-v32/mach-a3/dma.c                   |  184 -
 arch/cris/arch-v32/mach-a3/dram_init.S             |  119 -
 arch/cris/arch-v32/mach-a3/hw_settings.S           |   54 -
 arch/cris/arch-v32/mach-a3/pinmux.c                |  389 --
 arch/cris/arch-v32/mach-fs/Kconfig                 |  198 -
 arch/cris/arch-v32/mach-fs/Makefile                |    8 -
 arch/cris/arch-v32/mach-fs/arbiter.c               |  405 --
 arch/cris/arch-v32/mach-fs/dma.c                   |  229 -
 arch/cris/arch-v32/mach-fs/dram_init.S             |  117 -
 arch/cris/arch-v32/mach-fs/hw_settings.S           |   71 -
 arch/cris/arch-v32/mach-fs/pinmux.c                |  328 -
 arch/cris/arch-v32/mm/Makefile                     |    4 -
 arch/cris/arch-v32/mm/init.c                       |  163 -
 arch/cris/arch-v32/mm/intmem.c                     |  157 -
 arch/cris/arch-v32/mm/l2cache.c                    |   30 -
 arch/cris/arch-v32/mm/mmu.S                        |  211 -
 arch/cris/arch-v32/mm/tlb.c                        |  209 -
 arch/cris/arch-v32/output_arch.ld                  |    2 -
 arch/cris/boot/.gitignore                          |    2 -
 arch/cris/boot/Makefile                            |   25 -
 arch/cris/boot/compressed/Makefile                 |   36 -
 arch/cris/boot/compressed/README                   |   24 -
 arch/cris/boot/compressed/decompress_v10.lds       |   31 -
 arch/cris/boot/compressed/decompress_v32.lds       |   31 -
 arch/cris/boot/compressed/head_v10.S               |  127 -
 arch/cris/boot/compressed/head_v32.S               |  146 -
 arch/cris/boot/compressed/misc.c                   |  377 -
 arch/cris/boot/dts/Makefile                        |    5 -
 arch/cris/boot/dts/artpec3.dtsi                    |   47 -
 arch/cris/boot/dts/dev88.dts                       |   68 -
 arch/cris/boot/dts/etraxfs.dtsi                    |   47 -
 arch/cris/boot/dts/p1343.dts                       |   77 -
 arch/cris/boot/rescue/Makefile                     |   53 -
 arch/cris/boot/rescue/head_v10.S                   |  358 -
 arch/cris/boot/rescue/head_v32.S                   |   27 -
 arch/cris/boot/rescue/kimagerescue.S               |  142 -
 arch/cris/boot/rescue/rescue_v10.lds               |   21 -
 arch/cris/boot/rescue/rescue_v32.lds               |   44 -
 arch/cris/boot/rescue/testrescue.S                 |   25 -
 arch/cris/boot/tools/build.c                       |  288 -
 arch/cris/configs/artpec_3_defconfig               |   40 -
 arch/cris/configs/dev88_defconfig                  |   48 -
 arch/cris/configs/etrax-100lx_defconfig            |   23 -
 arch/cris/configs/etrax-100lx_v2_defconfig         |   42 -
 arch/cris/configs/etraxfs_defconfig                |   40 -
 arch/cris/include/arch-v10/arch/bitops.h           |   74 -
 arch/cris/include/arch-v10/arch/bug.h              |   74 -
 arch/cris/include/arch-v10/arch/cache.h            |    9 -
 arch/cris/include/arch-v10/arch/checksum.h         |   30 -
 arch/cris/include/arch-v10/arch/delay.h            |   21 -
 arch/cris/include/arch-v10/arch/dma.h              |   75 -
 arch/cris/include/arch-v10/arch/io.h               |  173 -
 arch/cris/include/arch-v10/arch/io_interface_mux.h |   76 -
 arch/cris/include/arch-v10/arch/irq.h              |  162 -
 arch/cris/include/arch-v10/arch/irqflags.h         |   46 -
 arch/cris/include/arch-v10/arch/memmap.h           |   23 -
 arch/cris/include/arch-v10/arch/mmu.h              |  108 -
 arch/cris/include/arch-v10/arch/offset.h           |   34 -
 arch/cris/include/arch-v10/arch/page.h             |   31 -
 arch/cris/include/arch-v10/arch/pgtable.h          |   18 -
 arch/cris/include/arch-v10/arch/processor.h        |   70 -
 arch/cris/include/arch-v10/arch/swab.h             |   31 -
 arch/cris/include/arch-v10/arch/system.h           |   40 -
 arch/cris/include/arch-v10/arch/thread_info.h      |   13 -
 arch/cris/include/arch-v10/arch/timex.h            |   31 -
 arch/cris/include/arch-v10/arch/tlb.h              |   14 -
 arch/cris/include/arch-v10/arch/uaccess.h          |  651 --
 arch/cris/include/arch-v10/arch/unistd.h           |  149 -
 arch/cris/include/arch-v32/arch/bitops.h           |   65 -
 arch/cris/include/arch-v32/arch/bug.h              |   41 -
 arch/cris/include/arch-v32/arch/cache.h            |   22 -
 arch/cris/include/arch-v32/arch/checksum.h         |   30 -
 arch/cris/include/arch-v32/arch/cryptocop.h        |  159 -
 arch/cris/include/arch-v32/arch/delay.h            |   29 -
 arch/cris/include/arch-v32/arch/dma.h              |    1 -
 arch/cris/include/arch-v32/arch/hwregs/Makefile    |  187 -
 .../arch-v32/arch/hwregs/asm/ata_defs_asm.h        |  223 -
 .../arch-v32/arch/hwregs/asm/bif_core_defs_asm.h   |  320 -
 .../arch-v32/arch/hwregs/asm/bif_dma_defs_asm.h    |  496 --
 .../arch-v32/arch/hwregs/asm/bif_slave_defs_asm.h  |  250 -
 .../arch-v32/arch/hwregs/asm/config_defs_asm.h     |  132 -
 .../include/arch-v32/arch/hwregs/asm/cpu_vect.h    |   41 -
 .../arch-v32/arch/hwregs/asm/cris_defs_asm.h       |  115 -
 .../arch-v32/arch/hwregs/asm/cris_supp_reg.h       |   11 -
 .../arch-v32/arch/hwregs/asm/dma_defs_asm.h        |  369 -
 .../arch-v32/arch/hwregs/asm/eth_defs_asm.h        |  499 --
 .../arch-v32/arch/hwregs/asm/gio_defs_asm.h        |  277 -
 .../include/arch-v32/arch/hwregs/asm/intr_vect.h   |   39 -
 .../arch-v32/arch/hwregs/asm/intr_vect_defs_asm.h  |  356 -
 .../arch-v32/arch/hwregs/asm/irq_nmi_defs_asm.h    |   70 -
 .../arch-v32/arch/hwregs/asm/marb_defs_asm.h       |  580 --
 .../arch-v32/arch/hwregs/asm/mmu_defs_asm.h        |  213 -
 .../arch-v32/arch/hwregs/asm/mmu_supp_reg.h        |    8 -
 .../arch-v32/arch/hwregs/asm/rt_trace_defs_asm.h   |  143 -
 .../arch-v32/arch/hwregs/asm/ser_defs_asm.h        |  360 -
 .../arch-v32/arch/hwregs/asm/sser_defs_asm.h       |  463 --
 .../arch-v32/arch/hwregs/asm/strcop_defs_asm.h     |   85 -
 .../arch-v32/arch/hwregs/asm/strmux_defs_asm.h     |  101 -
 .../arch-v32/arch/hwregs/asm/timer_defs_asm.h      |  230 -
 arch/cris/include/arch-v32/arch/hwregs/ata_defs.h  |  223 -
 .../include/arch-v32/arch/hwregs/bif_core_defs.h   |  285 -
 .../include/arch-v32/arch/hwregs/bif_dma_defs.h    |  474 --
 .../include/arch-v32/arch/hwregs/bif_slave_defs.h  |  250 -
 .../include/arch-v32/arch/hwregs/config_defs.h     |  143 -
 arch/cris/include/arch-v32/arch/hwregs/cpu_vect.h  |   42 -
 arch/cris/include/arch-v32/arch/hwregs/dma.h       |  128 -
 arch/cris/include/arch-v32/arch/hwregs/dma_defs.h  |  437 --
 arch/cris/include/arch-v32/arch/hwregs/eth_defs.h  |  379 -
 .../include/arch-v32/arch/hwregs/extmem_defs.h     |  370 -
 .../cris/include/arch-v32/arch/hwregs/iop/Makefile |  147 -
 .../arch/hwregs/iop/asm/iop_crc_par_defs_asm.h     |  172 -
 .../arch/hwregs/iop/asm/iop_dmc_in_defs_asm.h      |  322 -
 .../arch/hwregs/iop/asm/iop_dmc_out_defs_asm.h     |  350 -
 .../arch/hwregs/iop/asm/iop_fifo_in_defs_asm.h     |  235 -
 .../hwregs/iop/asm/iop_fifo_in_extra_defs_asm.h    |  156 -
 .../arch/hwregs/iop/asm/iop_fifo_out_defs_asm.h    |  255 -
 .../hwregs/iop/asm/iop_fifo_out_extra_defs_asm.h   |  159 -
 .../arch/hwregs/iop/asm/iop_mpu_defs_asm.h         |  178 -
 .../arch/hwregs/iop/asm/iop_reg_space_asm.h        |   45 -
 .../arch/hwregs/iop/asm/iop_sap_in_defs_asm.h      |  183 -
 .../arch/hwregs/iop/asm/iop_sap_out_defs_asm.h     |  347 -
 .../arch/hwregs/iop/asm/iop_scrc_in_defs_asm.h     |  112 -
 .../arch/hwregs/iop/asm/iop_scrc_out_defs_asm.h    |  106 -
 .../arch/hwregs/iop/asm/iop_spu_defs_asm.h         |  574 --
 .../arch/hwregs/iop/asm/iop_sw_cfg_defs_asm.h      | 1053 ---
 .../arch/hwregs/iop/asm/iop_sw_cpu_defs_asm.h      | 1759 -----
 .../arch/hwregs/iop/asm/iop_sw_mpu_defs_asm.h      | 1777 -----
 .../arch/hwregs/iop/asm/iop_sw_spu_defs_asm.h      |  692 --
 .../arch/hwregs/iop/asm/iop_timer_grp_defs_asm.h   |  238 -
 .../arch/hwregs/iop/asm/iop_trigger_grp_defs_asm.h |  158 -
 .../arch/hwregs/iop/asm/iop_version_defs_asm.h     |   65 -
 .../arch-v32/arch/hwregs/iop/iop_crc_par_defs.h    |  233 -
 .../arch-v32/arch/hwregs/iop/iop_dmc_in_defs.h     |  326 -
 .../arch-v32/arch/hwregs/iop/iop_dmc_out_defs.h    |  327 -
 .../arch-v32/arch/hwregs/iop/iop_fifo_in_defs.h    |  256 -
 .../arch/hwregs/iop/iop_fifo_in_extra_defs.h       |  165 -
 .../arch-v32/arch/hwregs/iop/iop_fifo_out_defs.h   |  279 -
 .../arch/hwregs/iop/iop_fifo_out_extra_defs.h      |  165 -
 .../arch-v32/arch/hwregs/iop/iop_mpu_defs.h        |  191 -
 .../arch-v32/arch/hwregs/iop/iop_mpu_macros.h      |  765 --
 .../arch-v32/arch/hwregs/iop/iop_reg_space.h       |   45 -
 .../arch-v32/arch/hwregs/iop/iop_sap_in_defs.h     |  180 -
 .../arch-v32/arch/hwregs/iop/iop_sap_out_defs.h    |  307 -
 .../arch-v32/arch/hwregs/iop/iop_scrc_in_defs.h    |  161 -
 .../arch-v32/arch/hwregs/iop/iop_scrc_out_defs.h   |  147 -
 .../arch-v32/arch/hwregs/iop/iop_spu_defs.h        |  454 --
 .../arch-v32/arch/hwregs/iop/iop_sw_cfg_defs.h     | 1043 ---
 .../arch-v32/arch/hwregs/iop/iop_sw_cpu_defs.h     |  854 ---
 .../arch-v32/arch/hwregs/iop/iop_sw_mpu_defs.h     |  894 ---
 .../arch-v32/arch/hwregs/iop/iop_sw_spu_defs.h     |  553 --
 .../arch-v32/arch/hwregs/iop/iop_timer_grp_defs.h  |  250 -
 .../arch/hwregs/iop/iop_trigger_grp_defs.h         |  171 -
 .../arch-v32/arch/hwregs/iop/iop_version_defs.h    |  100 -
 .../include/arch-v32/arch/hwregs/irq_nmi_defs.h    |  105 -
 .../include/arch-v32/arch/hwregs/marb_bp_defs.h    |  206 -
 arch/cris/include/arch-v32/arch/hwregs/marb_defs.h |  476 --
 arch/cris/include/arch-v32/arch/hwregs/reg_rdwr.h  |   18 -
 .../include/arch-v32/arch/hwregs/rt_trace_defs.h   |  174 -
 arch/cris/include/arch-v32/arch/hwregs/ser_defs.h  |  309 -
 arch/cris/include/arch-v32/arch/hwregs/sser_defs.h |  332 -
 arch/cris/include/arch-v32/arch/hwregs/strcop.h    |   58 -
 .../include/arch-v32/arch/hwregs/strcop_defs.h     |  110 -
 arch/cris/include/arch-v32/arch/hwregs/supp_reg.h  |   79 -
 arch/cris/include/arch-v32/arch/intmem.h           |   10 -
 arch/cris/include/arch-v32/arch/irq.h              |  125 -
 arch/cris/include/arch-v32/arch/irqflags.h         |   47 -
 arch/cris/include/arch-v32/arch/memmap.h           |    1 -
 arch/cris/include/arch-v32/arch/mmu.h              |  111 -
 arch/cris/include/arch-v32/arch/offset.h           |   36 -
 arch/cris/include/arch-v32/arch/page.h             |   23 -
 arch/cris/include/arch-v32/arch/pgtable.h          |   18 -
 arch/cris/include/arch-v32/arch/processor.h        |   54 -
 arch/cris/include/arch-v32/arch/swab.h             |   25 -
 arch/cris/include/arch-v32/arch/system.h           |   38 -
 arch/cris/include/arch-v32/arch/thread_info.h      |   14 -
 arch/cris/include/arch-v32/arch/timex.h            |   32 -
 arch/cris/include/arch-v32/arch/tlb.h              |   15 -
 arch/cris/include/arch-v32/arch/uaccess.h          |  730 --
 arch/cris/include/arch-v32/arch/unistd.h           |  156 -
 arch/cris/include/arch-v32/mach-a3/mach/arbiter.h  |   35 -
 arch/cris/include/arch-v32/mach-a3/mach/dma.h      |   59 -
 .../mach-a3/mach/hwregs/asm/clkgen_defs_asm.h      |  165 -
 .../mach-a3/mach/hwregs/asm/ddr2_defs_asm.h        |  267 -
 .../mach-a3/mach/hwregs/asm/gio_defs_asm.h         |  850 ---
 .../mach-a3/mach/hwregs/asm/pinmux_defs_asm.h      |  573 --
 .../mach-a3/mach/hwregs/asm/pio_defs_asm.h         |  338 -
 .../arch-v32/mach-a3/mach/hwregs/asm/reg_map_asm.h |  100 -
 .../mach-a3/mach/hwregs/asm/timer_defs_asm.h       |  229 -
 .../arch-v32/mach-a3/mach/hwregs/clkgen_defs.h     |  160 -
 .../arch-v32/mach-a3/mach/hwregs/ddr2_defs.h       |  282 -
 .../arch-v32/mach-a3/mach/hwregs/gio_defs.h        |  838 ---
 .../arch-v32/mach-a3/mach/hwregs/intr_vect.h       |   47 -
 .../arch-v32/mach-a3/mach/hwregs/intr_vect_defs.h  |  342 -
 .../mach/hwregs/iop/asm/iop_reg_space_asm.h        |   32 -
 .../mach/hwregs/iop/asm/iop_sap_in_defs_asm.h      |  110 -
 .../mach/hwregs/iop/asm/iop_sap_out_defs_asm.h     |  277 -
 .../mach/hwregs/iop/asm/iop_sw_cfg_defs_asm.h      |  740 --
 .../mach/hwregs/iop/asm/iop_sw_cpu_defs_asm.h      |  951 ---
 .../mach/hwregs/iop/asm/iop_sw_mpu_defs_asm.h      | 1087 ---
 .../mach/hwregs/iop/asm/iop_sw_spu_defs_asm.h      |  524 --
 .../mach/hwregs/iop/asm/iop_version_defs_asm.h     |   62 -
 .../mach-a3/mach/hwregs/iop/iop_reg_space.h        |   32 -
 .../mach-a3/mach/hwregs/iop/iop_sap_in_defs.h      |  142 -
 .../mach-a3/mach/hwregs/iop/iop_sap_out_defs.h     |  232 -
 .../mach-a3/mach/hwregs/iop/iop_sw_cfg_defs.h      |  726 --
 .../mach-a3/mach/hwregs/iop/iop_sw_cpu_defs.h      |  523 --
 .../mach-a3/mach/hwregs/iop/iop_sw_mpu_defs.h      |  649 --
 .../mach-a3/mach/hwregs/iop/iop_sw_spu_defs.h      |  442 --
 .../mach-a3/mach/hwregs/iop/iop_version_defs.h     |   97 -
 .../arch-v32/mach-a3/mach/hwregs/l2cache_defs.h    |  143 -
 .../arch-v32/mach-a3/mach/hwregs/marb_bar_defs.h   |  483 --
 .../arch-v32/mach-a3/mach/hwregs/marb_foo_defs.h   |  627 --
 .../arch-v32/mach-a3/mach/hwregs/pinmux_defs.h     |  313 -
 .../arch-v32/mach-a3/mach/hwregs/pio_defs.h        |  372 -
 .../include/arch-v32/mach-a3/mach/hwregs/reg_map.h |  104 -
 .../arch-v32/mach-a3/mach/hwregs/strmux_defs.h     |  121 -
 .../arch-v32/mach-a3/mach/hwregs/timer_defs.h      |  266 -
 arch/cris/include/arch-v32/mach-a3/mach/memmap.h   |   11 -
 arch/cris/include/arch-v32/mach-a3/mach/pinmux.h   |   46 -
 .../cris/include/arch-v32/mach-a3/mach/startup.inc |   84 -
 arch/cris/include/arch-v32/mach-fs/mach/arbiter.h  |   29 -
 arch/cris/include/arch-v32/mach-fs/mach/dma.h      |   80 -
 .../mach-fs/mach/hwregs/asm/bif_core_defs_asm.h    |  320 -
 .../mach-fs/mach/hwregs/asm/config_defs_asm.h      |  132 -
 .../mach-fs/mach/hwregs/asm/gio_defs_asm.h         |  277 -
 .../mach-fs/mach/hwregs/asm/pinmux_defs_asm.h      |  633 --
 .../arch-v32/mach-fs/mach/hwregs/asm/reg_map_asm.h |   97 -
 .../mach-fs/mach/hwregs/asm/timer_defs_asm.h       |  230 -
 .../arch-v32/mach-fs/mach/hwregs/bif_core_defs.h   |  285 -
 .../arch-v32/mach-fs/mach/hwregs/bif_dma_defs.h    |  474 --
 .../arch-v32/mach-fs/mach/hwregs/bif_slave_defs.h  |  250 -
 .../arch-v32/mach-fs/mach/hwregs/config_defs.h     |  143 -
 .../arch-v32/mach-fs/mach/hwregs/gio_defs.h        |  296 -
 .../arch-v32/mach-fs/mach/hwregs/intr_vect.h       |   42 -
 .../arch-v32/mach-fs/mach/hwregs/intr_vect_defs.h  |  229 -
 .../arch-v32/mach-fs/mach/hwregs/marb_bp_defs.h    |  206 -
 .../arch-v32/mach-fs/mach/hwregs/marb_defs.h       |  476 --
 .../arch-v32/mach-fs/mach/hwregs/pinmux_defs.h     |  358 -
 .../include/arch-v32/mach-fs/mach/hwregs/reg_map.h |  105 -
 .../arch-v32/mach-fs/mach/hwregs/strmux_defs.h     |  128 -
 .../arch-v32/mach-fs/mach/hwregs/timer_defs.h      |  267 -
 arch/cris/include/arch-v32/mach-fs/mach/memmap.h   |   25 -
 arch/cris/include/arch-v32/mach-fs/mach/pinmux.h   |   37 -
 .../cris/include/arch-v32/mach-fs/mach/startup.inc |   76 -
 arch/cris/include/asm/Kbuild                       |   31 -
 arch/cris/include/asm/asm-offsets.h                |    1 -
 arch/cris/include/asm/axisflashmap.h               |   62 -
 arch/cris/include/asm/bitops.h                     |   51 -
 arch/cris/include/asm/bug.h                        |    5 -
 arch/cris/include/asm/bugs.h                       |   21 -
 arch/cris/include/asm/cache.h                      |    7 -
 arch/cris/include/asm/cacheflush.h                 |   33 -
 arch/cris/include/asm/checksum.h                   |   83 -
 arch/cris/include/asm/delay.h                      |   28 -
 arch/cris/include/asm/dma.h                        |   22 -
 arch/cris/include/asm/eshlibld.h                   |  113 -
 arch/cris/include/asm/etraxi2c.h                   |   37 -
 arch/cris/include/asm/fasttimer.h                  |   48 -
 arch/cris/include/asm/fb.h                         |   13 -
 arch/cris/include/asm/ftrace.h                     |    1 -
 arch/cris/include/asm/hw_irq.h                     |    5 -
 arch/cris/include/asm/io.h                         |   26 -
 arch/cris/include/asm/irq.h                        |   14 -
 arch/cris/include/asm/irqflags.h                   |    1 -
 arch/cris/include/asm/mmu.h                        |   11 -
 arch/cris/include/asm/mmu_context.h                |   35 -
 arch/cris/include/asm/page.h                       |   74 -
 arch/cris/include/asm/pci.h                        |   44 -
 arch/cris/include/asm/pgalloc.h                    |   64 -
 arch/cris/include/asm/pgtable.h                    |  297 -
 arch/cris/include/asm/processor.h                  |   59 -
 arch/cris/include/asm/ptrace.h                     |   15 -
 arch/cris/include/asm/segment.h                    |    9 -
 arch/cris/include/asm/serial.h                     |   10 -
 arch/cris/include/asm/shmparam.h                   |    9 -
 arch/cris/include/asm/signal.h                     |   24 -
 arch/cris/include/asm/stacktrace.h                 |    9 -
 arch/cris/include/asm/string.h                     |   21 -
 arch/cris/include/asm/swab.h                       |    8 -
 arch/cris/include/asm/switch_to.h                  |   13 -
 arch/cris/include/asm/termios.h                    |   52 -
 arch/cris/include/asm/thread_info.h                |   91 -
 arch/cris/include/asm/timex.h                      |   25 -
 arch/cris/include/asm/tlb.h                        |   20 -
 arch/cris/include/asm/tlbflush.h                   |   42 -
 arch/cris/include/asm/uaccess.h                    |  361 -
 arch/cris/include/asm/ucontext.h                   |   13 -
 arch/cris/include/asm/unaligned.h                  |   14 -
 arch/cris/include/asm/unistd.h                     |   37 -
 arch/cris/include/asm/user.h                       |   53 -
 arch/cris/include/uapi/arch-v10/arch/sv_addr.agh   | 7306 --------------------
 arch/cris/include/uapi/arch-v10/arch/sv_addr_ag.h  |  140 -
 arch/cris/include/uapi/arch-v10/arch/svinto.h      |   65 -
 arch/cris/include/uapi/arch-v10/arch/user.h        |   47 -
 arch/cris/include/uapi/arch-v32/arch/cryptocop.h   |  123 -
 arch/cris/include/uapi/arch-v32/arch/user.h        |   42 -
 arch/cris/include/uapi/asm/Kbuild                  |   22 -
 arch/cris/include/uapi/asm/byteorder.h             |    9 -
 arch/cris/include/uapi/asm/elf.h                   |   91 -
 arch/cris/include/uapi/asm/elf_v10.h               |   85 -
 arch/cris/include/uapi/asm/elf_v32.h               |   77 -
 arch/cris/include/uapi/asm/ethernet.h              |   22 -
 arch/cris/include/uapi/asm/etraxgpio.h             |   83 -
 arch/cris/include/uapi/asm/ioctls.h                |   12 -
 arch/cris/include/uapi/asm/param.h                 |   11 -
 arch/cris/include/uapi/asm/posix_types.h           |   31 -
 arch/cris/include/uapi/asm/ptrace.h                |    6 -
 arch/cris/include/uapi/asm/ptrace_v10.h            |  119 -
 arch/cris/include/uapi/asm/ptrace_v32.h            |  119 -
 arch/cris/include/uapi/asm/rs485.h                 |   19 -
 arch/cris/include/uapi/asm/setup.h                 |    7 -
 arch/cris/include/uapi/asm/sigcontext.h            |   25 -
 arch/cris/include/uapi/asm/signal.h                |  117 -
 arch/cris/include/uapi/asm/stat.h                  |   82 -
 arch/cris/include/uapi/asm/swab.h                  |    3 -
 arch/cris/include/uapi/asm/sync_serial.h           |  133 -
 arch/cris/include/uapi/asm/termbits.h              |  236 -
 arch/cris/include/uapi/asm/termios.h               |   46 -
 arch/cris/include/uapi/asm/unistd.h                |  369 -
 arch/cris/kernel/Makefile                          |   17 -
 arch/cris/kernel/asm-offsets.c                     |   60 -
 arch/cris/kernel/crisksyms.c                       |   69 -
 arch/cris/kernel/irq.c                             |   72 -
 arch/cris/kernel/module.c                          |   82 -
 arch/cris/kernel/process.c                         |   81 -
 arch/cris/kernel/profile.c                         |   87 -
 arch/cris/kernel/ptrace.c                          |   68 -
 arch/cris/kernel/setup.c                           |  214 -
 arch/cris/kernel/stacktrace.c                      |   76 -
 arch/cris/kernel/sys_cris.c                        |   36 -
 arch/cris/kernel/time.c                            |   73 -
 arch/cris/kernel/traps.c                           |  241 -
 arch/cris/kernel/vmlinux.lds.S                     |  138 -
 arch/cris/mm/Makefile                              |    6 -
 arch/cris/mm/fault.c                               |  390 --
 arch/cris/mm/init.c                                |   69 -
 arch/cris/mm/ioremap.c                             |   90 -
 arch/cris/mm/tlb.c                                 |  117 -
 430 files changed, 99983 deletions(-)

 diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index ee2808415f64..708dc4c166e4 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -112,8 +112,6 @@ cputopology.txt
 	- documentation on how CPU topology info is exported via sysfs.
 crc32.txt
 	- brief tutorial on CRC computation
-cris/
-	- directory with info about Linux on CRIS architecture.
 crypto/
 	- directory with info on the Crypto API.
 dcdbas.txt
diff --git a/Documentation/cris/README b/Documentation/cris/README
deleted file mode 100644
index 8dbdb1a44429..000000000000
diff --git a/Documentation/devicetree/bindings/cris/axis.txt b/Documentation/devicetree/bindings/cris/axis.txt
deleted file mode 100644
index d209ca2a47c0..000000000000
diff --git a/Documentation/devicetree/bindings/cris/boards.txt b/Documentation/devicetree/bindings/cris/boards.txt
deleted file mode 100644
index 533dd273ccf7..000000000000
diff --git a/Documentation/devicetree/bindings/interrupt-controller/axis,crisv32-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/axis,crisv32-intc.txt
deleted file mode 100644
index e8b123b0a5e6..000000000000
diff --git a/MAINTAINERS b/MAINTAINERS
index ac6083ae4f94..c06fcd0e1514 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3704,16 +3704,6 @@ S:	Maintained
 F:	Documentation/filesystems/cramfs.txt
 F:	fs/cramfs/
 
-CRIS PORT
-M:	Mikael Starvik <starvik@axis.com>
-M:	Jesper Nilsson <jesper.nilsson@axis.com>
-L:	linux-cris-kernel@axis.com
-W:	http://developer.axis.com
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jesper/cris.git
-S:	Maintained
-F:	arch/cris/
-F:	drivers/tty/serial/crisv10.*
-
 CRYPTO API
 M:	Herbert Xu <herbert@gondor.apana.org.au>
 M:	"David S. Miller" <davem@davemloft.net>
diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
deleted file mode 100644
index cd5a0865c97f..000000000000
diff --git a/arch/cris/Kconfig.debug b/arch/cris/Kconfig.debug
deleted file mode 100644
index 6084d5e0c512..000000000000
diff --git a/arch/cris/Makefile b/arch/cris/Makefile
deleted file mode 100644
index 4a5404b3d0e4..000000000000
diff --git a/arch/cris/arch-v10/Kconfig b/arch/cris/arch-v10/Kconfig
deleted file mode 100644
index d4015a931374..000000000000
diff --git a/arch/cris/arch-v10/README.mm b/arch/cris/arch-v10/README.mm
deleted file mode 100644
index 67731d75cb51..000000000000
diff --git a/arch/cris/arch-v10/drivers/Kconfig b/arch/cris/arch-v10/drivers/Kconfig
deleted file mode 100644
index 8792af63c049..000000000000
diff --git a/arch/cris/arch-v10/drivers/Makefile b/arch/cris/arch-v10/drivers/Makefile
deleted file mode 100644
index d5549dca81bf..000000000000
diff --git a/arch/cris/arch-v10/drivers/axisflashmap.c b/arch/cris/arch-v10/drivers/axisflashmap.c
deleted file mode 100644
index 28292da49664..000000000000
diff --git a/arch/cris/arch-v10/drivers/eeprom.c b/arch/cris/arch-v10/drivers/eeprom.c
deleted file mode 100644
index 2d312c8a4dd5..000000000000
diff --git a/arch/cris/arch-v10/drivers/gpio.c b/arch/cris/arch-v10/drivers/gpio.c
deleted file mode 100644
index cd0e05d89d42..000000000000
diff --git a/arch/cris/arch-v10/drivers/i2c.c b/arch/cris/arch-v10/drivers/i2c.c
deleted file mode 100644
index ec35d62e8e63..000000000000
diff --git a/arch/cris/arch-v10/drivers/i2c.h b/arch/cris/arch-v10/drivers/i2c.h
deleted file mode 100644
index de45c1ffbd7b..000000000000
diff --git a/arch/cris/arch-v10/drivers/sync_serial.c b/arch/cris/arch-v10/drivers/sync_serial.c
deleted file mode 100644
index ed1a568a7217..000000000000
diff --git a/arch/cris/arch-v10/kernel/Makefile b/arch/cris/arch-v10/kernel/Makefile
deleted file mode 100644
index 7ec04b4a285e..000000000000
diff --git a/arch/cris/arch-v10/kernel/crisksyms.c b/arch/cris/arch-v10/kernel/crisksyms.c
deleted file mode 100644
index e1d897ed5b37..000000000000
diff --git a/arch/cris/arch-v10/kernel/debugport.c b/arch/cris/arch-v10/kernel/debugport.c
deleted file mode 100644
index d30834d4dd7e..000000000000
diff --git a/arch/cris/arch-v10/kernel/dma.c b/arch/cris/arch-v10/kernel/dma.c
deleted file mode 100644
index c68e978def05..000000000000
diff --git a/arch/cris/arch-v10/kernel/entry.S b/arch/cris/arch-v10/kernel/entry.S
deleted file mode 100644
index 1f066eebbd2b..000000000000
diff --git a/arch/cris/arch-v10/kernel/fasttimer.c b/arch/cris/arch-v10/kernel/fasttimer.c
deleted file mode 100644
index 94abbff557ff..000000000000
diff --git a/arch/cris/arch-v10/kernel/head.S b/arch/cris/arch-v10/kernel/head.S
deleted file mode 100644
index b260a8833903..000000000000
diff --git a/arch/cris/arch-v10/kernel/io_interface_mux.c b/arch/cris/arch-v10/kernel/io_interface_mux.c
deleted file mode 100644
index 13a887ce115a..000000000000
diff --git a/arch/cris/arch-v10/kernel/irq.c b/arch/cris/arch-v10/kernel/irq.c
deleted file mode 100644
index df11e383acdd..000000000000
diff --git a/arch/cris/arch-v10/kernel/kgdb.c b/arch/cris/arch-v10/kernel/kgdb.c
deleted file mode 100644
index 79b13564d15c..000000000000
diff --git a/arch/cris/arch-v10/kernel/process.c b/arch/cris/arch-v10/kernel/process.c
deleted file mode 100644
index 16848b2c61c8..000000000000
diff --git a/arch/cris/arch-v10/kernel/ptrace.c b/arch/cris/arch-v10/kernel/ptrace.c
deleted file mode 100644
index b89f57ae096e..000000000000
diff --git a/arch/cris/arch-v10/kernel/setup.c b/arch/cris/arch-v10/kernel/setup.c
deleted file mode 100644
index 8e4fc248f96f..000000000000
diff --git a/arch/cris/arch-v10/kernel/shadows.c b/arch/cris/arch-v10/kernel/shadows.c
deleted file mode 100644
index 2e9565e868f2..000000000000
diff --git a/arch/cris/arch-v10/kernel/signal.c b/arch/cris/arch-v10/kernel/signal.c
deleted file mode 100644
index 2beffc37faf8..000000000000
diff --git a/arch/cris/arch-v10/kernel/time.c b/arch/cris/arch-v10/kernel/time.c
deleted file mode 100644
index 3d78373db254..000000000000
diff --git a/arch/cris/arch-v10/kernel/traps.c b/arch/cris/arch-v10/kernel/traps.c
deleted file mode 100644
index 876d45b957f4..000000000000
diff --git a/arch/cris/arch-v10/lib/Makefile b/arch/cris/arch-v10/lib/Makefile
deleted file mode 100644
index 725153edb764..000000000000
diff --git a/arch/cris/arch-v10/lib/checksum.S b/arch/cris/arch-v10/lib/checksum.S
deleted file mode 100644
index a3b96391706f..000000000000
diff --git a/arch/cris/arch-v10/lib/checksumcopy.S b/arch/cris/arch-v10/lib/checksumcopy.S
deleted file mode 100644
index b21449cb1ad3..000000000000
diff --git a/arch/cris/arch-v10/lib/csumcpfruser.S b/arch/cris/arch-v10/lib/csumcpfruser.S
deleted file mode 100644
index beb8992ed478..000000000000
diff --git a/arch/cris/arch-v10/lib/dram_init.S b/arch/cris/arch-v10/lib/dram_init.S
deleted file mode 100644
index fd7437577938..000000000000
diff --git a/arch/cris/arch-v10/lib/hw_settings.S b/arch/cris/arch-v10/lib/hw_settings.S
deleted file mode 100644
index 0d449852517e..000000000000
diff --git a/arch/cris/arch-v10/lib/memset.c b/arch/cris/arch-v10/lib/memset.c
deleted file mode 100644
index c94ea9b3ec29..000000000000
diff --git a/arch/cris/arch-v10/lib/string.c b/arch/cris/arch-v10/lib/string.c
deleted file mode 100644
index c7bd6ebdc93c..000000000000
diff --git a/arch/cris/arch-v10/lib/usercopy.c b/arch/cris/arch-v10/lib/usercopy.c
deleted file mode 100644
index 3f1e2f4680f7..000000000000
diff --git a/arch/cris/arch-v10/mm/Makefile b/arch/cris/arch-v10/mm/Makefile
deleted file mode 100644
index 588b4baee85e..000000000000
diff --git a/arch/cris/arch-v10/mm/fault.c b/arch/cris/arch-v10/mm/fault.c
deleted file mode 100644
index e6c225169642..000000000000
diff --git a/arch/cris/arch-v10/mm/init.c b/arch/cris/arch-v10/mm/init.c
deleted file mode 100644
index 4da99a0e3b57..000000000000
diff --git a/arch/cris/arch-v10/mm/tlb.c b/arch/cris/arch-v10/mm/tlb.c
deleted file mode 100644
index 7f1f752f2445..000000000000
diff --git a/arch/cris/arch-v10/output_arch.ld b/arch/cris/arch-v10/output_arch.ld
deleted file mode 100644
index 2f3288006991..000000000000
diff --git a/arch/cris/arch-v32/Kconfig b/arch/cris/arch-v32/Kconfig
deleted file mode 100644
index 958dabfca7eb..000000000000
diff --git a/arch/cris/arch-v32/drivers/Kconfig b/arch/cris/arch-v32/drivers/Kconfig
deleted file mode 100644
index 4d2d744bced2..000000000000
diff --git a/arch/cris/arch-v32/drivers/Makefile b/arch/cris/arch-v32/drivers/Makefile
deleted file mode 100644
index 57c9568707b0..000000000000
diff --git a/arch/cris/arch-v32/drivers/axisflashmap.c b/arch/cris/arch-v32/drivers/axisflashmap.c
deleted file mode 100644
index 87656c41fec7..000000000000
diff --git a/arch/cris/arch-v32/drivers/cryptocop.c b/arch/cris/arch-v32/drivers/cryptocop.c
deleted file mode 100644
index a3c353472a8c..000000000000
diff --git a/arch/cris/arch-v32/drivers/iop_fw_load.c b/arch/cris/arch-v32/drivers/iop_fw_load.c
deleted file mode 100644
index 2f8ea0f7a63c..000000000000
diff --git a/arch/cris/arch-v32/drivers/mach-a3/Makefile b/arch/cris/arch-v32/drivers/mach-a3/Makefile
deleted file mode 100644
index 59028d0b981c..000000000000
diff --git a/arch/cris/arch-v32/drivers/mach-a3/nandflash.c b/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
deleted file mode 100644
index 925a98eb6d68..000000000000
diff --git a/arch/cris/arch-v32/drivers/mach-fs/Makefile b/arch/cris/arch-v32/drivers/mach-fs/Makefile
deleted file mode 100644
index 59028d0b981c..000000000000
diff --git a/arch/cris/arch-v32/drivers/mach-fs/nandflash.c b/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
deleted file mode 100644
index 53b56a429dde..000000000000
diff --git a/arch/cris/arch-v32/drivers/pci/Makefile b/arch/cris/arch-v32/drivers/pci/Makefile
deleted file mode 100644
index 93c8be6170b1..000000000000
diff --git a/arch/cris/arch-v32/drivers/pci/bios.c b/arch/cris/arch-v32/drivers/pci/bios.c
deleted file mode 100644
index 6b9e6cfaa29e..000000000000
diff --git a/arch/cris/arch-v32/drivers/sync_serial.c b/arch/cris/arch-v32/drivers/sync_serial.c
deleted file mode 100644
index 1b0ce8a8af16..000000000000
diff --git a/arch/cris/arch-v32/kernel/Makefile b/arch/cris/arch-v32/kernel/Makefile
deleted file mode 100644
index 2db7e4f7c1fa..000000000000
diff --git a/arch/cris/arch-v32/kernel/cache.c b/arch/cris/arch-v32/kernel/cache.c
deleted file mode 100644
index a080d2fa4803..000000000000
diff --git a/arch/cris/arch-v32/kernel/cacheflush.S b/arch/cris/arch-v32/kernel/cacheflush.S
deleted file mode 100644
index 2a54d793f96c..000000000000
diff --git a/arch/cris/arch-v32/kernel/crisksyms.c b/arch/cris/arch-v32/kernel/crisksyms.c
deleted file mode 100644
index 8cc8ad1cb532..000000000000
diff --git a/arch/cris/arch-v32/kernel/debugport.c b/arch/cris/arch-v32/kernel/debugport.c
deleted file mode 100644
index 69247fd2090a..000000000000
diff --git a/arch/cris/arch-v32/kernel/entry.S b/arch/cris/arch-v32/kernel/entry.S
deleted file mode 100644
index 0793a52b2c34..000000000000
diff --git a/arch/cris/arch-v32/kernel/fasttimer.c b/arch/cris/arch-v32/kernel/fasttimer.c
deleted file mode 100644
index 7452c70f61ff..000000000000
diff --git a/arch/cris/arch-v32/kernel/head.S b/arch/cris/arch-v32/kernel/head.S
deleted file mode 100644
index 92f9fb1f6845..000000000000
diff --git a/arch/cris/arch-v32/kernel/irq.c b/arch/cris/arch-v32/kernel/irq.c
deleted file mode 100644
index 414afd543232..000000000000
diff --git a/arch/cris/arch-v32/kernel/kgdb.c b/arch/cris/arch-v32/kernel/kgdb.c
deleted file mode 100644
index 3d6f516763a5..000000000000
diff --git a/arch/cris/arch-v32/kernel/kgdb_asm.S b/arch/cris/arch-v32/kernel/kgdb_asm.S
deleted file mode 100644
index c26ea6b0e334..000000000000
diff --git a/arch/cris/arch-v32/kernel/process.c b/arch/cris/arch-v32/kernel/process.c
deleted file mode 100644
index a02f276d0ed4..000000000000
diff --git a/arch/cris/arch-v32/kernel/ptrace.c b/arch/cris/arch-v32/kernel/ptrace.c
deleted file mode 100644
index ccac1aaadc8a..000000000000
diff --git a/arch/cris/arch-v32/kernel/setup.c b/arch/cris/arch-v32/kernel/setup.c
deleted file mode 100644
index a36372e35e96..000000000000
diff --git a/arch/cris/arch-v32/kernel/signal.c b/arch/cris/arch-v32/kernel/signal.c
deleted file mode 100644
index 4f2e3ba3bf40..000000000000
diff --git a/arch/cris/arch-v32/kernel/time.c b/arch/cris/arch-v32/kernel/time.c
deleted file mode 100644
index d07a3912687e..000000000000
diff --git a/arch/cris/arch-v32/kernel/traps.c b/arch/cris/arch-v32/kernel/traps.c
deleted file mode 100644
index ba54c7eccbaa..000000000000
diff --git a/arch/cris/arch-v32/lib/Makefile b/arch/cris/arch-v32/lib/Makefile
deleted file mode 100644
index e91cf02f625d..000000000000
diff --git a/arch/cris/arch-v32/lib/checksum.S b/arch/cris/arch-v32/lib/checksum.S
deleted file mode 100644
index f773d4d93609..000000000000
diff --git a/arch/cris/arch-v32/lib/checksumcopy.S b/arch/cris/arch-v32/lib/checksumcopy.S
deleted file mode 100644
index a76e586d4114..000000000000
diff --git a/arch/cris/arch-v32/lib/csumcpfruser.S b/arch/cris/arch-v32/lib/csumcpfruser.S
deleted file mode 100644
index 093cd757fcfa..000000000000
diff --git a/arch/cris/arch-v32/lib/delay.c b/arch/cris/arch-v32/lib/delay.c
deleted file mode 100644
index db06a94ef646..000000000000
diff --git a/arch/cris/arch-v32/lib/memset.c b/arch/cris/arch-v32/lib/memset.c
deleted file mode 100644
index c94ea9b3ec29..000000000000
diff --git a/arch/cris/arch-v32/lib/strcmp.S b/arch/cris/arch-v32/lib/strcmp.S
deleted file mode 100644
index 8f7a1ee62591..000000000000
diff --git a/arch/cris/arch-v32/lib/string.c b/arch/cris/arch-v32/lib/string.c
deleted file mode 100644
index c7bd6ebdc93c..000000000000
diff --git a/arch/cris/arch-v32/lib/usercopy.c b/arch/cris/arch-v32/lib/usercopy.c
deleted file mode 100644
index 04e78b6ffa22..000000000000
diff --git a/arch/cris/arch-v32/mach-a3/Kconfig b/arch/cris/arch-v32/mach-a3/Kconfig
deleted file mode 100644
index 7b63755544dd..000000000000
diff --git a/arch/cris/arch-v32/mach-a3/Makefile b/arch/cris/arch-v32/mach-a3/Makefile
deleted file mode 100644
index 0cc6eebacbed..000000000000
diff --git a/arch/cris/arch-v32/mach-a3/arbiter.c b/arch/cris/arch-v32/mach-a3/arbiter.c
deleted file mode 100644
index 076182cc65a3..000000000000
diff --git a/arch/cris/arch-v32/mach-a3/dma.c b/arch/cris/arch-v32/mach-a3/dma.c
deleted file mode 100644
index 3f4e923b2527..000000000000
diff --git a/arch/cris/arch-v32/mach-a3/dram_init.S b/arch/cris/arch-v32/mach-a3/dram_init.S
deleted file mode 100644
index 733c3564ad79..000000000000
diff --git a/arch/cris/arch-v32/mach-a3/hw_settings.S b/arch/cris/arch-v32/mach-a3/hw_settings.S
deleted file mode 100644
index 7c325cc59e1f..000000000000
diff --git a/arch/cris/arch-v32/mach-a3/pinmux.c b/arch/cris/arch-v32/mach-a3/pinmux.c
deleted file mode 100644
index 4875bf7aa53f..000000000000
diff --git a/arch/cris/arch-v32/mach-fs/Kconfig b/arch/cris/arch-v32/mach-fs/Kconfig
deleted file mode 100644
index 743ba3bcbaec..000000000000
diff --git a/arch/cris/arch-v32/mach-fs/Makefile b/arch/cris/arch-v32/mach-fs/Makefile
deleted file mode 100644
index 0cc6eebacbed..000000000000
diff --git a/arch/cris/arch-v32/mach-fs/arbiter.c b/arch/cris/arch-v32/mach-fs/arbiter.c
deleted file mode 100644
index c4750d97e46c..000000000000
diff --git a/arch/cris/arch-v32/mach-fs/dma.c b/arch/cris/arch-v32/mach-fs/dma.c
deleted file mode 100644
index c0347a4f8c65..000000000000
diff --git a/arch/cris/arch-v32/mach-fs/dram_init.S b/arch/cris/arch-v32/mach-fs/dram_init.S
deleted file mode 100644
index e1a01fa4c272..000000000000
diff --git a/arch/cris/arch-v32/mach-fs/hw_settings.S b/arch/cris/arch-v32/mach-fs/hw_settings.S
deleted file mode 100644
index 7fbadcc48c0c..000000000000
diff --git a/arch/cris/arch-v32/mach-fs/pinmux.c b/arch/cris/arch-v32/mach-fs/pinmux.c
deleted file mode 100644
index a0b2f101003a..000000000000
diff --git a/arch/cris/arch-v32/mm/Makefile b/arch/cris/arch-v32/mm/Makefile
deleted file mode 100644
index 0b801f2964ac..000000000000
diff --git a/arch/cris/arch-v32/mm/init.c b/arch/cris/arch-v32/mm/init.c
deleted file mode 100644
index 784876afa001..000000000000
diff --git a/arch/cris/arch-v32/mm/intmem.c b/arch/cris/arch-v32/mm/intmem.c
deleted file mode 100644
index 928b94d1d320..000000000000
diff --git a/arch/cris/arch-v32/mm/l2cache.c b/arch/cris/arch-v32/mm/l2cache.c
deleted file mode 100644
index 4fef321d5606..000000000000
diff --git a/arch/cris/arch-v32/mm/mmu.S b/arch/cris/arch-v32/mm/mmu.S
deleted file mode 100644
index f24965703f6d..000000000000
diff --git a/arch/cris/arch-v32/mm/tlb.c b/arch/cris/arch-v32/mm/tlb.c
deleted file mode 100644
index 9e4b5ab4971d..000000000000
diff --git a/arch/cris/arch-v32/output_arch.ld b/arch/cris/arch-v32/output_arch.ld
deleted file mode 100644
index d60a57db0ec2..000000000000
diff --git a/arch/cris/boot/.gitignore b/arch/cris/boot/.gitignore
deleted file mode 100644
index 171a0853caf8..000000000000
diff --git a/arch/cris/boot/Makefile b/arch/cris/boot/Makefile
deleted file mode 100644
index 859d275f862b..000000000000
diff --git a/arch/cris/boot/compressed/Makefile b/arch/cris/boot/compressed/Makefile
deleted file mode 100644
index e149c3467c93..000000000000
diff --git a/arch/cris/boot/compressed/README b/arch/cris/boot/compressed/README
deleted file mode 100644
index 182c5d75784b..000000000000
diff --git a/arch/cris/boot/compressed/decompress_v10.lds b/arch/cris/boot/compressed/decompress_v10.lds
deleted file mode 100644
index d8326779dda2..000000000000
diff --git a/arch/cris/boot/compressed/decompress_v32.lds b/arch/cris/boot/compressed/decompress_v32.lds
deleted file mode 100644
index 91d311c243ed..000000000000
diff --git a/arch/cris/boot/compressed/head_v10.S b/arch/cris/boot/compressed/head_v10.S
deleted file mode 100644
index 08198d8cd37f..000000000000
diff --git a/arch/cris/boot/compressed/head_v32.S b/arch/cris/boot/compressed/head_v32.S
deleted file mode 100644
index a997947d31e3..000000000000
diff --git a/arch/cris/boot/compressed/misc.c b/arch/cris/boot/compressed/misc.c
deleted file mode 100644
index 1ad464a117b8..000000000000
diff --git a/arch/cris/boot/dts/Makefile b/arch/cris/boot/dts/Makefile
deleted file mode 100644
index 118fe990a173..000000000000
diff --git a/arch/cris/boot/dts/artpec3.dtsi b/arch/cris/boot/dts/artpec3.dtsi
deleted file mode 100644
index f857300f4edd..000000000000
diff --git a/arch/cris/boot/dts/dev88.dts b/arch/cris/boot/dts/dev88.dts
deleted file mode 100644
index 415270ea5309..000000000000
diff --git a/arch/cris/boot/dts/etraxfs.dtsi b/arch/cris/boot/dts/etraxfs.dtsi
deleted file mode 100644
index 4513edf72545..000000000000
diff --git a/arch/cris/boot/dts/p1343.dts b/arch/cris/boot/dts/p1343.dts
deleted file mode 100644
index 6030561d4574..000000000000
diff --git a/arch/cris/boot/rescue/Makefile b/arch/cris/boot/rescue/Makefile
deleted file mode 100644
index f73ac4c83b96..000000000000
diff --git a/arch/cris/boot/rescue/head_v10.S b/arch/cris/boot/rescue/head_v10.S
deleted file mode 100644
index 11eedb1bf31a..000000000000
diff --git a/arch/cris/boot/rescue/head_v32.S b/arch/cris/boot/rescue/head_v32.S
deleted file mode 100644
index 9eb04abaa0c0..000000000000
diff --git a/arch/cris/boot/rescue/kimagerescue.S b/arch/cris/boot/rescue/kimagerescue.S
deleted file mode 100644
index 3306098dee15..000000000000
diff --git a/arch/cris/boot/rescue/rescue_v10.lds b/arch/cris/boot/rescue/rescue_v10.lds
deleted file mode 100644
index e58a53f91728..000000000000
diff --git a/arch/cris/boot/rescue/rescue_v32.lds b/arch/cris/boot/rescue/rescue_v32.lds
deleted file mode 100644
index f1542183f263..000000000000
diff --git a/arch/cris/boot/rescue/testrescue.S b/arch/cris/boot/rescue/testrescue.S
deleted file mode 100644
index 06f78a0b0622..000000000000
diff --git a/arch/cris/boot/tools/build.c b/arch/cris/boot/tools/build.c
deleted file mode 100644
index 3ae485049779..000000000000
diff --git a/arch/cris/configs/artpec_3_defconfig b/arch/cris/configs/artpec_3_defconfig
deleted file mode 100644
index d31851f29db8..000000000000
diff --git a/arch/cris/configs/dev88_defconfig b/arch/cris/configs/dev88_defconfig
deleted file mode 100644
index beff4ee6edb3..000000000000
diff --git a/arch/cris/configs/etrax-100lx_defconfig b/arch/cris/configs/etrax-100lx_defconfig
deleted file mode 100644
index cbbcefeaa8fc..000000000000
diff --git a/arch/cris/configs/etrax-100lx_v2_defconfig b/arch/cris/configs/etrax-100lx_v2_defconfig
deleted file mode 100644
index d90ac95c1e44..000000000000
diff --git a/arch/cris/configs/etraxfs_defconfig b/arch/cris/configs/etraxfs_defconfig
deleted file mode 100644
index f714e9dfef9b..000000000000
diff --git a/arch/cris/include/arch-v10/arch/bitops.h b/arch/cris/include/arch-v10/arch/bitops.h
deleted file mode 100644
index c18f81858899..000000000000
diff --git a/arch/cris/include/arch-v10/arch/bug.h b/arch/cris/include/arch-v10/arch/bug.h
deleted file mode 100644
index 06da9d49152a..000000000000
diff --git a/arch/cris/include/arch-v10/arch/cache.h b/arch/cris/include/arch-v10/arch/cache.h
deleted file mode 100644
index d4049bcab3c5..000000000000
diff --git a/arch/cris/include/arch-v10/arch/checksum.h b/arch/cris/include/arch-v10/arch/checksum.h
deleted file mode 100644
index eb186be4fb32..000000000000
diff --git a/arch/cris/include/arch-v10/arch/delay.h b/arch/cris/include/arch-v10/arch/delay.h
deleted file mode 100644
index a57d2cc0baf7..000000000000
diff --git a/arch/cris/include/arch-v10/arch/dma.h b/arch/cris/include/arch-v10/arch/dma.h
deleted file mode 100644
index ea794a32cf5e..000000000000
diff --git a/arch/cris/include/arch-v10/arch/io.h b/arch/cris/include/arch-v10/arch/io.h
deleted file mode 100644
index bae5f77cfabc..000000000000
diff --git a/arch/cris/include/arch-v10/arch/io_interface_mux.h b/arch/cris/include/arch-v10/arch/io_interface_mux.h
deleted file mode 100644
index 2d5617e67ab0..000000000000
diff --git a/arch/cris/include/arch-v10/arch/irq.h b/arch/cris/include/arch-v10/arch/irq.h
deleted file mode 100644
index c4e8a78e33d1..000000000000
diff --git a/arch/cris/include/arch-v10/arch/irqflags.h b/arch/cris/include/arch-v10/arch/irqflags.h
deleted file mode 100644
index 9959b0a8a58c..000000000000
diff --git a/arch/cris/include/arch-v10/arch/memmap.h b/arch/cris/include/arch-v10/arch/memmap.h
deleted file mode 100644
index b6b171f48b29..000000000000
diff --git a/arch/cris/include/arch-v10/arch/mmu.h b/arch/cris/include/arch-v10/arch/mmu.h
deleted file mode 100644
index 74c53048be79..000000000000
diff --git a/arch/cris/include/arch-v10/arch/offset.h b/arch/cris/include/arch-v10/arch/offset.h
deleted file mode 100644
index 6f0f2b4a163f..000000000000
diff --git a/arch/cris/include/arch-v10/arch/page.h b/arch/cris/include/arch-v10/arch/page.h
deleted file mode 100644
index a4bbff64868c..000000000000
diff --git a/arch/cris/include/arch-v10/arch/pgtable.h b/arch/cris/include/arch-v10/arch/pgtable.h
deleted file mode 100644
index a61532d06acb..000000000000
diff --git a/arch/cris/include/arch-v10/arch/processor.h b/arch/cris/include/arch-v10/arch/processor.h
deleted file mode 100644
index b2df646bc1eb..000000000000
diff --git a/arch/cris/include/arch-v10/arch/swab.h b/arch/cris/include/arch-v10/arch/swab.h
deleted file mode 100644
index 8cc27dfb9d3a..000000000000
diff --git a/arch/cris/include/arch-v10/arch/system.h b/arch/cris/include/arch-v10/arch/system.h
deleted file mode 100644
index 4c63f728122b..000000000000
diff --git a/arch/cris/include/arch-v10/arch/thread_info.h b/arch/cris/include/arch-v10/arch/thread_info.h
deleted file mode 100644
index 0ef1223998c1..000000000000
diff --git a/arch/cris/include/arch-v10/arch/timex.h b/arch/cris/include/arch-v10/arch/timex.h
deleted file mode 100644
index 9c9583e5aed6..000000000000
diff --git a/arch/cris/include/arch-v10/arch/tlb.h b/arch/cris/include/arch-v10/arch/tlb.h
deleted file mode 100644
index 9f039d83f21b..000000000000
diff --git a/arch/cris/include/arch-v10/arch/uaccess.h b/arch/cris/include/arch-v10/arch/uaccess.h
deleted file mode 100644
index 8d033c534f1f..000000000000
diff --git a/arch/cris/include/arch-v10/arch/unistd.h b/arch/cris/include/arch-v10/arch/unistd.h
deleted file mode 100644
index 03cd0b8652f4..000000000000
diff --git a/arch/cris/include/arch-v32/arch/bitops.h b/arch/cris/include/arch-v32/arch/bitops.h
deleted file mode 100644
index 7df94798f063..000000000000
diff --git a/arch/cris/include/arch-v32/arch/bug.h b/arch/cris/include/arch-v32/arch/bug.h
deleted file mode 100644
index 982c6b08fdf1..000000000000
diff --git a/arch/cris/include/arch-v32/arch/cache.h b/arch/cris/include/arch-v32/arch/cache.h
deleted file mode 100644
index f61f3088c45b..000000000000
diff --git a/arch/cris/include/arch-v32/arch/checksum.h b/arch/cris/include/arch-v32/arch/checksum.h
deleted file mode 100644
index fea1341ef244..000000000000
diff --git a/arch/cris/include/arch-v32/arch/cryptocop.h b/arch/cris/include/arch-v32/arch/cryptocop.h
deleted file mode 100644
index f2f8eda1ffb1..000000000000
diff --git a/arch/cris/include/arch-v32/arch/delay.h b/arch/cris/include/arch-v32/arch/delay.h
deleted file mode 100644
index 94307c1fbb1c..000000000000
diff --git a/arch/cris/include/arch-v32/arch/dma.h b/arch/cris/include/arch-v32/arch/dma.h
deleted file mode 100644
index 6f92f4f23f28..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/Makefile b/arch/cris/include/arch-v32/arch/hwregs/Makefile
deleted file mode 100644
index bb5ffa7ff9f4..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/ata_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/ata_defs_asm.h
deleted file mode 100644
index 6886ba3c2d53..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/bif_core_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/bif_core_defs_asm.h
deleted file mode 100644
index 1d75d8c31cc0..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/bif_dma_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/bif_dma_defs_asm.h
deleted file mode 100644
index a07447fa75f8..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/bif_slave_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/bif_slave_defs_asm.h
deleted file mode 100644
index 55697fec603e..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/config_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/config_defs_asm.h
deleted file mode 100644
index 6455b4897bcc..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/cpu_vect.h b/arch/cris/include/arch-v32/arch/hwregs/asm/cpu_vect.h
deleted file mode 100644
index 8370aee8a14a..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/cris_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/cris_defs_asm.h
deleted file mode 100644
index bd048296d2f8..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/cris_supp_reg.h b/arch/cris/include/arch-v32/arch/hwregs/asm/cris_supp_reg.h
deleted file mode 100644
index 429fe0d4ffe4..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/dma_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/dma_defs_asm.h
deleted file mode 100644
index fec451d2a3db..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/eth_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/eth_defs_asm.h
deleted file mode 100644
index 97fe523d4d72..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/gio_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/gio_defs_asm.h
deleted file mode 100644
index 41bc2f83795c..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/intr_vect.h b/arch/cris/include/arch-v32/arch/hwregs/asm/intr_vect.h
deleted file mode 100644
index e371052fa1bc..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/intr_vect_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/intr_vect_defs_asm.h
deleted file mode 100644
index 8d0c788b286b..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/irq_nmi_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/irq_nmi_defs_asm.h
deleted file mode 100644
index f624468346af..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/marb_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/marb_defs_asm.h
deleted file mode 100644
index 6a5ce2141860..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/mmu_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/mmu_defs_asm.h
deleted file mode 100644
index 083174678961..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/mmu_supp_reg.h b/arch/cris/include/arch-v32/arch/hwregs/asm/mmu_supp_reg.h
deleted file mode 100644
index fd66daa79259..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/rt_trace_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/rt_trace_defs_asm.h
deleted file mode 100644
index 72b3d231d80f..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/ser_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/ser_defs_asm.h
deleted file mode 100644
index 944f4c7666b4..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/sser_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/sser_defs_asm.h
deleted file mode 100644
index 607b505100fa..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/strcop_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/strcop_defs_asm.h
deleted file mode 100644
index fab117b00ab6..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/strmux_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/strmux_defs_asm.h
deleted file mode 100644
index 73755fa8a526..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/asm/timer_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/asm/timer_defs_asm.h
deleted file mode 100644
index cc67986d7437..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/ata_defs.h b/arch/cris/include/arch-v32/arch/hwregs/ata_defs.h
deleted file mode 100644
index 2a8adbcf75d8..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/bif_core_defs.h b/arch/cris/include/arch-v32/arch/hwregs/bif_core_defs.h
deleted file mode 100644
index 054841c45466..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/bif_dma_defs.h b/arch/cris/include/arch-v32/arch/hwregs/bif_dma_defs.h
deleted file mode 100644
index 5c4abf5c0167..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/bif_slave_defs.h b/arch/cris/include/arch-v32/arch/hwregs/bif_slave_defs.h
deleted file mode 100644
index 80c740b3c785..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/config_defs.h b/arch/cris/include/arch-v32/arch/hwregs/config_defs.h
deleted file mode 100644
index 1c5da14f27f3..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/cpu_vect.h b/arch/cris/include/arch-v32/arch/hwregs/cpu_vect.h
deleted file mode 100644
index 913f918bba14..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/dma.h b/arch/cris/include/arch-v32/arch/hwregs/dma.h
deleted file mode 100644
index dd24c6da09e0..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/dma_defs.h b/arch/cris/include/arch-v32/arch/hwregs/dma_defs.h
deleted file mode 100644
index a67826f5fe21..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/eth_defs.h b/arch/cris/include/arch-v32/arch/hwregs/eth_defs.h
deleted file mode 100644
index d8021b44e5e6..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/extmem_defs.h b/arch/cris/include/arch-v32/arch/hwregs/extmem_defs.h
deleted file mode 100644
index 5937ed7a5228..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/Makefile b/arch/cris/include/arch-v32/arch/hwregs/iop/Makefile
deleted file mode 100644
index 1b9467ae65c1..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_crc_par_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_crc_par_defs_asm.h
deleted file mode 100644
index 10443d789a66..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_dmc_in_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_dmc_in_defs_asm.h
deleted file mode 100644
index fdee9bbe1fd4..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_dmc_out_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_dmc_out_defs_asm.h
deleted file mode 100644
index a97b741bd36a..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_fifo_in_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_fifo_in_defs_asm.h
deleted file mode 100644
index e2c0990246f2..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_fifo_in_extra_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_fifo_in_extra_defs_asm.h
deleted file mode 100644
index 50837b989c90..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_fifo_out_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_fifo_out_defs_asm.h
deleted file mode 100644
index 9f06dddf33a0..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_fifo_out_extra_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_fifo_out_extra_defs_asm.h
deleted file mode 100644
index e8c488c389e4..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_mpu_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_mpu_defs_asm.h
deleted file mode 100644
index 48869d445e07..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_reg_space_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_reg_space_asm.h
deleted file mode 100644
index 615f869a6de9..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_sap_in_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_sap_in_defs_asm.h
deleted file mode 100644
index fe8c90e015b0..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_sap_out_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_sap_out_defs_asm.h
deleted file mode 100644
index a5e46f0bbf6f..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_scrc_in_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_scrc_in_defs_asm.h
deleted file mode 100644
index 169aaf8d44b2..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_scrc_out_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_scrc_out_defs_asm.h
deleted file mode 100644
index 0e9bca149bc6..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_spu_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_spu_defs_asm.h
deleted file mode 100644
index cf2b64a9d42c..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_sw_cfg_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_sw_cfg_defs_asm.h
deleted file mode 100644
index 4f4c7340d39a..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_sw_cpu_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_sw_cpu_defs_asm.h
deleted file mode 100644
index ef04a57a0680..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_sw_mpu_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_sw_mpu_defs_asm.h
deleted file mode 100644
index 22292069e4fd..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_sw_spu_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_sw_spu_defs_asm.h
deleted file mode 100644
index 82729218621c..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_timer_grp_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_timer_grp_defs_asm.h
deleted file mode 100644
index 4f1cf73d86cd..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_trigger_grp_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_trigger_grp_defs_asm.h
deleted file mode 100644
index 7bc882c62952..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_version_defs_asm.h b/arch/cris/include/arch-v32/arch/hwregs/iop/asm/iop_version_defs_asm.h
deleted file mode 100644
index 2e239957e34a..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_crc_par_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_crc_par_defs.h
deleted file mode 100644
index 8690034d9bec..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_dmc_in_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_dmc_in_defs.h
deleted file mode 100644
index 3dd4e870a3a5..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_dmc_out_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_dmc_out_defs.h
deleted file mode 100644
index 7ed17bc553c3..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_fifo_in_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_fifo_in_defs.h
deleted file mode 100644
index dc14868680e6..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_fifo_in_extra_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_fifo_in_extra_defs.h
deleted file mode 100644
index ee7dc07a7862..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_fifo_out_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_fifo_out_defs.h
deleted file mode 100644
index ee8194fcfa82..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_fifo_out_extra_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_fifo_out_extra_defs.h
deleted file mode 100644
index b9721649f6fd..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_mpu_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_mpu_defs.h
deleted file mode 100644
index 28e1c5903677..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_mpu_macros.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_mpu_macros.h
deleted file mode 100644
index 41f5178a65b8..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_reg_space.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_reg_space.h
deleted file mode 100644
index 95e9ce8c042a..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_sap_in_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_sap_in_defs.h
deleted file mode 100644
index 22a74eafb8b0..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_sap_out_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_sap_out_defs.h
deleted file mode 100644
index 380133910105..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_scrc_in_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_scrc_in_defs.h
deleted file mode 100644
index 65d662046ca9..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_scrc_out_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_scrc_out_defs.h
deleted file mode 100644
index ba39605b9737..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_spu_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_spu_defs.h
deleted file mode 100644
index 7681fdab93fc..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_sw_cfg_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_sw_cfg_defs.h
deleted file mode 100644
index 86e5c9b3e593..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_sw_cpu_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_sw_cpu_defs.h
deleted file mode 100644
index 31055d3fcd76..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_sw_mpu_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_sw_mpu_defs.h
deleted file mode 100644
index 5038c08e8a95..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_sw_spu_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_sw_spu_defs.h
deleted file mode 100644
index aeebd57af7f7..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_timer_grp_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_timer_grp_defs.h
deleted file mode 100644
index b4095422adf6..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_trigger_grp_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_trigger_grp_defs.h
deleted file mode 100644
index aff694506e7f..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/iop/iop_version_defs.h b/arch/cris/include/arch-v32/arch/hwregs/iop/iop_version_defs.h
deleted file mode 100644
index 53a4b8cda969..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/irq_nmi_defs.h b/arch/cris/include/arch-v32/arch/hwregs/irq_nmi_defs.h
deleted file mode 100644
index 63b20dee2fd1..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/marb_bp_defs.h b/arch/cris/include/arch-v32/arch/hwregs/marb_bp_defs.h
deleted file mode 100644
index da29a8a22250..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/marb_defs.h b/arch/cris/include/arch-v32/arch/hwregs/marb_defs.h
deleted file mode 100644
index 2858de48a5e0..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/reg_rdwr.h b/arch/cris/include/arch-v32/arch/hwregs/reg_rdwr.h
deleted file mode 100644
index 8fabdd211507..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/rt_trace_defs.h b/arch/cris/include/arch-v32/arch/hwregs/rt_trace_defs.h
deleted file mode 100644
index ebb6bbc6e778..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/ser_defs.h b/arch/cris/include/arch-v32/arch/hwregs/ser_defs.h
deleted file mode 100644
index 3b04cf9012cf..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/sser_defs.h b/arch/cris/include/arch-v32/arch/hwregs/sser_defs.h
deleted file mode 100644
index 02971f9b6558..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/strcop.h b/arch/cris/include/arch-v32/arch/hwregs/strcop.h
deleted file mode 100644
index 2c522b024ee7..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/strcop_defs.h b/arch/cris/include/arch-v32/arch/hwregs/strcop_defs.h
deleted file mode 100644
index 069b2ed9def5..000000000000
diff --git a/arch/cris/include/arch-v32/arch/hwregs/supp_reg.h b/arch/cris/include/arch-v32/arch/hwregs/supp_reg.h
deleted file mode 100644
index c3fa0c06c558..000000000000
diff --git a/arch/cris/include/arch-v32/arch/intmem.h b/arch/cris/include/arch-v32/arch/intmem.h
deleted file mode 100644
index 2bcb21c9b25f..000000000000
diff --git a/arch/cris/include/arch-v32/arch/irq.h b/arch/cris/include/arch-v32/arch/irq.h
deleted file mode 100644
index 5259084001d4..000000000000
diff --git a/arch/cris/include/arch-v32/arch/irqflags.h b/arch/cris/include/arch-v32/arch/irqflags.h
deleted file mode 100644
index d55bf82de77c..000000000000
diff --git a/arch/cris/include/arch-v32/arch/memmap.h b/arch/cris/include/arch-v32/arch/memmap.h
deleted file mode 100644
index 81985c0a6789..000000000000
diff --git a/arch/cris/include/arch-v32/arch/mmu.h b/arch/cris/include/arch-v32/arch/mmu.h
deleted file mode 100644
index a8eec1312de0..000000000000
diff --git a/arch/cris/include/arch-v32/arch/offset.h b/arch/cris/include/arch-v32/arch/offset.h
deleted file mode 100644
index 10a670443386..000000000000
diff --git a/arch/cris/include/arch-v32/arch/page.h b/arch/cris/include/arch-v32/arch/page.h
deleted file mode 100644
index 7ac04f615193..000000000000
diff --git a/arch/cris/include/arch-v32/arch/pgtable.h b/arch/cris/include/arch-v32/arch/pgtable.h
deleted file mode 100644
index e787b19b700e..000000000000
diff --git a/arch/cris/include/arch-v32/arch/processor.h b/arch/cris/include/arch-v32/arch/processor.h
deleted file mode 100644
index 554088ab5f01..000000000000
diff --git a/arch/cris/include/arch-v32/arch/swab.h b/arch/cris/include/arch-v32/arch/swab.h
deleted file mode 100644
index 280dd7093e4f..000000000000
diff --git a/arch/cris/include/arch-v32/arch/system.h b/arch/cris/include/arch-v32/arch/system.h
deleted file mode 100644
index 84f00e5d4652..000000000000
diff --git a/arch/cris/include/arch-v32/arch/thread_info.h b/arch/cris/include/arch-v32/arch/thread_info.h
deleted file mode 100644
index 8514669e5fab..000000000000
diff --git a/arch/cris/include/arch-v32/arch/timex.h b/arch/cris/include/arch-v32/arch/timex.h
deleted file mode 100644
index 2cd8e704a73b..000000000000
diff --git a/arch/cris/include/arch-v32/arch/tlb.h b/arch/cris/include/arch-v32/arch/tlb.h
deleted file mode 100644
index 50452802738f..000000000000
diff --git a/arch/cris/include/arch-v32/arch/uaccess.h b/arch/cris/include/arch-v32/arch/uaccess.h
deleted file mode 100644
index 214bd26efcd9..000000000000
diff --git a/arch/cris/include/arch-v32/arch/unistd.h b/arch/cris/include/arch-v32/arch/unistd.h
deleted file mode 100644
index 764435b3b28e..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/arbiter.h b/arch/cris/include/arch-v32/mach-a3/mach/arbiter.h
deleted file mode 100644
index 7fafc370def2..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/dma.h b/arch/cris/include/arch-v32/mach-a3/mach/dma.h
deleted file mode 100644
index 92a74eab4395..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/asm/clkgen_defs_asm.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/asm/clkgen_defs_asm.h
deleted file mode 100644
index 3d7f12ec1c54..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/asm/ddr2_defs_asm.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/asm/ddr2_defs_asm.h
deleted file mode 100644
index df79e5a7f02a..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/asm/gio_defs_asm.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/asm/gio_defs_asm.h
deleted file mode 100644
index 04b7ff3f70a2..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/asm/pinmux_defs_asm.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/asm/pinmux_defs_asm.h
deleted file mode 100644
index a73168a8e93a..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/asm/pio_defs_asm.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/asm/pio_defs_asm.h
deleted file mode 100644
index 463bb9e2c38e..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/asm/reg_map_asm.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/asm/reg_map_asm.h
deleted file mode 100644
index e3bf8e0692a6..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/asm/timer_defs_asm.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/asm/timer_defs_asm.h
deleted file mode 100644
index 82da59c382c2..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/clkgen_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/clkgen_defs.h
deleted file mode 100644
index 32d58fed3b03..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/ddr2_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/ddr2_defs.h
deleted file mode 100644
index 84684c335d7d..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/gio_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/gio_defs.h
deleted file mode 100644
index 83ab1f495612..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/intr_vect.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/intr_vect.h
deleted file mode 100644
index 55dab5bd7bd3..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/intr_vect_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/intr_vect_defs.h
deleted file mode 100644
index 71a28d1ed74a..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_reg_space_asm.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_reg_space_asm.h
deleted file mode 100644
index 5e5f4d94aecf..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_sap_in_defs_asm.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_sap_in_defs_asm.h
deleted file mode 100644
index ee0587ec433c..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_sap_out_defs_asm.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_sap_out_defs_asm.h
deleted file mode 100644
index 9bbe0b920c93..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_sw_cfg_defs_asm.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_sw_cfg_defs_asm.h
deleted file mode 100644
index c4b8bc386cb6..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_sw_cpu_defs_asm.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_sw_cpu_defs_asm.h
deleted file mode 100644
index 89f36dc1f96d..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_sw_mpu_defs_asm.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_sw_mpu_defs_asm.h
deleted file mode 100644
index 45e19d79dba9..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_sw_spu_defs_asm.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_sw_spu_defs_asm.h
deleted file mode 100644
index 55afb6e320e4..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_version_defs_asm.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_version_defs_asm.h
deleted file mode 100644
index 79ff8fafd3bf..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/iop_reg_space.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/iop_reg_space.h
deleted file mode 100644
index 23d731f36145..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/iop_sap_in_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/iop_sap_in_defs.h
deleted file mode 100644
index 1d6c09a3230d..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/iop_sap_out_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/iop_sap_out_defs.h
deleted file mode 100644
index 1cbd30efadb7..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/iop_sw_cfg_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/iop_sw_cfg_defs.h
deleted file mode 100644
index 07050b053bb4..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/iop_sw_cpu_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/iop_sw_cpu_defs.h
deleted file mode 100644
index b4acdae4f653..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/iop_sw_mpu_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/iop_sw_mpu_defs.h
deleted file mode 100644
index bc1abb5fb308..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/iop_sw_spu_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/iop_sw_spu_defs.h
deleted file mode 100644
index 82b64360a4d3..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/iop_version_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/iop_version_defs.h
deleted file mode 100644
index d944c6ce5f9b..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/l2cache_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/l2cache_defs.h
deleted file mode 100644
index 5c72116f1067..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/marb_bar_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/marb_bar_defs.h
deleted file mode 100644
index 84f68755a75c..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/marb_foo_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/marb_foo_defs.h
deleted file mode 100644
index 13539bc5d613..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/pinmux_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/pinmux_defs.h
deleted file mode 100644
index d604042a52bf..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/pio_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/pio_defs.h
deleted file mode 100644
index 348e39f419e0..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/reg_map.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/reg_map.h
deleted file mode 100644
index 04ef87d42513..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/strmux_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/strmux_defs.h
deleted file mode 100644
index a19955fa8d94..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/hwregs/timer_defs.h b/arch/cris/include/arch-v32/mach-a3/mach/hwregs/timer_defs.h
deleted file mode 100644
index de849a6362f6..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/memmap.h b/arch/cris/include/arch-v32/mach-a3/mach/memmap.h
deleted file mode 100644
index 7b9a9a5699b2..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/pinmux.h b/arch/cris/include/arch-v32/mach-a3/mach/pinmux.h
deleted file mode 100644
index 35e3fc97d6a3..000000000000
diff --git a/arch/cris/include/arch-v32/mach-a3/mach/startup.inc b/arch/cris/include/arch-v32/mach-a3/mach/startup.inc
deleted file mode 100644
index 2d52bcc96ed5..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/arbiter.h b/arch/cris/include/arch-v32/mach-fs/mach/arbiter.h
deleted file mode 100644
index f9401a3de83c..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/dma.h b/arch/cris/include/arch-v32/mach-fs/mach/dma.h
deleted file mode 100644
index 53a59944a48b..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/asm/bif_core_defs_asm.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/asm/bif_core_defs_asm.h
deleted file mode 100644
index 092cad384b86..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/asm/config_defs_asm.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/asm/config_defs_asm.h
deleted file mode 100644
index 5b38835b42f7..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/asm/gio_defs_asm.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/asm/gio_defs_asm.h
deleted file mode 100644
index 3d2056892832..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/asm/pinmux_defs_asm.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/asm/pinmux_defs_asm.h
deleted file mode 100644
index 99968cfa446a..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/asm/reg_map_asm.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/asm/reg_map_asm.h
deleted file mode 100644
index 412b8748e952..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/asm/timer_defs_asm.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/asm/timer_defs_asm.h
deleted file mode 100644
index 3eb17cfbdc75..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/bif_core_defs.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/bif_core_defs.h
deleted file mode 100644
index a9ffb7edaf91..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/bif_dma_defs.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/bif_dma_defs.h
deleted file mode 100644
index d1fa172f58f4..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/bif_slave_defs.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/bif_slave_defs.h
deleted file mode 100644
index a8d7cc528546..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/config_defs.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/config_defs.h
deleted file mode 100644
index cc8b20d17237..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/gio_defs.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/gio_defs.h
deleted file mode 100644
index da0b1103b66d..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/intr_vect.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/intr_vect.h
deleted file mode 100644
index ea752a2d8ee2..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/intr_vect_defs.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/intr_vect_defs.h
deleted file mode 100644
index 11ebd66585cd..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/marb_bp_defs.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/marb_bp_defs.h
deleted file mode 100644
index fb7e20d77591..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/marb_defs.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/marb_defs.h
deleted file mode 100644
index 872a7942916a..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/pinmux_defs.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/pinmux_defs.h
deleted file mode 100644
index 0a316dc36a6b..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/reg_map.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/reg_map.h
deleted file mode 100644
index 1bfca2666158..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/strmux_defs.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/strmux_defs.h
deleted file mode 100644
index 0ab49edb1c81..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/hwregs/timer_defs.h b/arch/cris/include/arch-v32/mach-fs/mach/hwregs/timer_defs.h
deleted file mode 100644
index 59c70ba9959b..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/memmap.h b/arch/cris/include/arch-v32/mach-fs/mach/memmap.h
deleted file mode 100644
index 94328936cc91..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/pinmux.h b/arch/cris/include/arch-v32/mach-fs/mach/pinmux.h
deleted file mode 100644
index 1d87f1392dc8..000000000000
diff --git a/arch/cris/include/arch-v32/mach-fs/mach/startup.inc b/arch/cris/include/arch-v32/mach-fs/mach/startup.inc
deleted file mode 100644
index 96c3b0fb62c1..000000000000
diff --git a/arch/cris/include/asm/Kbuild b/arch/cris/include/asm/Kbuild
deleted file mode 100644
index 6a547fe8752b..000000000000
diff --git a/arch/cris/include/asm/asm-offsets.h b/arch/cris/include/asm/asm-offsets.h
deleted file mode 100644
index d370ee36a182..000000000000
diff --git a/arch/cris/include/asm/axisflashmap.h b/arch/cris/include/asm/axisflashmap.h
deleted file mode 100644
index 185596c2caab..000000000000
diff --git a/arch/cris/include/asm/bitops.h b/arch/cris/include/asm/bitops.h
deleted file mode 100644
index 78f975ad42d9..000000000000
diff --git a/arch/cris/include/asm/bug.h b/arch/cris/include/asm/bug.h
deleted file mode 100644
index f1fa72a426c2..000000000000
diff --git a/arch/cris/include/asm/bugs.h b/arch/cris/include/asm/bugs.h
deleted file mode 100644
index c5907aac1007..000000000000
diff --git a/arch/cris/include/asm/cache.h b/arch/cris/include/asm/cache.h
deleted file mode 100644
index 8dac0922721c..000000000000
diff --git a/arch/cris/include/asm/cacheflush.h b/arch/cris/include/asm/cacheflush.h
deleted file mode 100644
index 0da1c76a2bbc..000000000000
diff --git a/arch/cris/include/asm/checksum.h b/arch/cris/include/asm/checksum.h
deleted file mode 100644
index 61b6a4f6a002..000000000000
diff --git a/arch/cris/include/asm/delay.h b/arch/cris/include/asm/delay.h
deleted file mode 100644
index 2dfdb13e1a9e..000000000000
diff --git a/arch/cris/include/asm/dma.h b/arch/cris/include/asm/dma.h
deleted file mode 100644
index e1f7d6d9bfc2..000000000000
diff --git a/arch/cris/include/asm/eshlibld.h b/arch/cris/include/asm/eshlibld.h
deleted file mode 100644
index 88940556c2db..000000000000
diff --git a/arch/cris/include/asm/etraxi2c.h b/arch/cris/include/asm/etraxi2c.h
deleted file mode 100644
index 0fa6f03d93e7..000000000000
diff --git a/arch/cris/include/asm/fasttimer.h b/arch/cris/include/asm/fasttimer.h
deleted file mode 100644
index bc109f4a8377..000000000000
diff --git a/arch/cris/include/asm/fb.h b/arch/cris/include/asm/fb.h
deleted file mode 100644
index e10150073c30..000000000000
diff --git a/arch/cris/include/asm/ftrace.h b/arch/cris/include/asm/ftrace.h
deleted file mode 100644
index 40a8c178f10d..000000000000
diff --git a/arch/cris/include/asm/hw_irq.h b/arch/cris/include/asm/hw_irq.h
deleted file mode 100644
index 298066020af2..000000000000
diff --git a/arch/cris/include/asm/io.h b/arch/cris/include/asm/io.h
deleted file mode 100644
index c92712d30f54..000000000000
diff --git a/arch/cris/include/asm/irq.h b/arch/cris/include/asm/irq.h
deleted file mode 100644
index 6a932f7db58e..000000000000
diff --git a/arch/cris/include/asm/irqflags.h b/arch/cris/include/asm/irqflags.h
deleted file mode 100644
index 943ba5ca6d2c..000000000000
diff --git a/arch/cris/include/asm/mmu.h b/arch/cris/include/asm/mmu.h
deleted file mode 100644
index 54da8f64b37a..000000000000
diff --git a/arch/cris/include/asm/mmu_context.h b/arch/cris/include/asm/mmu_context.h
deleted file mode 100644
index 178f3b72e9e3..000000000000
diff --git a/arch/cris/include/asm/page.h b/arch/cris/include/asm/page.h
deleted file mode 100644
index 5b5b3dad7484..000000000000
diff --git a/arch/cris/include/asm/pci.h b/arch/cris/include/asm/pci.h
deleted file mode 100644
index dcfef6407ae6..000000000000
diff --git a/arch/cris/include/asm/pgalloc.h b/arch/cris/include/asm/pgalloc.h
deleted file mode 100644
index d8dc1b834b7d..000000000000
diff --git a/arch/cris/include/asm/pgtable.h b/arch/cris/include/asm/pgtable.h
deleted file mode 100644
index 03fca401e23c..000000000000
diff --git a/arch/cris/include/asm/processor.h b/arch/cris/include/asm/processor.h
deleted file mode 100644
index ee4d8b03d048..000000000000
diff --git a/arch/cris/include/asm/ptrace.h b/arch/cris/include/asm/ptrace.h
deleted file mode 100644
index d69295f1a7c8..000000000000
diff --git a/arch/cris/include/asm/segment.h b/arch/cris/include/asm/segment.h
deleted file mode 100644
index 6ac914b098bf..000000000000
diff --git a/arch/cris/include/asm/serial.h b/arch/cris/include/asm/serial.h
deleted file mode 100644
index f51e0e10faa7..000000000000
diff --git a/arch/cris/include/asm/shmparam.h b/arch/cris/include/asm/shmparam.h
deleted file mode 100644
index 704a7257cb0d..000000000000
diff --git a/arch/cris/include/asm/signal.h b/arch/cris/include/asm/signal.h
deleted file mode 100644
index 64b0943c0b00..000000000000
diff --git a/arch/cris/include/asm/stacktrace.h b/arch/cris/include/asm/stacktrace.h
deleted file mode 100644
index 154f0c90d0fa..000000000000
diff --git a/arch/cris/include/asm/string.h b/arch/cris/include/asm/string.h
deleted file mode 100644
index bae5a0867785..000000000000
diff --git a/arch/cris/include/asm/swab.h b/arch/cris/include/asm/swab.h
deleted file mode 100644
index 5e1d8cf277fb..000000000000
diff --git a/arch/cris/include/asm/switch_to.h b/arch/cris/include/asm/switch_to.h
deleted file mode 100644
index dde4acf6e54d..000000000000
diff --git a/arch/cris/include/asm/termios.h b/arch/cris/include/asm/termios.h
deleted file mode 100644
index 9832bf3221d0..000000000000
diff --git a/arch/cris/include/asm/thread_info.h b/arch/cris/include/asm/thread_info.h
deleted file mode 100644
index 996fef3be1d5..000000000000
diff --git a/arch/cris/include/asm/timex.h b/arch/cris/include/asm/timex.h
deleted file mode 100644
index 3840a556612b..000000000000
diff --git a/arch/cris/include/asm/tlb.h b/arch/cris/include/asm/tlb.h
deleted file mode 100644
index 1f6a8a67cfda..000000000000
diff --git a/arch/cris/include/asm/tlbflush.h b/arch/cris/include/asm/tlbflush.h
deleted file mode 100644
index e7cb964536d0..000000000000
diff --git a/arch/cris/include/asm/uaccess.h b/arch/cris/include/asm/uaccess.h
deleted file mode 100644
index 3b42ab0cae93..000000000000
diff --git a/arch/cris/include/asm/ucontext.h b/arch/cris/include/asm/ucontext.h
deleted file mode 100644
index 22f7e7cf59c8..000000000000
diff --git a/arch/cris/include/asm/unaligned.h b/arch/cris/include/asm/unaligned.h
deleted file mode 100644
index 21772cf600dd..000000000000
diff --git a/arch/cris/include/asm/unistd.h b/arch/cris/include/asm/unistd.h
deleted file mode 100644
index 6a92c0505156..000000000000
diff --git a/arch/cris/include/asm/user.h b/arch/cris/include/asm/user.h
deleted file mode 100644
index a19c39547248..000000000000
diff --git a/arch/cris/include/uapi/arch-v10/arch/sv_addr.agh b/arch/cris/include/uapi/arch-v10/arch/sv_addr.agh
deleted file mode 100644
index 6ac3a7bc9760..000000000000
diff --git a/arch/cris/include/uapi/arch-v10/arch/sv_addr_ag.h b/arch/cris/include/uapi/arch-v10/arch/sv_addr_ag.h
deleted file mode 100644
index 2644bcbe4490..000000000000
diff --git a/arch/cris/include/uapi/arch-v10/arch/svinto.h b/arch/cris/include/uapi/arch-v10/arch/svinto.h
deleted file mode 100644
index 793a4275d26a..000000000000
diff --git a/arch/cris/include/uapi/arch-v10/arch/user.h b/arch/cris/include/uapi/arch-v10/arch/user.h
deleted file mode 100644
index 5b9288527b98..000000000000
diff --git a/arch/cris/include/uapi/arch-v32/arch/cryptocop.h b/arch/cris/include/uapi/arch-v32/arch/cryptocop.h
deleted file mode 100644
index 1072d5bf7d4f..000000000000
diff --git a/arch/cris/include/uapi/arch-v32/arch/user.h b/arch/cris/include/uapi/arch-v32/arch/user.h
deleted file mode 100644
index 3576b540ba78..000000000000
diff --git a/arch/cris/include/uapi/asm/Kbuild b/arch/cris/include/uapi/asm/Kbuild
deleted file mode 100644
index 3470c6e9c7b9..000000000000
diff --git a/arch/cris/include/uapi/asm/byteorder.h b/arch/cris/include/uapi/asm/byteorder.h
deleted file mode 100644
index 6e19891e06ee..000000000000
diff --git a/arch/cris/include/uapi/asm/elf.h b/arch/cris/include/uapi/asm/elf.h
deleted file mode 100644
index ea4cbdafe885..000000000000
diff --git a/arch/cris/include/uapi/asm/elf_v10.h b/arch/cris/include/uapi/asm/elf_v10.h
deleted file mode 100644
index b1515f2684da..000000000000
diff --git a/arch/cris/include/uapi/asm/elf_v32.h b/arch/cris/include/uapi/asm/elf_v32.h
deleted file mode 100644
index cc00ffdb7f9c..000000000000
diff --git a/arch/cris/include/uapi/asm/ethernet.h b/arch/cris/include/uapi/asm/ethernet.h
deleted file mode 100644
index e0c1a6322824..000000000000
diff --git a/arch/cris/include/uapi/asm/etraxgpio.h b/arch/cris/include/uapi/asm/etraxgpio.h
deleted file mode 100644
index 10ab0dd45bfe..000000000000
diff --git a/arch/cris/include/uapi/asm/ioctls.h b/arch/cris/include/uapi/asm/ioctls.h
deleted file mode 100644
index 92d654ce3d84..000000000000
diff --git a/arch/cris/include/uapi/asm/param.h b/arch/cris/include/uapi/asm/param.h
deleted file mode 100644
index ae296115c7c9..000000000000
diff --git a/arch/cris/include/uapi/asm/posix_types.h b/arch/cris/include/uapi/asm/posix_types.h
deleted file mode 100644
index c75d8b0acc99..000000000000
diff --git a/arch/cris/include/uapi/asm/ptrace.h b/arch/cris/include/uapi/asm/ptrace.h
deleted file mode 100644
index 99de59e54613..000000000000
diff --git a/arch/cris/include/uapi/asm/ptrace_v10.h b/arch/cris/include/uapi/asm/ptrace_v10.h
deleted file mode 100644
index 4ffffb7ab102..000000000000
diff --git a/arch/cris/include/uapi/asm/ptrace_v32.h b/arch/cris/include/uapi/asm/ptrace_v32.h
deleted file mode 100644
index a91c4aacb14f..000000000000
diff --git a/arch/cris/include/uapi/asm/rs485.h b/arch/cris/include/uapi/asm/rs485.h
deleted file mode 100644
index 041d31fa33d5..000000000000
diff --git a/arch/cris/include/uapi/asm/setup.h b/arch/cris/include/uapi/asm/setup.h
deleted file mode 100644
index 4854ace9db76..000000000000
diff --git a/arch/cris/include/uapi/asm/sigcontext.h b/arch/cris/include/uapi/asm/sigcontext.h
deleted file mode 100644
index 97565ce3f0b9..000000000000
diff --git a/arch/cris/include/uapi/asm/signal.h b/arch/cris/include/uapi/asm/signal.h
deleted file mode 100644
index e4ab00f00111..000000000000
diff --git a/arch/cris/include/uapi/asm/stat.h b/arch/cris/include/uapi/asm/stat.h
deleted file mode 100644
index cdb74d5862e4..000000000000
diff --git a/arch/cris/include/uapi/asm/swab.h b/arch/cris/include/uapi/asm/swab.h
deleted file mode 100644
index 4adf1e9f0b09..000000000000
diff --git a/arch/cris/include/uapi/asm/sync_serial.h b/arch/cris/include/uapi/asm/sync_serial.h
deleted file mode 100644
index f2d468889ba9..000000000000
diff --git a/arch/cris/include/uapi/asm/termbits.h b/arch/cris/include/uapi/asm/termbits.h
deleted file mode 100644
index 86925dc1fcae..000000000000
diff --git a/arch/cris/include/uapi/asm/termios.h b/arch/cris/include/uapi/asm/termios.h
deleted file mode 100644
index d87800a6d854..000000000000
diff --git a/arch/cris/include/uapi/asm/unistd.h b/arch/cris/include/uapi/asm/unistd.h
deleted file mode 100644
index 7aba513b082d..000000000000
diff --git a/arch/cris/kernel/Makefile b/arch/cris/kernel/Makefile
deleted file mode 100644
index f6bfee6c8c1b..000000000000
diff --git a/arch/cris/kernel/asm-offsets.c b/arch/cris/kernel/asm-offsets.c
deleted file mode 100644
index 0a5129941485..000000000000
diff --git a/arch/cris/kernel/crisksyms.c b/arch/cris/kernel/crisksyms.c
deleted file mode 100644
index 7024f7278c89..000000000000
diff --git a/arch/cris/kernel/irq.c b/arch/cris/kernel/irq.c
deleted file mode 100644
index 726cdf4bf2d8..000000000000
diff --git a/arch/cris/kernel/module.c b/arch/cris/kernel/module.c
deleted file mode 100644
index af04cb6b6dc9..000000000000
diff --git a/arch/cris/kernel/process.c b/arch/cris/kernel/process.c
deleted file mode 100644
index 50e5cf09841d..000000000000
diff --git a/arch/cris/kernel/profile.c b/arch/cris/kernel/profile.c
deleted file mode 100644
index d2f978ad129a..000000000000
diff --git a/arch/cris/kernel/ptrace.c b/arch/cris/kernel/ptrace.c
deleted file mode 100644
index af42789a1544..000000000000
diff --git a/arch/cris/kernel/setup.c b/arch/cris/kernel/setup.c
deleted file mode 100644
index 1b61a7207afb..000000000000
diff --git a/arch/cris/kernel/stacktrace.c b/arch/cris/kernel/stacktrace.c
deleted file mode 100644
index f1cc3aaacd8d..000000000000
diff --git a/arch/cris/kernel/sys_cris.c b/arch/cris/kernel/sys_cris.c
deleted file mode 100644
index ecea13f1d760..000000000000
diff --git a/arch/cris/kernel/time.c b/arch/cris/kernel/time.c
deleted file mode 100644
index 593239274f98..000000000000
diff --git a/arch/cris/kernel/traps.c b/arch/cris/kernel/traps.c
deleted file mode 100644
index d4bc80469218..000000000000
diff --git a/arch/cris/kernel/vmlinux.lds.S b/arch/cris/kernel/vmlinux.lds.S
deleted file mode 100644
index 9b232e0f673e..000000000000
diff --git a/arch/cris/mm/Makefile b/arch/cris/mm/Makefile
deleted file mode 100644
index d3ae08c90b4e..000000000000
diff --git a/arch/cris/mm/fault.c b/arch/cris/mm/fault.c
deleted file mode 100644
index 29cc58038b98..000000000000
diff --git a/arch/cris/mm/init.c b/arch/cris/mm/init.c
deleted file mode 100644
index e41d9c833e1c..000000000000
diff --git a/arch/cris/mm/ioremap.c b/arch/cris/mm/ioremap.c
deleted file mode 100644
index 350bd2a86ade..000000000000
diff --git a/arch/cris/mm/tlb.c b/arch/cris/mm/tlb.c
deleted file mode 100644
index e0dbea62cb81..000000000000
-- 
2.9.0
