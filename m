Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:19941 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932117AbWIJNHM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 Sep 2006 09:07:12 -0400
Subject: Re: [PATCH RFC]: New termios take 2
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1157891081.23085.1.camel@localhost.localdomain>
References: <1157472883.9018.79.camel@localhost.localdomain>
	 <1157885180.2977.133.camel@pmac.infradead.org>
	 <1157886908.22571.11.camel@localhost.localdomain>
	 <1157887240.2977.147.camel@pmac.infradead.org>
	 <1157891081.23085.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 10 Sep 2006 14:06:29 +0100
Message-Id: <1157893589.2977.162.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2006-09-10 at 13:24 +0100, Alan Cox wrote:
> glibc needs them, nobody else does.
> 
> The point I was trying to make is that user space (except glibc) does
> not use them. glibc presents a different struct termios to them already,
> and it always includes c_ispeed/c_ospeed.

That's not the point. The question is what glibc's _implementation_ uses
for doing the ioctls. It has to have _some_ definition of the kernel's
version of the structure.

In fact it seems to have its own 'kernel_termios.h' which is an old copy
of our headers. So in that case, we really can drop <asm/termios.h> from
the export -- as least as far as glibc is concerned. I'm not sure about
other C libraries.

On the other hand, the kind of change you're making is an example of why
we might want glibc to be using a _sanely_ exported copy of our headers
directly, rather than an out-of-date version of its own. But that's a
policy decision I'll leave to you. 

If you want to declare that asm/termios.h isn't to be exported even for
glibc builds then please drop all __KERNEL__ from it and remove it from
include/asm-generic/Kbuild.asm so that it isn't exported.

-- 
dwmw2

