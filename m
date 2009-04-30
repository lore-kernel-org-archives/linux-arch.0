From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/27] asm-generic: add generic versions of common headers
Date: Thu, 30 Apr 2009 19:07:45 +0200
Message-ID: <200904301907.46515.arnd@arndb.de>
References: <265d330107973ffda3b4b8a3c26ec93f31dfdf00.1241105648.git.arnd@arndb.de> <200904301849.45543.arnd@arndb.de> <20090430.095147.208962142.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:62676 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764691AbZD3RIu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 30 Apr 2009 13:08:50 -0400
In-Reply-To: <20090430.095147.208962142.davem@davemloft.net>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, monstr@monstr.eu, remis.developer@googlemail.com, linux-kernel@vger.kernel.org

On Thursday 30 April 2009, David Miller wrote:
> I use "git format-patch" and send the postings by hand.

That's what I tried as well, but at least with --stdout, git-format-patch
preserves the date and author (From) fields of the changesets, which should
go in the body instead, while exporting the separate patches followed
by 'quilt mail --mbox' drops these fields, in addition to occasionally
screwing up the whole mbox format in the process.

I was hoping to find a simple tool to generate the mbox file in the right
format for importing into the mail client, rather then importing every
single file separately.

	Arnd <><
