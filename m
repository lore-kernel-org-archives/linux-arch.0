Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:64735 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213AbaAUVov (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2014 16:44:51 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 20/73] arm: use subsys_initcall in non-modular pl320 IPC code
Date: Tue, 21 Jan 2014 22:44:21 +0100
Message-ID: <4922482.oeJaTIvZxl@wuerfel>
In-Reply-To: <1390339396-3479-21-git-send-email-paul.gortmaker@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com> <1390339396-3479-21-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
Message-ID: <20140121214421.CeaRL3vV73pRNlFRfUWW6SUeh0hlQofmuMvmO4Ssoo4@z>

On Tuesday 21 January 2014 16:22:23 Paul Gortmaker wrote:
> 
> Note that direct use of __initcall is discouraged, vs. one
> of the priority categorized subgroups.  As __initcall gets
> mapped onto device_initcall, our use of subsys_initcall (which
> seems to make sense for netfilter code) will thus change this
> registration from level 6-device to level 4-subsys (i.e. slightly
> earlier).  However no impact of that small difference is expected.

This doesn't have anything to do with netfilter. The only user
of this driver at the moment is the highbank cpufreq driver, but
that could change.

	Arnd
