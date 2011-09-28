From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 09/24] C6X: process management
Date: Wed, 28 Sep 2011 15:47:23 +0200
Message-ID: <201109281547.23430.arnd@arndb.de>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <1317155405-26235-10-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60275 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287Ab1I1Nrb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 09:47:31 -0400
In-Reply-To: <1317155405-26235-10-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday 27 September 2011, Mark Salter wrote:
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
>  arch/c6x/include/asm/processor.h   |  132 ++++++++++++++++++
>  arch/c6x/include/asm/thread_info.h |  121 +++++++++++++++++
>  arch/c6x/kernel/process.c          |  263 ++++++++++++++++++++++++++++++++++++
>  arch/c6x/kernel/switch_to.S        |   74 ++++++++++
>  4 files changed, 590 insertions(+), 0 deletions(-)
>  create mode 100644 arch/c6x/include/asm/processor.h
>  create mode 100644 arch/c6x/include/asm/thread_info.h
>  create mode 100644 arch/c6x/kernel/process.c
>  create mode 100644 arch/c6x/kernel/switch_to.S

Acked-by: Arnd Bergmann <arnd@arndb.de>
