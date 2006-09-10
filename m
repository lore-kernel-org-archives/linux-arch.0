Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48861 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932084AbWIJKwD
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 Sep 2006 06:52:03 -0400
Subject: Re: [PATCH RFC]: New termios take 2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1157885180.2977.133.camel@pmac.infradead.org>
References: <1157472883.9018.79.camel@localhost.localdomain>
	 <1157885180.2977.133.camel@pmac.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 10 Sep 2006 12:15:08 +0100
Message-Id: <1157886908.22571.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Ar Sul, 2006-09-10 am 11:46 +0100, ysgrifennodd David Woodhouse:
> On Tue, 2006-09-05 at 17:14 +0100, Alan Cox wrote:
> > +
> > +#define TCGETS2                _IOR('T',0x2A, struct termios)
> > +#define TCSETS2                _IOW('T',0x2B, struct termios)
> > +#define TCSETSW2       _IOW('T',0x2C, struct termios)
> > +#define TCSETSF2       _IOW('T',0x2D, struct termios)
> 
> So existing code compiled against this will be using the new 'struct
> termios' but the old TCGETS. Should we rename the existing ioctl to 
> TCGETS_OLD, and have TCGETS be the new one?

Kernel headers are not intended for user space. In this case the struct
termios presented by glibc already differs from the termios presented by
the kernel so the problem doesn't arise at all.

Alan

