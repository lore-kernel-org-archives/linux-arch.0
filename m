From: Chris Metcalf <cmetcalf@ezchip.com>
Subject: Re: [PATCH v2 22/40] tile: fix put_user sparse errors
Date: Tue, 13 Jan 2015 08:30:41 -0500
Message-ID: <54B51E01.20509@ezchip.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com> <1420558883-10131-23-git-send-email-mst@redhat.com> <54B44326.6010501@ezchip.com> <20150113093535.GA4434@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db3on0092.outbound.protection.outlook.com ([157.55.234.92]:49010
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751093AbbAMNa4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 Jan 2015 08:30:56 -0500
In-Reply-To: <20150113093535.GA4434@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

On 1/13/2015 4:35 AM, Michael S. Tsirkin wrote:
> I wonder why didn't
> kbuild notify me about new warnings. Doesn't it build tile?

Kbuild builds tilegx, which is an LP64 kernel.  These issues are with the
older platform, tilepro, which is an ILP32 kernel.

There's certainly no reason we couldn't be building that with kbuild
as well, but for whatever reason it just never started up, and I'm
primarily concerned with tilegx anyway, so I haven't pushed.

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com
