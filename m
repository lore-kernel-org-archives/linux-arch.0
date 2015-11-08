From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 08/28] lkl: system call interface and application API
Date: Sun, 08 Nov 2015 11:26:22 +0100
Message-ID: <7048391.CAJ2UxAV77@wuerfel>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com> <4119283.3hnNZZdIi2@wuerfel> <CAE1zotJhGqHnj=+SHDv=ButnqpB3j5V7jqYbBDTPpqSuB4jZfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:62617 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbbKHK03 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 8 Nov 2015 05:26:29 -0500
In-Reply-To: <CAE1zotJhGqHnj=+SHDv=ButnqpB3j5V7jqYbBDTPpqSuB4jZfg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Hajime Tazaki <thehajime@gmail.com>

On Sunday 08 November 2015 05:49:00 Octavian Purdila wrote:
> > Could you use the standard numbers from include/uapi/asm-generic/unistd.h?
> > Maybe include that header and then #undef the ones you don't support?
> > That would avoid having to assign a new number of each future syscall
> > that gets added.
> 
> It would be nice to do that but if we undef them warnings will be
> generated during the build (e.g. "warning: #warning syscall pause not
> implemented"). Is there a way to disable those warnings?

Yes:

#define __IGNORE_restart_syscall
#define __IGNORE_exit
...

	Arnd
