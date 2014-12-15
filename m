From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 03/18] arm64/uaccess: fix sparse errors
Date: Mon, 15 Dec 2014 11:23:11 +0000
Message-ID: <20141215112310.GG11285@n2100.arm.linux.org.uk>
References: <1418575877-21488-1-git-send-email-mst@redhat.com>
 <1418575877-21488-4-git-send-email-mst@redhat.com>
 <20141215111716.GG20738@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:59447 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750782AbaLOLXT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Dec 2014 06:23:19 -0500
Content-Disposition: inline
In-Reply-To: <20141215111716.GG20738@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christopher Covington <cov@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Dec 15, 2014 at 11:17:16AM +0000, Will Deacon wrote:
> On Sun, Dec 14, 2014 at 04:52:09PM +0000, Michael S. Tsirkin wrote:
> > virtio wants to read bitwise types from userspace using get_user.  At the
> > moment this triggers sparse errors, since the value is passed through an
> > integer.
> > 
> > Fix that up using __force.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  arch/arm64/include/asm/uaccess.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > index 3bf8f4e..8d66bcf 100644
> > --- a/arch/arm64/include/asm/uaccess.h
> > +++ b/arch/arm64/include/asm/uaccess.h
> > @@ -147,7 +147,7 @@ do {									\
> >  	default:							\
> >  		BUILD_BUG();						\
> >  	}								\
> > -	(x) = (__typeof__(*(ptr)))__gu_val;				\
> > +	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
> >  } while (0)
> >  
> >  #define __get_user(x, ptr)						\
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

This also means you can do stuff like:

	u32 *p;
	__le32 v;

	err = get_user(p, v);

which is not right.  Both the dereferenced pointer type and the destination
type should be compatible, and if one is a bitwise type but the other isn't,
that seems like a valid case to warn.

I don't see any use of get_user() in drivers/virtio in mainline, so I can't
check further.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
