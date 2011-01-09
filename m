Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58061 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab1AIUco (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2011 15:32:44 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] kbuild: asm-generic support
Date: Sun, 9 Jan 2011 21:31:27 +0100
References: <20110108130302.GA21698@merkur.ravnborg.org> <20110109192707.GA12387@merkur.ravnborg.org> <20110109192907.GA12403@merkur.ravnborg.org>
In-Reply-To: <20110109192907.GA12403@merkur.ravnborg.org>
MIME-Version: 1.0
Message-ID: <201101092131.27694.arnd@arndb.de>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, Guan Xuetao <guanxuetao@mprc.pku.edu.cn>, Michal Marek <mmarek@suse.cz>
Message-ID: <20110109203127.pm2d2EzJnVTs_Is0r47ZxICqBc5CqiiRd9n5hS-PmkM@z>

> There is an increasing amount of header files
> shared between individual architectures in asm-generic.
> To avoid a lot of dummy wrapper files that just
> include the corresponding file in asm-generic provide
> some basic support in kbuild for this.

Looks almost perfect to me now.

I was about to reply with Reviewed-by, but then it occurred to me
that scripts/asm-generic.sh is really much more complicated
than doing the same in Makefile syntax.

You already create the wrapper files during headers-install, so why
not also create them from make, where we already have access to the
file lists in a convenient format.

Or is there a problem getting at stuff defined in the Kbuild files
from the prepare stage?

	Arnd
