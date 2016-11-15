From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: Re: [PATCH v05 14/72] include/uapi/asm-generic/ipcbuf.h: include
 linux/posix_types.h
Date: Tue, 15 Nov 2016 21:31:44 +0200
Message-ID: <20161115193144.GH8342@lakka.kapsi.fi>
References: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
 <1471890809-4383-15-git-send-email-mikko.rapeli@iki.fi>
 <11102328.qebiHLmYMG@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11102328.qebiHLmYMG@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
