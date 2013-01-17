From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 25/31] ARC: [plat-arcfpga] Hooking up platform to ARC UART
Date: Thu, 17 Jan 2013 10:52:02 +0000
Message-ID: <201301171052.03189.arnd@arndb.de>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <201211071416.08012.arnd@arndb.de> <50F7A862.4050006@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:64299 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412Ab3AQKwH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jan 2013 05:52:07 -0500
In-Reply-To: <50F7A862.4050006@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 17 January 2013, Vineet Gupta wrote:
> So my strategy for v2 series (based off 3.8-rcx) is to introduce devicetree,
> multi-platform-image support (and other key fixes such as syscall restart issues)
> as slap-on patches on top of old code. This is not to avoid any chop-n-dice of
> fixing patches (I've done that in plenty between v1 and v2). Its just that, in
> absence of revision history for ARC port (in upstream later on) - it helps capture
> the evolution of some key features and also for the community it serves as a live
> documentation of bad designs and how they can be fixed.
> 
> Is that a reasonable approach for new port which is non-bisectable anyways ?
> 

Yes, I think that's fine. you should make that clear in the introductory
email though, as well as in the description of any patches that get
changed significantly by a later patch, to make sure people don't comment
on the same things again when you have already fixed them.

	Arnd
