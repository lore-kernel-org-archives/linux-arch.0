From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH repost 12/16] parisc/uaccess: fix sparse errors
Date: Thu, 25 Dec 2014 23:37:45 +0100
Message-ID: <549C91B9.8080009@gmx.de>
References: <1419499661-8566-1-git-send-email-mst@redhat.com> <1419499661-8566-13-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:61474 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbaLYWhu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 Dec 2014 17:37:50 -0500
In-Reply-To: <1419499661-8566-13-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, linux-parisc@vger.kernel.org

Hi Michael,

On 12/25/2014 10:29 AM, Michael S. Tsirkin wrote:
> virtio wants to read bitwise types from userspace using get_user.  At the

I don't know the virtio code much yet, but does it makes sense to read bitwise types?
Will virtio then get possible troubles because of endianess correct as well?

Do you have a code example, or the sparse error message ?

Helge

> moment this triggers sparse errors, since the value is passed through an
> integer.
>
> Fix that up using __force.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   arch/parisc/include/asm/uaccess.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/parisc/include/asm/uaccess.h b/arch/parisc/include/asm/uaccess.h
> index a5cb070..3a20da6 100644
> --- a/arch/parisc/include/asm/uaccess.h
> +++ b/arch/parisc/include/asm/uaccess.h
> @@ -104,7 +104,7 @@ struct exception_data {
>   	    }                                           \
>   	}                                               \
>   							\
> -	(x) = (__typeof__(*(ptr))) __gu_val;            \
> +	(x) = (__force __typeof__(*(ptr))) __gu_val;            \
>   	__gu_err;                                       \
>   })
>
>
