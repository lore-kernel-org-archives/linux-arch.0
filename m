From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 4/5] c6x: Use generic asm/mmu.h
Date: Thu, 01 Nov 2012 10:56:35 -0400
Message-ID: <1351781799.22206.94.camel@deneb.redhat.com>
References: <1351765467-29244-1-git-send-email-lars@metafoo.de>
	 <1351765467-29244-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9678 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756812Ab2KAO5B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 Nov 2012 10:57:01 -0400
In-Reply-To: <1351765467-29244-4-git-send-email-lars@metafoo.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Aurelien Jacquiot <a-jacquiot@ti.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org

On Thu, 2012-11-01 at 11:24 +0100, Lars-Peter Clausen wrote:
> c6x's asm/mmu.h is basically identical to asm-generic/mmu.h, so use it
> instead
> of the custom version.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> ---
> Note, due to lack of toolchain, etc this patch is completely untested.
> ---
>  arch/c6x/include/asm/Kbuild |    1 +
>  arch/c6x/include/asm/mmu.h  |   22 ----------------------
>  2 files changed, 1 insertions(+), 22 deletions(-)
>  delete mode 100644 arch/c6x/include/asm/mmu.h

Acked-by: Mark Salter <msalter@redhat.com>
Tested-by: Mark Salter <msalter@redhat.com>
