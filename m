From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] iomap: make IOPORT/PCI mapping functions conditional
Date: Sat, 2 Jul 2011 21:46:15 +0200
Message-ID: <201107022146.15854.arnd@arndb.de>
References: <1309622006-28343-1-git-send-email-jonas@southpole.se> <1309622006-28343-2-git-send-email-jonas@southpole.se>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55917 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab1GBTqu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 2 Jul 2011 15:46:50 -0400
In-Reply-To: <1309622006-28343-2-git-send-email-jonas@southpole.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Saturday 02 July 2011 17:53:26 Jonas Bonn wrote:
> Use the CONFIG_HAS_IOPORT and CONFIG_PCI options to decide whether or
> not functions for mapping these areas are provided.
> 
> Signed-off-by: Jonas Bonn <jonas@southpole.se>

Good catch!

Acked-by: Arnd Bergmann <arnd@arndb.de>

Did you get a build error without the two options, or did you just have an
idea to save a bit of code size?

	Arnd
