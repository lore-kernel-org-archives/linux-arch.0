From: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
Subject: Re: [PATCH 03/24] arm: types: use <asm-generic/int-*.h> for the arm architecture
Date: Fri, 25 Apr 2008 02:14:48 +0200
Message-ID: <20080425001448.GB29618@xi.wantstofly.org>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com> <1209078352-7593-2-git-send-email-hpa@zytor.com> <1209078352-7593-3-git-send-email-hpa@zytor.com> <1209078352-7593-4-git-send-email-hpa@zytor.com> <1209078352-7593-5-git-send-email-hpa@zytor.com> <1209078352-7593-6-git-send-email-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1209078352-7593-6-git-send-email-hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

On Thu, Apr 24, 2008 at 04:05:12PM -0700, H. Peter Anvin wrote:

> This modifies <asm-arm/types.h> to use the <asm-generic/int-*.h>
> generic include files.
> 
> Signed-off-by: H. Peter Anvin <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
> Cc: Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> Cc: Lennert Buytenhek <kernel-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Acked-by: Lennert Buytenhek <kernel-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
