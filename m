From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 6/7] uapi: export all headers under uapi directories
Date: Mon, 23 Jan 2017 07:25:08 -0800
Message-ID: <20170123152508.GA12899@infradead.org>
References: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-7-git-send-email-nicolas.dichtel@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55904 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751397AbdAWPZQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2017 10:25:16 -0500
Content-Disposition: inline
In-Reply-To: <1485183521-13002-7-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au

> .install

> linux/genwqe/.install
> linux/genwqe/..install.cmd

...

If these aren't just a mistake in your list the patches need to be
fixed not to install this build system internal file.

And I'm pretty sure I already pointed this out last time.
