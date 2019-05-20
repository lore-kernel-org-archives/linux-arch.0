Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387964AbfETQDI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 May 2019 12:03:08 -0400
Date: Mon, 20 May 2019 18:03:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 5/5] asm-generic: remove ptrace.h
Message-ID: <20190520160304.GE771@redhat.com>
References: <20190520060018.25569-1-hch@lst.de>
 <20190520060018.25569-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520060018.25569-6-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190520160304.eht1Ah_11UWrPPFdXgEkwCye-xtPyDasPKhNDbtcwwM@z>

On 05/20, Christoph Hellwig wrote:
>
> No one is using this header anymore.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  MAINTAINERS                    |  1 -
>  arch/mips/include/asm/ptrace.h |  5 ---
>  include/asm-generic/ptrace.h   | 74 ----------------------------------
>  3 files changed, 80 deletions(-)
>  delete mode 100644 include/asm-generic/ptrace.h

Acked-by: Oleg Nesterov <oleg@redhat.com>
