From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] syscalls: add __NR_kcmp syscall to generic unistd.h
Date: Mon, 24 Sep 2012 20:01:16 +0000
Message-ID: <201209242001.16373.arnd@arndb.de>
References: <1348516024-4992-1-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57671 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757679Ab2IXUBa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2012 16:01:30 -0400
In-Reply-To: <1348516024-4992-1-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Monday 24 September 2012, Mark Salter wrote:
> 
> Commit d97b46a64 added a new syscall (__NR_kcmp) to support checkpoint
> restore. It is currently x86-only, but that restriction will be removed
> in a subsequent patch. Unfortunately, the kernel checksyscalls script
> had a bug which suppressed any warning to other architectures that the
> kcmp syscall was not implemented. A patch to checksyscalls is being
> tested in linux-next and other architectures are seeing warnings about
> kcmp being unimplemented.
> 
> This patch adds __NR_kcmp to <asm-generic/unistd.h> so that kcmp is
> wired in for architectures using the generic syscall list.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

If you have other patches lined up, can you add this one as well?
