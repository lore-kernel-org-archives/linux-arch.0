From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 02/16] h8300: UAPI headers
Date: Wed, 21 Jan 2015 09:46:58 +0100
Message-ID: <1621236.pdeBUC53s3@wuerfel>
References: <cover.1421813622.git.ysato@users.sourceforge.jp> <87wq4gvk0y.wl-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:60073 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbbAUIrE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jan 2015 03:47:04 -0500
In-Reply-To: <87wq4gvk0y.wl-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-arch@vger.kernel.org

On Wednesday 21 January 2015 13:23:57 Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
>  create mode 100644 arch/h8300/include/uapi/asm/Kbuild
>  create mode 100644 arch/h8300/include/uapi/asm/auxvec.h
>  create mode 100644 arch/h8300/include/uapi/asm/byteorder.h
>  create mode 100644 arch/h8300/include/uapi/asm/ptrace.h
>  create mode 100644 arch/h8300/include/uapi/asm/sigcontext.h
>  create mode 100644 arch/h8300/include/uapi/asm/signal.h
>  create mode 100644 arch/h8300/include/uapi/asm/swab.h
>  create mode 100644 arch/h8300/include/uapi/asm/unistd.h

In the introductory mail, you mention that you have a new toolchain.
I assume this implies that all existing user space binaries are
incompatible with new kernels. If so, I would like to ask you
to use the generic ABI where possible. In particular, using
asm-generic/unistd.h to get the default system call table that
is now shared across all new architectures, but 
asm-generic/signal.h also looks like it could be used here
and asm-generic/swab.h might work but depends on performance
considerations.

	Arnd
