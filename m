From: monstr@seznam.cz
Subject: Moving OF firware to arch independent folder
Date: Sat,  3 May 2008 16:22:10 +0200
Message-ID: <1209824532-7939-1-git-send-email-monstr@seznam.cz>
References: <monstr@seznam.cz>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 178-47-31-89.wifiinternet.cz ([89.31.47.178]:54358 "EHLO
	monstr.eu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757495AbYECPVs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 3 May 2008 11:21:48 -0400
In-Reply-To: <monstr@seznam.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulus@samba.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi All,

these patches clean some coding style violation and move 
of_device.c and of_platform.c files to drivers/of/ folder.

I would like to use these files for Microblaze.

Thanks for applying,
Michal Simek
