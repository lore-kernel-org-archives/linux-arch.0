From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 17/27] add generic lib/checksum.c
Date: Fri, 01 May 2009 11:37:08 +0200
Message-ID: <49FAC2C4.9020905@monstr.eu>
References: <cover.1241105648.git.arnd@arndb.de> <cda5746ab12cf9d6bcb7803a3667c92250a29784.1241105648.git.arnd@arndb.de> <20090501092027.GA29366@flint.arm.linux.org.uk> <200905011135.15137.arnd@arndb.de>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:22151 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645AbZEAJhO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 05:37:14 -0400
In-Reply-To: <200905011135.15137.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-arch@vger.kernel.org, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Friday 01 May 2009, Russell King wrote:
>> Since when has 'memcpy' been valid from user addresses?
> 
> It's an artifact from the microblaze code, I found it after
> submitting the patches when running sparse over it (yes, I
> know I should do these things in a different order).
> 
> The s390 version seems to get this right, so I'll use this:
> 
> static inline __wsum
> csum_partial_copy_from_user(const void __user *src, void *dst,
>                                           int len, __wsum sum,
>                                           int *err_ptr)
> {
> 	int missing;
> 
> 	missing = copy_from_user(dst, src, len);
> 	if (missing) {
> 		memset(dst + len - missing, 0, missing);
> 		*err_ptr = -EFAULT;
> 	}
> 
> 	return csum_partial(dst, len, sum);
> }
> 
> On microblaze, the old code was only correct for NOMMU.

Not it wasn't there were address space problem too.

Michal

> 
> Thanks,
> 
> 	Arnd <><


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
