From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC Patch v1 52/55] ARC: Support for single cycle Close Coupled Mem (CCM)
Date: Thu, 17 Jan 2013 10:53:57 +0000
Message-ID: <201301171053.58210.arnd@arndb.de>
References: <1352720953-24321-1-git-send-email-vgupta@synopsys.com> <201211121410.02682.arnd@arndb.de> <50F7878C.4020800@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60309 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756200Ab3AQKyD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jan 2013 05:54:03 -0500
In-Reply-To: <50F7878C.4020800@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 17 January 2013, Vineet Gupta wrote:
> Actually in ARC Port these are used in Linker script to layout the kernel
> code/data at the addr where these hardware blocks are wired up. So can't be done
> at runtime.

Ok, makes sense.

	Arnd
