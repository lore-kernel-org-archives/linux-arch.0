From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 17/24] C6X: loadable module support
Date: Wed, 28 Sep 2011 15:54:11 +0200
Message-ID: <201109281554.12001.arnd@arndb.de>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <1317155405-26235-18-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:63979 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab1I1NyO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 09:54:14 -0400
In-Reply-To: <1317155405-26235-18-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday 27 September 2011, Mark Salter wrote:
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
>  arch/c6x/include/asm/module.h |   33 +++++++++++
>  arch/c6x/kernel/c6x_ksyms.c   |   68 +++++++++++++++++++++
>  arch/c6x/kernel/module.c      |  129 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 230 insertions(+), 0 deletions(-)
>  create mode 100644 arch/c6x/include/asm/module.h
>  create mode 100644 arch/c6x/kernel/c6x_ksyms.c
>  create mode 100644 arch/c6x/kernel/module.c

Acked-by: Arnd Bergmann <arnd@arndb.de>

> +
> +#ifdef DEBUG
> +#define DBG(fmt...) pr_debug(fmt)
> +#else
> +#define DBG(fmt...)
> +#endif

Note that this is unnecesary. pr_debug is already conditional.

	Arnd
