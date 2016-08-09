From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: c6x linker issue on linux-next-20160808 + some linker table work
Date: Tue, 9 Aug 2016 01:11:26 -0700
Message-ID: <CAB=NE6Xqah+dnk68v3+de=CrHOxHvAqK7G=UX_hoCAmvA9zo5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35356 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292AbcHIILv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 9 Aug 2016 04:11:51 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>

Mark, Aurelien,

I've run into a linker (ld) issue caused by the linker table work I've
been working on [0]. I looked into this and for the life of me, I
cannot comprehend what the problem is, so was hoping you folks might
be able to chime in.

A snapshot you can use is available here:

https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linux-next.git/log/?h=20160808-linker-table-v4

The commit that causes the issue is "firmware: port built-in section
to linker table":

https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linux-next.git/commit/?h=20160808-linker-table-v4&id=2f4516be8c89b3ca008962798d44b54751e62844

its the first use of linker tables in the kernel, but I can't figure
out why this error comes up, nor how to fix it. Any ideas?

[0] lkml.kernel.org/r/1469222687-1600-1-git-send-email-mcgrof@kernel.org

  Luis
