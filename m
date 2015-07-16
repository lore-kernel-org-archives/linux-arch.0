From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: {get,put}_user ptr argument evaluate only 1 time
Date: Thu, 16 Jul 2015 16:15:21 +0200
Message-ID: <7373340.5zd1dzTFR1@wuerfel>
References: <1437023722-7432-1-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:62914 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441AbbGPOPj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2015 10:15:39 -0400
In-Reply-To: <1437023722-7432-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 16 July 2015 14:15:22 Yoshinori Sato wrote:
> Current implemantation ptr argument evaluate 2 times.
> It'll be an unexpected result.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Do you want to include this into a pull request of your own?
I'm currently on leave and not planning to merge asm-generic
patches for the next merge window.

	Arnd
