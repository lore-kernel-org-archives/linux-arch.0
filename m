Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45534 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbfKEUHp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Nov 2019 15:07:45 -0500
Date: Wed, 6 Nov 2019 07:07:38 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/1] errno.h: Provide EFSBADCRC for everybody
Message-ID: <20191105200045.GD4614@dread.disaster.area>
References: <20191105024618.194134-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105024618.194134-1-Valdis.Kletnieks@vt.edu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-arch@vger.kernel.org
Message-ID: <20191105200738.j8s0kSgGPI53_Ko8OKsBdryWkt3TwQKFSLI-RE6eRFE@z>

On Mon, Nov 04, 2019 at 09:46:14PM -0500, Valdis Kletnieks wrote:
> Four filesystems have their own defines for this. Move it
> into errno.h so it's defined in just one place.
> 
> Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>

Looks good, minor nit below:

> diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
> index 1d5ffdf54cb0..e4cae9a9ae79 100644
> --- a/include/uapi/asm-generic/errno.h
> +++ b/include/uapi/asm-generic/errno.h
> @@ -55,6 +55,7 @@
>  #define	EMULTIHOP	72	/* Multihop attempted */
>  #define	EDOTDOT		73	/* RFS specific error */
>  #define	EBADMSG		74	/* Not a data message */
> +#define EFSBADCRC	EBADMSG	/* Bad CRC detected */

Inconsistent whitespace here. When you get tab vs space after
#define wrong it only shows up in patches. :/

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
