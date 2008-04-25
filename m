From: Jan Engelhardt <jengelh-bdq14YP6qtRlEiWPh9xO2Q@public.gmane.org>
Subject: Re: [PATCH 01/24] types: create <asm-generic/int-*.h>
Date: Fri, 25 Apr 2008 20:27:53 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0804252026040.20150@fbirervta.pbzchgretzou.qr>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com> <1209078352-7593-2-git-send-email-hpa@zytor.com> <1209078352-7593-3-git-send-email-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1209078352-7593-3-git-send-email-hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


On Friday 2008-04-25 01:05, H. Peter Anvin wrote:

>This creates two generic files with common integer definitions; one
>where 64 bits is "long" (most 64-bit architectures) and one where 64
>bits is "long long" (all 32-bit architectures and x86-64.)

long long is 64 bits on both 32 and 64, is not it?
If so, the split between 32 and 64 should not be necessary.
