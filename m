From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v05 14/72] include/uapi/asm-generic/ipcbuf.h: include linux/posix_types.h
Date: Wed, 24 Aug 2016 17:36:22 +0200
Message-ID: <11102328.qebiHLmYMG@wuerfel>
References: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi> <1471890809-4383-15-git-send-email-mikko.rapeli@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:62904 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753438AbcHXPg6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2016 11:36:58 -0400
In-Reply-To: <1471890809-4383-15-git-send-email-mikko.rapeli@iki.fi>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Monday, August 22, 2016 8:32:31 PM CEST Mikko Rapeli wrote:
> Fixes userspace compilation error:
> 
> error: unknown type name ‘__kernel_key_t’
> 
> Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
> 

Looks good. I was on Cc for patches 14, 15, 16, 17, 18, 35,
65 and 71. They all seem reasonable to me, the only change
I would do is to remove "include/uapi/" from the subject,
and instead write it as

"asm-generic/ipcbuf.h: include linux/posix_types.h"

With that changed, please add

Acked-by: Arnd Bergmann <arnd@arndb.de>

if you want to keep the entire series together, or resend
those patches as a new series to me if you would like me to
apply them to the asm-generic git tree instead.

	Arnd
