From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 0/38] clean-up uapi + asm-generic Kbuild files
Date: Mon, 14 Jul 2014 17:34:59 +0200
Message-ID: <8199537.GiECsdyhzt@wuerfel>
References: <20140714150609.GA28358@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:58366 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900AbaGNPfQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jul 2014 11:35:16 -0400
In-Reply-To: <20140714150609.GA28358@ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Michal Marek <mmarek@suse.cz>, David Howells <dhowells@redhat.com>

On Monday 14 July 2014 17:06:09 Sam Ravnborg wrote:
> 
> What tree is the best for this stuff?
> I would suggest to go via the asm-generic tree that Arnd has.
> But it also touches a lot of architectures so Andrews -mm or
> kbuild#misc could be used.

I rarely have anything to send for the asm-generic tree, usually I
rely on things getting merged the other way round, through whoever
has an interest in changing asm-generic.

	Arnd
