Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:51150 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750770AbbGLQBZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 12 Jul 2015 12:01:25 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
	by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 0AEC85DAAA
	for <linux-arch@vger.kernel.org>; Sun, 12 Jul 2015 15:52:12 +0000 (UTC)
Message-ID: <1436716328.2711.77.camel@perches.com>
Subject: Re: [PATCH] bug: Fix build error in V4.2-RC1
From: Joe Perches <joe@perches.com>
Date: Sun, 12 Jul 2015 08:52:08 -0700
In-Reply-To: <1436713236-26445-1-git-send-email-Larry.Finger@lwfinger.net>
References: <1436713236-26445-1-git-send-email-Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20150712155208.dbwZkDADKeMmvsYUI4r3Eca-uLY-AeFhTmVnKsUnZ6s@z>

On Sun, 2015-07-12 at 10:00 -0500, Larry Finger wrote:
> If CONFIG_BUG is not defined, then macro __WARN is not defined.
[]
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
[]
> @@ -137,6 +137,7 @@ extern void warn_slowpath_null(const char *file, const int line);

> +#define __WARN() do {} while (1)

Do you really think WARN should loop forever?


