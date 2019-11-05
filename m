Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46074 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387880AbfKENiQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Nov 2019 08:38:16 -0500
Date: Tue, 5 Nov 2019 08:37:46 -0500
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/1] errno.h: Provide EFSBADCRC for everybody
Message-ID: <20191105133746.GJ28764@mit.edu>
References: <20191105024618.194134-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105024618.194134-1-Valdis.Kletnieks@vt.edu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-arch@vger.kernel.org
Message-ID: <20191105133746.iytEqzBUlcvvWtq6Q3YvRqMlczsPd5YLl7xTWP_Xiu8@z>

On Mon, Nov 04, 2019 at 09:46:14PM -0500, Valdis Kletnieks wrote:
> Four filesystems have their own defines for this. Move it
> into errno.h so it's defined in just one place.
> 
> Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>

Acked-by: Theodore Ts'o <tytso@mit.edu>

					- Ted
