From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 12/24] C6X: syscalls
Date: Tue, 9 Aug 2011 18:47:42 +0200
Message-ID: <201108091847.43004.arnd@arndb.de>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <1312839879-13592-13-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:49306 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890Ab1HIQrp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2011 12:47:45 -0400
In-Reply-To: <1312839879-13592-13-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 08 August 2011, Mark Salter wrote:
> + */
> +#if !defined(_ASM_C6X_UNISTD_H) || defined(__SYSCALL)
> +#define _ASM_C6X_UNISTD_H
> +
> +#define __ARCH_WANT_SYSCALL_DEPRECATED
> +#define __ARCH_WANT_SYSCALL_NO_AT
> +#define __ARCH_WANT_SYSCALL_NO_FLAGS
> +#define __ARCH_WANT_SYSCALL_OFF_T
> +#define __ARCH_WANT_IPC_PARSE_VERSION

NAK.

Sorry, but these symbols are only meant as transitional helpers for
porting your existing libc. We now have a few architectures in mainline
that no longer need them because glibc can do without them.
Please have a look at what tile and openrisc do here.

	Arnd
