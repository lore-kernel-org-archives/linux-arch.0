Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62173 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750899AbWIJMB2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 Sep 2006 08:01:28 -0400
Subject: Re: [PATCH RFC]: New termios take 2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1157887240.2977.147.camel@pmac.infradead.org>
References: <1157472883.9018.79.camel@localhost.localdomain>
	 <1157885180.2977.133.camel@pmac.infradead.org>
	 <1157886908.22571.11.camel@localhost.localdomain>
	 <1157887240.2977.147.camel@pmac.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 10 Sep 2006 13:24:41 +0100
Message-Id: <1157891081.23085.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Ar Sul, 2006-09-10 am 12:20 +0100, ysgrifennodd David Woodhouse:
> But I don't think it's realistic to suggest that C libraries should be
> built without access to our asm/term{bit,io}s.h at all. However, I'm
> only really responsible for the new export _mechanism_ -- I'm not going
> to impose policy except when people like Andi do stupid things and
> sneakily send private patches to undo fixes I've already made.

glibc needs them, nobody else does.

The point I was trying to make is that user space (except glibc) does
not use them. glibc presents a different struct termios to them already,
and it always includes c_ispeed/c_ospeed.

Alan

