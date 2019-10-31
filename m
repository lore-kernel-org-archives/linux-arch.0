Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43116 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726680AbfJaVXv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2019 17:23:51 -0400
Date: Thu, 31 Oct 2019 17:23:13 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [RFC] errno.h: Provide EFSCORRUPTED for everybody
Message-ID: <20191031212313.GH16197@mit.edu>
References: <20191031010736.113783-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031010736.113783-1-Valdis.Kletnieks@vt.edu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-arch@vger.kernel.org
Message-ID: <20191031212313.3yGVPJpv1aUZjPrk1WVk6Vasz4Cftc5Ea-_dVldiZy8@z>

On Wed, Oct 30, 2019 at 09:07:33PM -0400, Valdis Kletnieks wrote:
> Three questions: (a) ACK/NAK on this patch, (b) should it be all in one
> patch, or one to add to errno.h and 6 patches for 6 filesystems?), and
> (c) if one patch, who gets to shepherd it through?

Acked-by: Theodore Ts'o <tytso@mit.edu>
