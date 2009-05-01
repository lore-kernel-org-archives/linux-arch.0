From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 17/27] add generic lib/checksum.c
Date: Fri, 1 May 2009 11:35:14 +0200
Message-ID: <200905011135.15137.arnd@arndb.de>
References: <cover.1241105648.git.arnd@arndb.de> <cda5746ab12cf9d6bcb7803a3667c92250a29784.1241105648.git.arnd@arndb.de> <20090501092027.GA29366@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:50824 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbZEAJf0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 05:35:26 -0400
In-Reply-To: <20090501092027.GA29366@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

On Friday 01 May 2009, Russell King wrote:
> Since when has 'memcpy' been valid from user addresses?

It's an artifact from the microblaze code, I found it after
submitting the patches when running sparse over it (yes, I
know I should do these things in a different order).

The s390 version seems to get this right, so I'll use this:

static inline __wsum
csum_partial_copy_from_user(const void __user *src, void *dst,
                                          int len, __wsum sum,
                                          int *err_ptr)
{
	int missing;

	missing = copy_from_user(dst, src, len);
	if (missing) {
		memset(dst + len - missing, 0, missing);
		*err_ptr = -EFAULT;
	}

	return csum_partial(dst, len, sum);
}

On microblaze, the old code was only correct for NOMMU.

Thanks,

	Arnd <><
