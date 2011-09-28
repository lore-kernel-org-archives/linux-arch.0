From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 15/24] C6X: clocks
Date: Wed, 28 Sep 2011 15:51:37 +0200
Message-ID: <201109281551.37728.arnd@arndb.de>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <1317155405-26235-16-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60028 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132Ab1I1Nvl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 09:51:41 -0400
In-Reply-To: <1317155405-26235-16-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday 27 September 2011, Mark Salter wrote:
> The C6X SoCs contain several PLL controllers each with up to 16 clock outputs
> feeding into the cores or peripheral clock domains. The hardware is very similar
> to arm/mach-davinci clocks. This is still a work in progress which needs to be
> updated once device tree clock binding changes shake out.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>

Yes, this will have to be reworked at some point, but it's ok for now
as long as there is no generic code to help you do this better.

Acked-by: Arnd Bergmann <arnd@arndb.de>
