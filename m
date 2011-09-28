Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49742 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429Ab1I1Nwg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 09:52:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 16/24] C6X: cache control
Date: Wed, 28 Sep 2011 15:52:34 +0200
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <1317155405-26235-17-git-send-email-msalter@redhat.com>
In-Reply-To: <1317155405-26235-17-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201109281552.34322.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20110928135234.alIc1ZTdatsmAytNYA1k9MV5ArUB8VGHAPMMZKeAlOE@z>

On Tuesday 27 September 2011, Mark Salter wrote:
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
>  arch/c6x/include/asm/cache.h      |   90 ++++++++
>  arch/c6x/include/asm/cacheflush.h |   65 ++++++
>  arch/c6x/platforms/cache.c        |  445 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 600 insertions(+), 0 deletions(-)
>  create mode 100644 arch/c6x/include/asm/cache.h
>  create mode 100644 arch/c6x/include/asm/cacheflush.h
>  create mode 100644 arch/c6x/platforms/cache.c

Acked-by: Arnd Bergmann <arnd@arndb.de>
