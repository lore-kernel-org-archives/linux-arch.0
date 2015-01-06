Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:52078 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756386AbbAFSWT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jan 2015 13:22:19 -0500
Date: Tue, 06 Jan 2015 13:22:17 -0500 (EST)
Message-ID: <20150106.132217.904272766139229707.davem@davemloft.net>
Subject: Re: [PATCH v2 26/40] arch/sparc: uaccess_64 macro whitespace fixes
From: David Miller <davem@davemloft.net>
In-Reply-To: <1420558883-10131-27-git-send-email-mst@redhat.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
	<1420558883-10131-27-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, sam@ravnborg.org, sparclinux@vger.kernel.org
Message-ID: <20150106182217.UJjfTxTHuAvp6I5-tUwvh33NTBggAXnLFEb6I6Dnnpo@z>

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 6 Jan 2015 17:44:56 +0200

> Macros within arch/sparc/include/asm/uaccess_64.h are made harder to
> read because they violate a bunch of coding style rules.
> 
> Fix it up.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>
