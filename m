Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:52069 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756272AbbAFSVy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jan 2015 13:21:54 -0500
Date: Tue, 06 Jan 2015 13:21:52 -0500 (EST)
Message-ID: <20150106.132152.994204445203435419.davem@davemloft.net>
Subject: Re: [PATCH v2 15/40] sparc64/uaccess: fix sparse errors
From: David Miller <davem@davemloft.net>
In-Reply-To: <1420558883-10131-16-git-send-email-mst@redhat.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
	<1420558883-10131-16-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, sam@ravnborg.org, sparclinux@vger.kernel.org
Message-ID: <20150106182152.WCUjU_BTaUp5kUPG5kyk03Fr7mjpwB9SMeN_ESZ7aOg@z>

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 6 Jan 2015 17:44:20 +0200

> virtio wants to read bitwise types from userspace using get_user.  At the
> moment this triggers sparse errors, since the value is passed through an
> integer.
> 
> Fix that up using __force.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>
