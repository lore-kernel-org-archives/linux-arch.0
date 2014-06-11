From: Pranith Kumar <bobby.prani@gmail.com>
Subject: Re: [PATCH 1/1] define generic version of cmpxchg{64} only if not,
 previously defined
Date: Wed, 11 Jun 2014 12:07:55 -0400
Message-ID: <53987EDB.6000803@gmail.com>
References: <5390EAAC.5070601@gatech.edu> <201406111455.16343.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:39894 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738AbaFKQHv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Jun 2014 12:07:51 -0400
In-Reply-To: <201406111455.16343.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Pranith Kumar <pranith@gatech.edu>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/11/2014 08:55 AM, Arnd Bergmann wrote:
> On Friday 06 June 2014, Pranith Kumar wrote:
>>
>> define generic versions of cmpxchg{64} only if not previously defined.
>>
>> This makes these definition in-line to other definitions of generic versions
>>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I assume  you have a patch that depends on this. Please queue up this first
> patch in the same series as the one that needs it.
> 

This is just a clean up patch and there are no other patches depending on this. I will mark them as such from now on :)

--
Pranith
