From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC v2 2/7] pci: add pci_iomap_range
Date: Tue, 30 Dec 2014 23:10:14 +0100
Message-ID: <10386676.zGp2atn6SR@wuerfel>
References: <1419957310-26009-1-git-send-email-mst@redhat.com> <1419957310-26009-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:64701 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbaL3WKX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 30 Dec 2014 17:10:23 -0500
In-Reply-To: <1419957310-26009-3-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, cornelia.huck@de.ibm.com, linux-arch@vger.kernel.org

On Tuesday 30 December 2014 18:35:36 Michael S. Tsirkin wrote:
> From: Michael S Tsirkin <mst@redhat.com>
> 
> Virtio drivers should map the part of the BAR they need, not necessarily
> all of it.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>
