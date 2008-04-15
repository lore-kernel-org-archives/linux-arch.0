From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: + kernel-add-common-infrastructure-for-unaligned-access.patch
	added to -mm tree
Date: Tue, 15 Apr 2008 13:14:28 +0100
Message-ID: <1208261668.9212.18.camel@pmac.infradead.org>
References: <200804142214.m3EMET5L029431@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200804142214.m3EMET5L029431-AB4EexQrvXRQetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 2008-04-14 at 15:14 -0700, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org wrote:
> 
> Currently there are five implementations:
> 1) packed_struct.h: C-struct based, from asm-generic/unaligned.h
> 2) le_byteshift.h: Open coded byte-swapping, heavily based on asm-arm
> 3) be_byteshift.h: Open coded byte-swapping, heavily based on asm-arm
> 4) memmove.h: taken from multiple implementations in tree
> 5) access_ok.h: taken from x86 and others, unaligned access is ok.
> 
> All of the new implementations checks for sizes not equal to 1,2,4,8
> and will fail to link.

This seems like overkill to me. Can't we just use the packed struct
version? GCC should then to the right thing for all architectures.

> API additions:
> 
> get_unaligned_{le16|le32|le64|be16|be32|be64}(p) which is meant to replace
> code of the form:
> le16_to_cpu(get_unaligned((__le16 *)p));
> 
> put_unaligned_{le16|le32|le64|be16|be32|be64}(val, pointer) which is meant to
> replace code of the form:
> put_unaligned(cpu_to_le16(val), (__le16 *)p);

And couldn't these be macros rather than relying on a boatload of
infrastructure?

-- 
dwmw2
