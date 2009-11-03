From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: Fix typo in asm-generic/unistd.h.
Date: Tue, 3 Nov 2009 09:52:17 +0100
Message-ID: <200911030952.17483.arnd@arndb.de>
References: <OF0014BE26.A8597F3B-ON48257663.0009191F-48257663.000C690A@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:59630 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbZKCIwU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Nov 2009 03:52:20 -0500
In-Reply-To: <OF0014BE26.A8597F3B-ON48257663.0009191F-48257663.000C690A@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, liqin.gnu@gmail.com

On Tuesday 03 November 2009, liqin.chen@sunplusct.com wrote:
> asm-generic headers could run on linux/score platform well,
> we upgradge libc to glibc-2.5 and passed LTP testsuites.
> we will gradually release score-linux toolchain on our website

Ah, good to hear!

Is there any reason to use glibc-2.5 though? The current release
is 2.10.1, and the version you used is over three years old.

Do you have plans to merge your port into eglibc when it's done?

	Arnd <><
