Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j2GInZ71000764
	for <linux-arch@vger.kernel.org>; Wed, 16 Mar 2005 18:49:35 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j2GInW3P000763
	for linux-arch@vger.kernel.org; Wed, 16 Mar 2005 18:49:32 GMT
Date: Wed, 16 Mar 2005 18:49:32 +0000
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Double free of initramfs
Message-ID: <20050316184932.GB16712@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

In all linker scripts we currently have something like this:

  __init_begin = .;
 ...
   . = ALIGN(4096);
  __initramfs_start = .;
  .init.ramfs : { *(.init.ramfs) }
  __initramfs_end = .;
  ...
  __init_end = .;

It seems all 25 linker scripts in the current bk tree are suffering from
this.  Which mean with CONFIG_BLK_DEV_INITRD enabled first free_initrd_mem
may be called to free the initram disk and just a little later
free_initmem will try to free the entire range again, so either the
linker scripts would need fixing or free_initrd_mem has become obsolete.

  Ralf
