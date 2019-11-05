Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:6150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729711AbfKEDn3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Nov 2019 22:43:29 -0500
Subject: Re: [PATCH 10/10] errno.h: Provide EFSCORRUPTED for everybody
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
 <20191104014510.102356-11-Valdis.Kletnieks@vt.edu>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <5c441427-7e65-fcae-3518-eb37cea5f875@huawei.com>
Date: Tue, 5 Nov 2019 11:43:18 +0800
MIME-Version: 1.0
In-Reply-To: <20191104014510.102356-11-Valdis.Kletnieks@vt.edu>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc: "Darrick J . Wong" <darrick.wong@oracle.com>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-arch@vger.kernel.org
Message-ID: <20191105034318.5-IE83waFE_YrysSC36K43i9FLv5LBPCKpCfI14R63Y@z>

On 2019/11/4 9:45, Valdis Kletnieks wrote:
> There's currently 6 filesystems that have the same #define. Move it
> into errno.h so it's defined in just one place.
> 
> Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
> Acked-by: Darrick J. Wong <darrick.wong@oracle.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: Theodore Ts'o <tytso@mit.edu>

>  fs/erofs/internal.h              | 2 --

>  fs/f2fs/f2fs.h                   | 1 -

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,
