From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 00/11] arch_gettimeoffset and ARM timer rework
Date: Mon, 12 Nov 2012 14:17:58 +0000
Message-ID: <201211121417.58380.arnd@arndb.de>
References: <1352408516-21988-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50437 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111Ab2KLOSM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2012 09:18:12 -0500
In-Reply-To: <1352408516-21988-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Russell King <linux@arm.linux.org.uk>, Olof Johansson <olof@lixom.net>, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

On Thursday 08 November 2012, Stephen Warren wrote:
> It would probably be easiest to merge this whole series through the
> arm-soc tree. Anything else would require some co-ordination.

Fine with me. The patches all look good to me, so let's give people a
little more time to weigh in with Acks and possible objections.

In particular, I hope Russell can comment if he has an opionion on these.

	Arnd
