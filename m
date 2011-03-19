From: Madhavi Manchala <madhavi.linux@gmail.com>
Subject: Support for ARM940T core Samsung S3C2510A MCU under Linux
Date: Sat, 19 Mar 2011 15:23:28 +0530
Message-ID: <AANLkTi=T=QM_GmYYnd8yXJz37LOKqt+AFWk7EEw-7uaN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34247 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730Ab1CSJx3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 19 Mar 2011 05:53:29 -0400
Received: by vws1 with SMTP id 1so4258317vws.19
        for <linux-arch@vger.kernel.org>; Sat, 19 Mar 2011 02:53:29 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: gregkh@suse.de, arnd@arndb.de, prasadjoshi124@gmail.com

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

Please suggest me. It would be appreciated your help / suggestions.

Thanks and Regards,
Madhavi M.
