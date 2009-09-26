From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Subject: Re: [PATCH] kill USE_ELF_CORE_DUMP
Date: Sat, 26 Sep 2009 21:03:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0909262059200.21273@sister.anvils>
References: <20090423183331.GA19899@lst.de> <49F16786.7010401@petalogix.com>
 <20090926195010.GA24592@lst.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mk-filter-1-a-1.mail.uk.tiscali.com ([212.74.100.52]:42935 "EHLO
	mk-filter-1-a-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751982AbZIZUD1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 26 Sep 2009 16:03:27 -0400
In-Reply-To: <20090926195010.GA24592@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Michal Simek <michal.simek@petalogix.com>, linux-arch@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org

On Sat, 26 Sep 2009, Christoph Hellwig wrote:

> Currently all architectures but microblaze unconditionally define
> USE_ELF_CORE_DUMP.  The microblaze ommision seems like an error to
> me, so let's  kill this ifdef and make sure we are the same everywhere.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yes, I came to a similar conclusion when I added get_dump_page():
#ifdef'ed it on CONFIG_ELF_CORE, but couldn't see the point of
USE_ELF_CORE_DUMP. (Though I missed the microblaze omission).

Acked-by: Hugh Dickins <hugh.dickins@tiscali.co.uk>
