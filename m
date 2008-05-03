From: monstr@seznam.cz
Subject: FIXING names for debugfs
Date: Sat,  3 May 2008 16:35:13 +0200
Message-ID: <1209825314-8048-1-git-send-email-monstr@seznam.cz>
References: <monstr@seznam.cz>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 178-47-31-89.wifiinternet.cz ([89.31.47.178]:49858 "EHLO
	monstr.eu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755399AbYECOd6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 3 May 2008 10:33:58 -0400
In-Reply-To: <monstr@seznam.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulus@samba.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi All,

this patch fix powerpc specific name to arch independent name.
I did these changes because I would like to use prom.c file
for Microblaze.

Thanks for applying this change,
Michal Simek
