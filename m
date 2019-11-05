Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:40998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbfKEAdR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Nov 2019 19:33:17 -0500
Date: Mon, 4 Nov 2019 16:33:06 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 10/10] errno.h: Provide EFSCORRUPTED for everybody
Message-ID: <20191105003306.GA22791@infradead.org>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
 <20191104014510.102356-11-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104014510.102356-11-Valdis.Kletnieks@vt.edu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc: "Darrick J . Wong" <darrick.wong@oracle.com>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-arch@vger.kernel.org
Message-ID: <20191105003306.LgP_PbSQ7qTf13upD8EC9ZsNSQ-kXnmKZt4LwYAld4g@z>

On Sun, Nov 03, 2019 at 08:45:06PM -0500, Valdis Kletnieks wrote:
> There's currently 6 filesystems that have the same #define. Move it
> into errno.h so it's defined in just one place.

And 4 out of 6 also define EFSBADCRC, so please lift that as well.
