Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53815 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114Ab3CLNFO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Mar 2013 09:05:14 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] asm-generic: move cmpxchg*_local defs to cmpxchg.h
Date: Tue, 12 Mar 2013 13:05:08 +0000
References: <1362030843-25354-1-git-send-email-jonas@southpole.se> <513F2124.6060504@southpole.se>
In-Reply-To: <513F2124.6060504@southpole.se>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201303121305.08691.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Message-ID: <20130312130508.X2TLLDnJTWOUVCAkShJpFurHnbFzCJCoEIWQSumFXhs@z>

On Tuesday 12 March 2013, Jonas Bonn wrote:
> Can you comment on this patch?  This is needed so that the generic 
> asm/cmpxchg.h can be used standalone (i.e. without pulling in atomic.h). 
>   OpenRISC uses the generic asm/cmpxchg.h and things currently don't 
> build without this since linux/llist.h now includes asm/cmpxchg.h 
> standalone.

Looks fine to me, I thought I had replied to this earlier, but I don't
see it in my 'sent-mail' folder now, so I assume I did not.

Please send this as a bug fix through your own tree.

Acked-by: Arnd Bergmann <arnd@arndb.de>
