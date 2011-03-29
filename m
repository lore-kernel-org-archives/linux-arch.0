From: Madhavi Manchala <madhavi.linux@gmail.com>
Subject: linker errors like ignoring invalid character `#' in expression
Date: Tue, 29 Mar 2011 19:16:55 +0530
Message-ID: <AANLkTim6qKQ78J+L28iCDhretGY+g_6zo3TznAWL=-LC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56435 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257Ab1C2Nqz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2011 09:46:55 -0400
Received: by qyg14 with SMTP id 14so119771qyg.19
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2011 06:46:55 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: OpenWrt User List <openwrt-users@lists.openwrt.org>, OpenWrt Development List <openwrt-devel@lists.openwrt.org>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org

Dear All,

I am seeing the following linker error messages when I try to build
the OpenWRT image for my board.

arm-openwrt-linux-uclibcgnueabi-ld:arch/arm/kernel/vmlinux.lds:284:
ignoring invalid character `#' in expression
arm-openwrt-linux-uclibcgnueabi-ld:arch/arm/kernel/vmlinux.lds:284: syntax error

I googled, but there is no much luck for me. I did not understand why
am I getting this error.

Any suggestions / hints would be appreciated.

Thanks for your help, too.

Thanks and Regards,
Madhavi M.
