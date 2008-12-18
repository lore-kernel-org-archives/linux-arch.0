Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:55631 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbYLRNiE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Dec 2008 08:38:04 -0500
Message-ID: <494A5235.6090502@redhat.com>
Date: Thu, 18 Dec 2008 14:37:57 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/3] Add preadv and pwritev system calls.
References: <1229600542-11585-1-git-send-email-kraxel@redhat.com> <1229600542-11585-3-git-send-email-kraxel@redhat.com> <200812181334.33719.arnd@arndb.de>
In-Reply-To: <200812181334.33719.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, aarcange@redhat.com
Message-ID: <20081218133757.dbtQyGl_vuO-R0X3plX_ay1UiFh__GaOx6T9xlan0yM@z>

  Hi,

> Please remember to add the function prototypes to
> include/linux/syscalls.h.

Done.

>> +asmlinkage ssize_t
>> +compat_sys_preadv(unsigned long fd, const struct compat_iovec __user *vec,
>> +                  unsigned long vlen, u32 pos_high, u32 pos_low)
>> +{.
>> +        loff_t pos = ((loff_t)pos_high << 32) | pos_low;
> 
> This is whitespace damaged, as are the other four functions in the
> same place.

Fixed.

>> +	struct file *file;
>> +	ssize_t ret = -EBADF;
>> +
>> +	if (pos < 0)
>> +		return -EINVAL;
>> +
>> +	file = fget(fd);
>> +	if (!file)
>> +		return -EBADF;
> 
> Any reason for using fget() here, but fget_light() in sys_preadv?

Due to the new syscalls being derived from the readv()/preadv()
versions, which have the same inconsistency.  Dunno why.  I'd suspect
the reason is that the compat syscalls tend to be overlooked when the
code is updated.  Proof: patch #1 in this series ...

I'll switch them all over in a separate followup patch.

>> +	if (!(file->f_mode & FMODE_READ))
>> +		goto out;
>> +
>> +	ret = -EINVAL;
>> +	if (!file->f_op || (!file->f_op->aio_read && !file->f_op->read))
>> +		goto out;
> 
> Maybe this logic could get moved into a compat_readv() function,
> similar to vfs_readv().

Yes, makes sense.

cheers,
  Gerd


