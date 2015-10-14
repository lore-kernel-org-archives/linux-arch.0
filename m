From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [asm-generic:master 1/9] drivers/acpi/osl.c:46:47: fatal error: asm-generic/io-64-nonatomic-lo-hi.h: No such file or directory
Date: Thu, 15 Oct 2015 00:22:09 +0200
Message-ID: <4999622.4rUkrmXVCv@wuerfel>
References: <201510150219.aKvmPaBr%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:52577 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539AbbJNWWS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2015 18:22:18 -0400
In-Reply-To: <201510150219.aKvmPaBr%fengguang.wu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, kbuild-all@01.org, linux-arch@vger.kernel.org

On Thursday 15 October 2015 02:50:22 kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic master
> head:   9fe5cf2f2b493fbd47541d1c073b67680a2f9dfe
> commit: f626fe17485b6dc8f0706edfd5c60206c479553f [1/9] move io-64-nonatomic*.h out of asm-generic
> config: i386-randconfig-s1-201541 (attached as .config)
> reproduce:
>         git checkout f626fe17485b6dc8f0706edfd5c60206c479553f
>         # save the attached .config to linux build tree
>         make ARCH=i386 

Fixed it up in the branch, thanks for the report!

	Arnd
