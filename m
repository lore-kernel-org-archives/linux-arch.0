From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2 06/11] unicore32 core architecture: mm related: generic codes
Date: Sun, 27 Feb 2011 18:12:29 +0100
Message-ID: <201102271812.29526.arnd@arndb.de>
References: <02ed01cbcb48$3e3781a0$baa684e0$@mprc.pku.edu.cn> <201102221618.56779.arnd@arndb.de> <018101cbd639$3c639430$b52abc90$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <018101cbd639$3c639430$b52abc90$@mprc.pku.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 'Greg KH' <greg@kroah.com>
List-Id: linux-arch.vger.kernel.org

On Sunday 27 February 2011, Guan Xuetao wrote:
> From: GuanXuetao <gxt@mprc.pku.edu.cn>
> Date: Sun, 27 Feb 2011 12:46:06 +0800
> Subject: [PATCH] unicore32: replace unicore32-specific iomap functions with generic lib implementation
> 
> 1. define and enable CONFIG_GENERIC_IOMAP
> 2. define unicore32-specific PCI_IOBASE for asm-generic/io.h
> 3. define HAVE_ARCH_PIO_SIZE and unicore32-specific PIO_* macros
> 4. remove all unicore32-specific iomap functions
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

Excellent!

Acked-by: Arnd Bergmann <arnd@arndb.de>
