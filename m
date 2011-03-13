Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:47235 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374Ab1CMVIS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 13 Mar 2011 17:08:18 -0400
Date: Sun, 13 Mar 2011 21:59:11 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3] introduce sys_syncfs to sync a single file system
Message-ID: <20110313205911.GA4239@lst.de>
References: <Pine.LNX.4.64.1102171035220.13904@cobra.newdream.net> <20110303072223.GA28133@elie> <87bp1sziqn.fsf@linux.vnet.ibm.com> <Pine.LNX.4.64.1103071515070.11152@cobra.newdream.net> <Pine.LNX.4.64.1103101125150.4190@cobra.newdream.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1103101125150.4190@cobra.newdream.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>, Jonathan Nieder <jrnieder@gmail.com>, akpm@linux-foundation.org, linux-api@vger.kernel.org, arnd@arndb.de, mtk.manpages@gmail.com, viro@zeniv.linux.org.uk, hch@lst.de, linux-arch@vger.kernel.org
Message-ID: <20110313205911.bfq50tSQt4_Ys0AsS47UnwDo56aGGxOMvZzUMST1d-g@z>

> +/*
> + * sync a single super
> + */

Not exactly the most descriptive comment.

Otherwise looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

