From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 23/24] C6X: DSCR - Device State Configuration Registers
Date: Wed, 28 Sep 2011 16:11:27 +0200
Message-ID: <201109281611.27903.arnd@arndb.de>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <1317155405-26235-24-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60551 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab1I1OLa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 10:11:30 -0400
In-Reply-To: <1317155405-26235-24-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday 27 September 2011, Mark Salter wrote:
> 
> All SoCs provide an area of device configuration registers called the DSCR. The
> location of specific registers as well as their use varies considerably from
> implementation to implementation. Rather than having to rely on additional
> SoC-specific DSCR code for each new supported SoC, this code generalize things
> as much as possible using device tree properties. Initialization must take
> place early on (setup_arch time) in case the event timer device needs to be
> enable via the DSCR.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
