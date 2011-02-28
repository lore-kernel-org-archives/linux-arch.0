From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 17/17] unicore32: replace unicore32-specific iomap functions with generic lib implementation
Date: Mon, 28 Feb 2011 16:20:38 +0100
Message-ID: <201102281620.38376.arnd@arndb.de>
References: <cover.1298821856.git.epip@hera.kernel.org> <80a44ac4ac769b464094511bb66732d0d1e7d6d9.1298821856.git.epip@hera.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52791 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428Ab1B1PUu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2011 10:20:50 -0500
In-Reply-To: <80a44ac4ac769b464094511bb66732d0d1e7d6d9.1298821856.git.epip@hera.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <epip@hera.kernel.org>
Cc: GuanXuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, greg@kroah.com

On Sunday 27 February 2011, Guan Xuetao wrote:
> From: GuanXuetao <gxt@mprc.pku.edu.cn>
> 
> 1. define and enable CONFIG_GENERIC_IOMAP
> 2. define unicore32-specific PCI_IOBASE for asm-generic/io.h
> 3. define HAVE_ARCH_PIO_SIZE and unicore32-specific PIO_* macros
> 4. remove all unicore32-specific iomap functions
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
