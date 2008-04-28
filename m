From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 01/24] types: create <asm-generic/int-*.h>
Date: Mon, 28 Apr 2008 14:55:37 +0100
Message-ID: <4489.1209390937@redhat.com>
References: <alpine.LNX.1.10.0804252143170.20150@fbirervta.pbzchgretzou.qr> <1209078352-7593-1-git-send-email-hpa@zytor.com> <1209078352-7593-2-git-send-email-hpa@zytor.com> <1209078352-7593-3-git-send-email-hpa@zytor.com> <alpine.LNX.1.10.0804252026040.20150@fbirervta.pbzchgretzou.qr> <alpine.LFD.1.10.0804251133100.2779@woody.linux-foundation.org> <20080425185251.GL14990@parisc-linux.org> <48122CB0.7020003@zytor.com> <20080425192858.GM14990@parisc-linux.org> <48123325.30003@zytor.com>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.1.10.0804252143170.20150-vVwEwcwQeYFPkBl3ERsXe1l1cybopEuJUBSOeVevoDU@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Engelhardt <jengelh-bdq14YP6qtRlEiWPh9xO2Q@public.gmane.org>
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Jan Engelhardt <jengelh-bdq14YP6qtRlEiWPh9xO2Q@public.gmane.org> wrote:

> In the kernel's *printk, we are free to do what we want :)

Subject to -Wformat in gcc, of course...

David
