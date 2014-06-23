Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:54795 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbaFWNxR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jun 2014 09:53:17 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/22] pci-dma-compat: Add pci_zalloc_consistent helper
Date: Mon, 23 Jun 2014 15:53:12 +0200
Message-ID: <4279380.YmNJ3E7DEi@wuerfel>
In-Reply-To: <2248b3ffe86cd8995a809bf7e2871f38039979c1.1403530604.git.joe@perches.com>
References: <cover.1403530604.git.joe@perches.com> <2248b3ffe86cd8995a809bf7e2871f38039979c1.1403530604.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20140623135312.yC_ySN8MVp4Nl3HJiYeXasNbUBOUJ5DLyjuG1CpSOwc@z>

On Monday 23 June 2014 06:41:29 Joe Perches wrote:
> Add this helper for consistency with pci_zalloc_coherent
> and the ability to remove unnecessary memset(,0,) uses.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 

Shouldn't these drivers just use the normal dma-mapping API now?

	Arnd
