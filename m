From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: situation with signals
Date: Fri, 24 Sep 2010 15:33:23 +0200
Message-ID: <201009241533.23331.arnd@arndb.de>
References: <20100923221141.GK19804@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64800 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096Ab0IXNd2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Sep 2010 09:33:28 -0400
In-Reply-To: <20100923221141.GK19804@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 24 September 2010, Al Viro wrote:
>         There are several interesting issues in arch/*/*/*signal* (besides
> shoggoths starting to show up when one reads that code) and I'd been crawling
> through that area for the last few weeks.  Here are more or less common
> issues; there are really arch-specific bugs (e.g. roothole on frv that
> used to allow reading kernel memory by setting the right sa_handler), but
> that's a separate story.

I still plan to make a counterpart to the asm-generic headers with an
example architecture that new architectures can copy from. Signal handling
is one of the areas that I have very limited understanding of. Did you
encounter any architecture that basically gets signal handling right and that
can serve as a positive example to others?

arch/tile/kernel/signal.c was the last one that got merged and I tried
to direct the maintainer in the right direction as much as I could, but
there are a lot of things I didn't know about.

	Arnd
