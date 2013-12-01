From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 00/17] xtensa SMP queue update
Date: Sun,  1 Dec 2013 12:04:55 +0400
Message-ID: <1385885097-28972-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:37230 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab3LAIFT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Dec 2013 03:05:19 -0500
Received: by mail-la0-f45.google.com with SMTP id eh20so7667399lab.18
        for <linux-arch@vger.kernel.org>; Sun, 01 Dec 2013 00:05:18 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Hi Chris,

this two patches are v3 update for the SMP series, they replace
"xtensa: move built-in PIC to drivers/irqchip" and "xtensa: add MX irqchip"
patches. You can also find them under xtensa-smp-20131201 tag in my tree.

-- 
1.8.1.4
