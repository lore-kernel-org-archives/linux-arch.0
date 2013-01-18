Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59550 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab3ARO6c (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 09:58:32 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 63/76] ARC: Hostlink Pseudo-Driver for Metaware Debugger
Date: Fri, 18 Jan 2013 14:58:26 +0000
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-64-git-send-email-vgupta@synopsys.com>
In-Reply-To: <1358511930-7424-64-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201301181458.26891.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130118145826.HeHTcGQfXShRH9_uV2xY-isdqYuXCbokgcTGZ9A6emA@z>

On Friday 18 January 2013, Vineet Gupta wrote:
> +static int arc_hl_nr_devs = 1;

This seems to be read-only and hardcoded to 1. If this is true, you could
simplify the driver significantly by just using misc_register, rather
than registering your own major device number.

	Arnd
