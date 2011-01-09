From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic headers: modify stat.h in include/asm-generic to be applicable to more architectures
Date: Sun, 9 Jan 2011 01:28:25 +0100
Message-ID: <201101090128.25371.arnd@arndb.de>
References: <024501cbaf37$4e479fd0$ead6df70$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <024501cbaf37$4e479fd0$ead6df70$@mprc.pku.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Saturday 08 January 2011, Guan Xuetao wrote:
> From: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
> 
>  This patch modifies stat.h in include/asm-generic to be applicable to more architectures.
>  STAT64_HAS_BROKEN_ST_INO is defined in most architecture's asm/stat.h, and it need 
>  32-bit __st_ino member to be defined in different position of 64-bit st_ino member.
>  STAT64_PAD_BEFORE_ST_SIZE is the pad before st_size member, with default value 8 bytes.
>  STAT64_PAD_BEFORE_ST_BLOCKS is the pad before st_blocks member, with default value
>  4 bytes to align the following member to 64-bit.

I'd prefer not to apply this patch. It makes the generic header
significantly more complex, and I can't see a significant benefit.

The existing architectures would all still have to define the macros
you test and also keep defining stuff like __old_kernel_stat, while
risking to introduce bugs while changing to the common header. We've
done similar tricks in other places, where the differences between
architectures are smaller, but this one doesn't seem worth it
unless we can get to the point where we can define struct stat in
linux/stat.h for everyone and only do the macros for the architectures
that need it.

	Arnd
