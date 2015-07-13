Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36764 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbbGML5O (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2015 07:57:14 -0400
Received: by widjy10 with SMTP id jy10so67181852wid.1
        for <linux-arch@vger.kernel.org>; Mon, 13 Jul 2015 04:57:12 -0700 (PDT)
Message-ID: <55A3A796.4050108@plexistor.com>
Date: Mon, 13 Jul 2015 14:57:10 +0300
From: Boaz Harrosh <boaz@plexistor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] fs: dax: do not build on ARC or SH
References: <1436781167-14446-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436781167-14446-1-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Matthew Wilcox <willy@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paul Bolle <pebolle@tiscali.nl>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20150713115710.tjBUuRpTrDT4Pw5wJfglyfPem1_y1rjcggZxEJZhSXU@z>

On 07/13/2015 12:52 PM, Geert Uytterhoeven wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The DAX implementation relies on the architecture to provide a working
> copy_user_page() function, as reported by Michael Ellerman's kisskb
> build bot:
> 
> fs/dax.c: error: implicit declaration of function 'copy_user_page' [-Werror=implicit-function-declaration]:  => 266:2
> 

static int copy_user_bh(struct page *to, struct buffer_head *bh,
			unsigned blkbits, unsigned long vaddr)
{
	void *vfrom, *vto;
	if (dax_get_addr(bh, &vfrom, blkbits) < 0)
		return -EIO;
	vto = kmap_atomic(to);
	copy_user_page(vto, vfrom, vaddr, to);
	kunmap_atomic(vto);
	return 0;
}

I do not understand why we need to call copy_user_page here at all?
the destination is kmap_atomic() so it must be there right? also the
destination is the cow-to page so surly it is not yet mapped to user-space
mapping.

the from is pmem which is just there.
