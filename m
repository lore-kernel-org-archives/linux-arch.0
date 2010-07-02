From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Break out types from <linux/list.h> to <linux/list_types.h>.
Date: Fri, 2 Jul 2010 22:43:13 +0200
Message-ID: <201007022243.13270.arnd@arndb.de>
References: <201007021811.04197.arnd@arndb.de> <201007021747.o62HlgmV019405@farm-0002.internal.tilera.com> <20100702191910.GA5842@parisc-linux.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59219 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab0GBUnR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jul 2010 16:43:17 -0400
In-Reply-To: <20100702191910.GA5842@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Chris Metcalf <cmetcalf@tilera.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Friday 02 July 2010 21:19:11 Matthew Wilcox wrote:
> Why a new header file instead of linux/types.h?

I think it mostly makes sense because a list_head by itself usually
isn't all that useful, you also want the list_add/list_for_each/...
macros, so you end up including linux/list.h anyway.

linux/list_types.h is really a special case which can get included
by other headers when they have a reason for doing that.

	Arnd
