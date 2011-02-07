From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Date: Mon, 7 Feb 2011 13:26:23 +0000
Message-ID: <20110207132623.GH10564@opensource.wolfsonmicro.com>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <AANLkTimxpRHW2TPwSnufpoeOHoEtkz1iaR3-VsC1qM4j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34523 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752252Ab1BGN03 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Feb 2011 08:26:29 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimxpRHW2TPwSnufpoeOHoEtkz1iaR3-VsC1qM4j@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-embedded@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Feb 07, 2011 at 01:40:28PM +0100, Geert Uytterhoeven wrote:

> Which means that (for now) I don't have to care that CONFIG_PM becomes
> unclearable. Other people may care, though...

The whole point of the patch is that (other than the IA64 emulator which
explicitly requires that CONFIG_PM be disabled) I strongly suspect that
nobody is actually using this configuration except as a result of
randconfig type testing.
