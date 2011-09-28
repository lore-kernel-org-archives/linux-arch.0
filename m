From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 07/24] C6X: devicetree support
Date: Wed, 28 Sep 2011 16:57:34 +0200
Message-ID: <201109281657.34471.arnd@arndb.de>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <201109281531.36792.arnd@arndb.de> <1317221051.2580.76.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61953 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325Ab1I1O5k (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 10:57:40 -0400
In-Reply-To: <1317221051.2580.76.camel@deneb.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>

On Wednesday 28 September 2011, Mark Salter wrote:
> > Other architectures allow simply appending the device tree to the
> > kernel image file, which is more convenient for users and does
> > not require much kernel support. Have you tried this?
> 
> Well, I considered it. My main reason for doing it this way was one of
> debugging convenience. The debugger loads an ELF file and while I was
> making lots of device tree changes in the tree and in the code, it was
> more convenient to have one ELF file to deal with rather than an ELF
> file and a dtb. And the thought was to get rid of it altogether once
> bootloader support comes along. Maybe the thing to do would be to just
> rip it out of the kernel. It can almost as easily be post-processing
> step outside the kernel.

Ok, if you plan to properly support it in the boot loader anyway,
that's probably the best option.

	Arnd
