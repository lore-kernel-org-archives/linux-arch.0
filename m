From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/22] pci-dma-compat: Add pci_zalloc_consistent helper
Date: Mon, 23 Jun 2014 15:53:12 +0200
Message-ID: <4279380.YmNJ3E7DEi@wuerfel>
References: <cover.1403530604.git.joe@perches.com> <2248b3ffe86cd8995a809bf7e2871f38039979c1.1403530604.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2248b3ffe86cd8995a809bf7e2871f38039979c1.1403530604.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Monday 23 June 2014 06:41:29 Joe Perches wrote:
> Add this helper for consistency with pci_zalloc_coherent
> and the ability to remove unnecessary memset(,0,) uses.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 

Shouldn't these drivers just use the normal dma-mapping API now?

	Arnd
