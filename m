From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH repost 15/16] sparc/uaccess: fix sparse errors
Date: Thu, 25 Dec 2014 18:39:30 -0500 (EST)
Message-ID: <20141225.183930.2234745020223954872.davem@davemloft.net>
References: <1419499661-8566-1-git-send-email-mst@redhat.com>
	<1419499661-8566-16-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:58712 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbaLYXjd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Dec 2014 18:39:33 -0500
In-Reply-To: <1419499661-8566-16-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, sam@ravnborg.org, dave.kleikamp@oracle.com, sparclinux@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 25 Dec 2014 11:30:22 +0200

> virtio wants to read bitwise types from userspace using get_user.  At the
> moment this triggers sparse errors, since the value is passed through an
> integer.
> 
> Fix that up using __force.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Patches #14 and #15 have identical commit message header lines, you
need to say "sparc32: " or "sparc64: " so that shortlog scanners can
distinguish them.

Thanks.
