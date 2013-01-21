Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us02smtp1.synopsys.com ([198.182.60.75]:42375 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab3AUNvS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jan 2013 08:51:18 -0500
Message-ID: <50FD47CA.5050806@synopsys.com>
Date: Mon, 21 Jan 2013 19:21:06 +0530
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 63/76] ARC: Hostlink Pseudo-Driver for Metaware Debugger
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-64-git-send-email-vgupta@synopsys.com> <201301181458.26891.arnd@arndb.de>
In-Reply-To: <201301181458.26891.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130121135106.G9J-4Wwuj-huuQoFrhOkM5-QYFfh_m2yuWZi9QSb3AE@z>

On Friday 18 January 2013 08:28 PM, Arnd Bergmann wrote:
> On Friday 18 January 2013, Vineet Gupta wrote:
>> +static int arc_hl_nr_devs = 1;
> This seems to be read-only and hardcoded to 1. If this is true, you could
> simplify the driver significantly by just using misc_register, rather
> than registering your own major device number.
>
> 	Arnd

:-) Indeed virtually there's nothing left in there after misc_register

Thx,
-Vineet
