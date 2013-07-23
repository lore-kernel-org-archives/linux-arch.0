Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:57575 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756075Ab3GWJzS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Jul 2013 05:55:18 -0400
Message-ID: <51EE52BE.5080204@zytor.com>
Date: Tue, 23 Jul 2013 02:54:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH, re-send] Always trap on BUG()
References: <201307051738.35930.arnd@arndb.de> <20130715151612.9499c2b2ad40e88d183a4600@linux-foundation.org> <20130715222755.GY24642@n2100.arm.linux.org.uk> <51E47924.9030005@zytor.com> <20130723093628.GC19786@gmail.com>
In-Reply-To: <20130723093628.GC19786@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Chen Gang <gang.chen@asianux.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20130723095406.j2JlnyBqb6MTDbsNaopKTOKIBwogMzVfOHTzoDbR1hY@z>

On 07/23/2013 02:36 AM, Ingo Molnar wrote:
>>
>> Well, there are three alternatives here, right:
>>
>> 1. We can use unreachable(), which means that the compiler can assume it
>> never happens.
> 
> AFAICS this is dangerous as it loses warnings and moves execution into 
> la-la-land without any obvious sign at the C level.
> 

Extremely dangerous.

	-hpa

