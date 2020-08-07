Return-Path: <SRS0=4CXV=BR=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:57574 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728091AbgHGJin (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Aug 2020 05:38:43 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 3/3] quota: simplify the quotactl compat handling
Date: Fri, 7 Aug 2020 09:38:38 +0000
Message-ID: <f894de9f065f4bf9a451668dfbf35591@AcuMS.aculab.com>
References: <20200731122202.213333-1-hch@lst.de>
 <20200731122202.213333-4-hch@lst.de>
In-Reply-To: <20200731122202.213333-4-hch@lst.de>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Christoph Hellwig' <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>, Jan Kara <jack@suse.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Jan Kara <jack@suse.cz>
Message-ID: <20200807093838.xfI6UuXEEW8sJOtWsQrWYBVL8nc230mv-F8QFd6OvU8@z>

From: Christoph Hellwig
> Sent: 31 July 2020 13:22
> 
> Fold the misaligned u64 workarounds into the main quotactl flow instead
> of implementing a separate compat syscall handler.
> 
...
> +static int compat_copy_fs_quota_stat(struct compat_fs_quota_stat __user *to,
> +		struct fs_quota_stat *from)
> +{
> +	if (put_user(from->qs_version, &to->qs_version) ||
> +	    put_user(from->qs_flags, &to->qs_flags) ||
> +	    put_user(from->qs_pad, &to->qs_pad) ||
> +	    compat_copy_fs_qfilestat(&to->qs_uquota, &from->qs_uquota) ||
> +	    compat_copy_fs_qfilestat(&to->qs_gquota, &from->qs_gquota) ||
> +	    put_user(from->qs_incoredqs, &to->qs_incoredqs) ||
> +	    put_user(from->qs_btimelimit, &to->qs_btimelimit) ||
> +	    put_user(from->qs_itimelimit, &to->qs_itimelimit) ||
> +	    put_user(from->qs_rtbtimelimit, &to->qs_rtbtimelimit) ||
> +	    put_user(from->qs_bwarnlimit, &to->qs_bwarnlimit) ||
> +	    put_user(from->qs_iwarnlimit, &to->qs_iwarnlimit))
> +		return -EFAULT;
> +	return 0;
> +}

That might look better as a 'noinline' function that copied
all the fields into an on-stack struct compat_fs_quota_stat
and then did a single copy_to_user().

(I do 'like' qs_pad - I wonder what the person who added
it was smoking.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
