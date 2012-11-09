From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 12/40] metag: Build infrastructure
Date: Fri, 9 Nov 2012 14:46:27 +0000
Message-ID: <201211091446.28068.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-13-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57193 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab2KIOqa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Nov 2012 09:46:30 -0500
In-Reply-To: <1351700061-7203-13-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org

On Wednesday 31 October 2012, James Hogan wrote:
> +
> +define archhelp
> +  echo  '* vmlinux.bin	- Binary kernel image (arch/$(ARCH)/boot/vmlinux.bin)'
> +  @echo '  uImage  	- Alias to bootable U-Boot image'
> +  @echo '  uImage.bin	- Kernel-only image for U-Boot (bin)'
> +  @echo '  uImage.gz	- Kernel-only image for U-Boot (gzip)'
> +  @echo '  uImage.bz2	- Kernel-only image for U-Boot (bzip2)'
> +  @echo '  uImage.lzma	- Kernel-only image for U-Boot (lzma)'
> +  @echo '  uImage.xz	- Kernel-only image for U-Boot (xz)'
> +  @echo '  uImage.lzo	- Kernel-only image for U-Boot (lzo)'
> +endef

The uImage format is causing some trouble on ARM because it requires knowing
the load address at boot time, so we try to move people towards using just
zImage files there. You might want to consider the same.

It's probably not necessary to have both lzma and xz formats since they
are the same algorithm with different headers afaik.

> diff --git a/arch/metag/include/asm/Kbuild b/arch/metag/include/asm/Kbuild
> new file mode 100644
> index 0000000..1678d85
> --- /dev/null
> +++ b/arch/metag/include/asm/Kbuild
> @@ -0,0 +1,59 @@
> +include include/asm-generic/Kbuild.asm
> +
> +header-y += tbx/
> +
> +header-y += hw_breakpoints.h
> +
> +generic-y += auxvec.h
> +generic-y += bitsperlong.h
> +generic-y += bugs.h
> +generic-y += cputime.h
> +generic-y += current.h

The header files will have to change now for the UAPI split, see the discussion
about the same thing for the ARC architecture.

	Arnd
