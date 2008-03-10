From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: + kvm-provide-kvmh-for-all-architecture-fixes-headers_install.patch added to -mm tree
Date: Mon, 10 Mar 2008 12:08:37 +0000
Message-ID: <10680.1205150917@redhat.com>
References: <200803100913.m2A9DJYM009298@imap1.linux-foundation.org>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200803100913.m2A9DJYM009298-AB4EexQrvXRQetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, borntraeger-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org

akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org wrote:

> diff -puN /dev/null include/asm-frv/kvm.h
> --- /dev/null
> +++ a/include/asm-frv/kvm.h
> @@ -0,0 +1,6 @@
> +#ifndef __LINUX_KVM_FRV_H
> +#define __LINUX_KVM_FRV_H
> +
> +/* cris does not support KVM */

That may be so, but this is an FRV header file, not CRIS.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
