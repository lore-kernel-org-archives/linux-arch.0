From: Madhavi Manchala <madhavi.linux@gmail.com>
Subject: MACH_TYPE undeclared error
Date: Tue, 29 Mar 2011 12:01:40 +0530
Message-ID: <AANLkTimSWBx-FTj1WXpOgFXyH6rLSWFNzayLd_yOj7d_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47146 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab1C2Gbl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2011 02:31:41 -0400
Received: by qyk7 with SMTP id 7so1736429qyk.19
        for <linux-arch@vger.kernel.org>; Mon, 28 Mar 2011 23:31:40 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dear All,

I have defined a MACHINE_START macro in my board C file as follows.

MACHINE_START(S3C2510, "S3C2510")
	.init_irq	= s3c2510_init_irq,
	.timer		= &s3c2510_time_init,
MACHINE_END

When I try to compile this C file, I am seeing the following error message.

arch/arm/mach-s3c2510/s3c2510.c:35:1: error: 'MACH_TYPE_S3C2510'
undeclared here (not in a function)

I googled, but there is no luck for me. Please suggest me whether I am
missing any configuration item.

Any hints / suggestions would be appreciated.

Thanks and Regards,
Madhavi M.
