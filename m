Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:39313 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755639AbYGBWHf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 Jul 2008 18:07:35 -0400
Message-ID: <486BFC21.1040001@firstfloor.org>
Date: Thu, 03 Jul 2008 00:07:29 +0200
From: Andi Kleen <andi@firstfloor.org>
MIME-Version: 1.0
Subject: Re: [PATCH 21/23] make section names compatible with -ffunction-sections
 -fdata-sections: v850
References: <200807020242.21960.vda.linux@googlemail.com>	<200807022345.40184.arnd@arndb.de> <20080702145859.a9af30ea.akpm@linux-foundation.org>
In-Reply-To: <20080702145859.a9af30ea.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, vda.linux@googlemail.com, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, dhowells@redhat.com, ralf@linux-mips.org, kernel@wantstofly.org, jwboyer@linux.vnet.ibm.com, paulus@samba.org, dwmw2@infradead.org, torvalds@linux-foundation.org, paul.gortmaker@windriver.com, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, tim.bird@am.sony.com, schwidefsky@de.ibm.com, davem@davemloft.net
Message-ID: <20080702220729._KBqKBeG-0_bqzG0PyqXbiCyAn5VU4VfPYoEtjXf9ZQ@z>

Andrew Morton wrote:
> On Wed, 2 Jul 2008 23:45:38 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> On Wednesday 02 July 2008, Denys Vlasenko wrote:
>>> This patch fixes v850 architecture.
>> For all I know, v850 has been broken and unmaintained for a few years now,
>> didn't someone have a patch to remove it entirely?
>>
> 
> yup, it's queued for 2.6.27-rc1.

Same seems to be true for cris btw.

-Andi




