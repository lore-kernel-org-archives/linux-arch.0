From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 13/24] C6X: syscalls
Date: Wed, 28 Sep 2011 15:49:52 +0200
Message-ID: <201109281549.52804.arnd@arndb.de>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <1317155405-26235-14-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59178 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913Ab1I1NuA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 09:50:00 -0400
In-Reply-To: <1317155405-26235-14-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday 27 September 2011, Mark Salter wrote:
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
>  arch/c6x/include/asm/syscalls.h |   55 +++++++++++++++++++++++++++++
>  arch/c6x/include/asm/unistd.h   |   26 ++++++++++++++
>  arch/c6x/kernel/sys_c6x.c       |   73 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 154 insertions(+), 0 deletions(-)
>  create mode 100644 arch/c6x/include/asm/syscalls.h
>  create mode 100644 arch/c6x/include/asm/unistd.h
>  create mode 100644 arch/c6x/kernel/sys_c6x.c

Acked-by: Arnd Bergmann <arnd@arndb.de>
