From: Madhavi Manchala <madhavi.linux@gmail.com>
Subject: Support for ARM940T core Samsung S3C2510A MCU under Linux
Date: Fri, 18 Mar 2011 21:24:51 +0530
Message-ID: <AANLkTinSMPPHzmp5e1JrPByXC0XCY-591S=jGATXHR=U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62122 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112Ab1CRPyw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2011 11:54:52 -0400
Received: by vxi39 with SMTP id 39so3659700vxi.19
        for <linux-arch@vger.kernel.org>; Fri, 18 Mar 2011 08:54:51 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

Dear All,

I have one basic question about the architecture files in Linux
kernels. We have a board with Samsung S3C2510A MCU (ARM940T core)
which is a no-mmu based CPU. I heard that "there was not a lot of ARM
no-mmu support at the moment" from Ben Dooks.

So, I started developing the architecture files for my Samsung
S3C2510A MCU (ARM940T core) by looking at the existing S3C2410A
(ARM920 core) architecture files. Is this my porting (developing the
architecture files) correct?

How can I port the Linux on to my board which has a Samsung S3C2510A
MCU (ARM940T core) which is a NO-MMU based CPU?

Thanks for your suggestions / hints / comments.

Thanks and Regards,
Madhavi M.
