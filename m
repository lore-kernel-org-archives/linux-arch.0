Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:30922 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796AbaGQToH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jul 2014 15:44:07 -0400
Message-ID: <53C82786.2080609@tilera.com>
Date: Thu, 17 Jul 2014 15:44:06 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
Subject: Re: [PATCH 34/38] tile: clean-up uapi Kbuild file
References: <20140714150609.GA28358@ravnborg.org> <1405350546-28467-1-git-send-email-sam@ravnborg.org> <1405350546-28467-34-git-send-email-sam@ravnborg.org>
In-Reply-To: <1405350546-28467-34-git-send-email-sam@ravnborg.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20140717194406.9iMuFQ973G2-hi2DykXd3ou-geaYmf08ds4CLkrEVdc@z>

On 7/14/2014 11:09 AM, Sam Ravnborg wrote:
> Remove redundant assignments.
>
> Signed-off-by: Sam Ravnborg<sam@ravnborg.org>
> Cc: Chris Metcalf<cmetcalf@tilera.com>
> ---
>   arch/tile/include/uapi/asm/Kbuild | 14 +-------------
>   1 file changed, 1 insertion(+), 13 deletions(-)

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com

