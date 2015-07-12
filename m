From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] bug: Fix build error in V4.2-RC1
Date: Sun, 12 Jul 2015 10:56:52 -0500
Message-ID: <55A28E44.8020202@lwfinger.net>
References: <1436713236-26445-1-git-send-email-Larry.Finger@lwfinger.net> <1436716328.2711.77.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34254 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbbGLP44 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 12 Jul 2015 11:56:56 -0400
In-Reply-To: <1436716328.2711.77.camel@perches.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/12/2015 10:52 AM, Joe Perches wrote:
> On Sun, 2015-07-12 at 10:00 -0500, Larry Finger wrote:
>> If CONFIG_BUG is not defined, then macro __WARN is not defined.
> []
>> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> []
>> @@ -137,6 +137,7 @@ extern void warn_slowpath_null(const char *file, const int line);
>
>> +#define __WARN() do {} while (1)
>
> Do you really think WARN should loop forever?

Obviously not. I copied the code in that section for BUG() without thinking.

On to V2 after I get some more feedback.

Thanks,

Larry
