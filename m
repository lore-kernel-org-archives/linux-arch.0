Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:35412 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbdB0Qha (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2017 11:37:30 -0500
Received: by mail-wr0-f169.google.com with SMTP id g10so56035661wrg.2
        for <linux-arch@vger.kernel.org>; Mon, 27 Feb 2017 08:36:22 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v7 7/8] uapi: export all headers under uapi directories
References: <CAK8P3a3mrqWQnpOjUA8kRO4ksjH7yB6Q5XiHmt1fukJMwD_yUw@mail.gmail.com>
 <1487954956-23318-1-git-send-email-nicolas.dichtel@6wind.com>
 <1487954956-23318-8-git-send-email-nicolas.dichtel@6wind.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <56b1003e-1ac9-9ed3-f204-01e609427b98@6wind.com>
Date: Mon, 27 Feb 2017 17:01:55 +0100
MIME-Version: 1.0
In-Reply-To: <1487954956-23318-8-git-send-email-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, tglx@linutronix.de
Message-ID: <20170227160155.SLpoLk5BA0hAexUoj4HBUurzEwZcj5OBSF2p8CurOu0@z>

Le 24/02/2017 à 17:49, Nicolas Dichtel a écrit :
> Regularly, when a new header is created in include/uapi/, the developer
> forgets to add it in the corresponding Kbuild file. This error is usually
> detected after the release is out.
> 
> In fact, all headers under uapi directories should be exported, thus it's
> useless to have an exhaustive list.
> 
> After this patch, the following files, which were not exported, are now
> exported (with make headers_install_all):
> asm-arc/kvm_para.h
> asm-arc/ucontext.h
> asm-avr32/kvm_para.h
> asm-blackfin/shmparam.h
> asm-blackfin/ucontext.h
> asm-c6x/shmparam.h
> asm-c6x/ucontext.h
> asm-cris/kvm_para.h
> asm-h8300/shmparam.h
> asm-h8300/ucontext.h
> asm-hexagon/shmparam.h
> asm-m32r/kvm_para.h
> asm-m68k/kvm_para.h
> asm-m68k/shmparam.h
> asm-metag/kvm_para.h
> asm-metag/shmparam.h
> asm-metag/ucontext.h
> asm-mips/hwcap.h
> asm-mips/reg.h
> asm-mips/ucontext.h
> asm-nios2/kvm_para.h
> asm-nios2/ucontext.h
> asm-openrisc/shmparam.h
> asm-parisc/kvm_para.h
> asm-powerpc/perf_regs.h
> asm-sh/kvm_para.h
> asm-sh/ucontext.h
> asm-tile/shmparam.h
> asm-unicore32/shmparam.h
> asm-unicore32/ucontext.h
> asm-x86/hwcap2.h
> asm-xtensa/kvm_para.h
> drm/armada_drm.h
> drm/etnaviv_drm.h
> drm/vgem_drm.h
> linux/auto_dev-ioctl.h
> linux/bcache.h
> linux/btrfs_tree.h
> linux/cifs
> linux/cifs/cifs_mount.h
> linux/coresight-stm.h
> linux/cryptouser.h
> linux/genwqe
> linux/genwqe/genwqe_card.h
> linux/hash_info.h
> linux/kcm.h
> linux/kcov.h
> linux/kfd_ioctl.h
> linux/lightnvm.h
> linux/module.h
> linux/nilfs2_api.h
> linux/nilfs2_ondisk.h
> linux/nsfs.h
> linux/pr.h
> linux/qrtr.h
> linux/rpmsg.h
> linux/sed-opal.h
> linux/smc.h
> linux/smc_diag.h
> linux/stm.h
> linux/userio.h
> linux/wil6210_uapi.h
> rdma/bnxt_re-abi.h
> 
> Note that I have removed from this list the files which are generated in every
> exported directories (like .install or .install.cmd).
> 
> Thanks to Julien Floret <julien.floret@6wind.com> for the tip to get all
> subdirs with a pure makefile command.
> 
> For the record, note that exported files for asm directories are a mix of
> files listed by:
>  - include/uapi/asm-generic/Kbuild.asm;
>  - arch/<arch>/include/uapi/asm/Kbuild;
>  - arch/<arch>/include/asm/Kbuild.
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> Acked-by: Mark Salter <msalter@redhat.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Is there any chance to get this series in before the rc1?


Regards,
Nicolas
