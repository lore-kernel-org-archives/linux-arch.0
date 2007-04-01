Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:63709 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbXDAXMM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Apr 2007 19:12:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: missing syscalls
Date: Mon, 2 Apr 2007 01:12:54 +0200
References: <20070401160123.GA9178@uranus.ravnborg.org> <20070401200947.GB826@parisc-linux.org> <20070401201929.GB10652@uranus.ravnborg.org>
In-Reply-To: <20070401201929.GB10652@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200704020112.54931.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Matthew Wilcox <matthew@wil.cx>, David Miller <davem@davemloft.net>, rmk@arm.linux.org.uk, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sunday 01 April 2007 22:19:29 Sam Ravnborg wrote:
> +#define __NR_getcpu             /* 318 - not relevant */
> +#define __NR_epoll_pwait        /* 319 - not relevant */

This looks like it is potentially harmful, since it breaks
user space code that does things like

int my_getcpy(void)
{
#ifdef __NR_getcpu
	return syscall(__NR_getcpu);
#endif
	return -1;
}

	Arnd <><
