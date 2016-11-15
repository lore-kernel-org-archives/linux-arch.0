Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:50392 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752513AbcKOTbr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Nov 2016 14:31:47 -0500
Date: Tue, 15 Nov 2016 21:31:44 +0200
From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: Re: [PATCH v05 14/72] include/uapi/asm-generic/ipcbuf.h: include
 linux/posix_types.h
Message-ID: <20161115193144.GH8342@lakka.kapsi.fi>
References: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
 <1471890809-4383-15-git-send-email-mikko.rapeli@iki.fi>
 <11102328.qebiHLmYMG@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11102328.qebiHLmYMG@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20161115193144.Hfkc5137U2-Xq1l9zhCcEydRFtdzhezS-OXxwOTJmvM@z>

On Wed, Aug 24, 2016 at 05:36:22PM +0200, Arnd Bergmann wrote:
> On Monday, August 22, 2016 8:32:31 PM CEST Mikko Rapeli wrote:
> > Fixes userspace compilation error:
> > 
> > error: unknown type name ‘__kernel_key_t’
> > 
> > Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
> > 
> 
> Looks good. I was on Cc for patches 14, 15, 16, 17, 18, 35,
> 65 and 71. They all seem reasonable to me, the only change
> I would do is to remove "include/uapi/" from the subject,
> and instead write it as
> 
> "asm-generic/ipcbuf.h: include linux/posix_types.h"
> 
> With that changed, please add
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks, done.

> if you want to keep the entire series together, or resend
> those patches as a new series to me if you would like me to
> apply them to the asm-generic git tree instead.

I will send a new series after fixing all other review findings and testing
the changes again.

-Mikko
