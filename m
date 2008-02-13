Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:46998 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbYBMXBc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2008 18:01:32 -0500
Received: by fg-out-1718.google.com with SMTP id e21so116160fga.17
        for <linux-arch@vger.kernel.org>; Wed, 13 Feb 2008 15:01:29 -0800 (PST)
From: Alessandro Guido <alessandro.guido@gmail.com>
Subject: Re: [PATCH] Use menuconfig for CONFIG_CPU_FREQ
Date: Thu, 14 Feb 2008 00:00:52 +0100
References: <200802132330.23817.alessandro.guido@gmail.com> <20080213225058.GA20358@flint.arm.linux.org.uk>
In-Reply-To: <20080213225058.GA20358@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802140000.52936.alessandro.guido@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk, linux-arch@vger.kernel.org

> Doesn't this cause these CPUFREQ options to appear outside of the CPUFREQ
> menu?
> 

No because they all depend on CPU_FREQ and as far as I understand Kconfig
automagically puts them under the same menu.
