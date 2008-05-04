From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 1/1] DEBUGFS: Fixing name for debug fs
Date: Sun, 04 May 2008 10:28:32 +0200
Message-ID: <481D73B0.8020705@monstr.eu>
References: <monstr@seznam.cz> <1209825314-8048-1-git-send-email-monstr@seznam.cz> <c65b09261996cf3500b6faee201e2dd6c152973e.1209825194.git.monstr@monstr.eu> <200805032307.04352.arnd@arndb.de>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:61722 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753109AbYEDIz1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 04:55:27 -0400
In-Reply-To: <200805032307.04352.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: monstr@seznam.cz, paulus@samba.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi Arnd,

This is question up to PowerPC guys not to me.
of_debugfs_root sounds good.

M


>> This change is made because powerpc_debugfs_root is arch
>> specific name.
> ...
>>  
>>  static int powerpc_debugfs_init(void)
>>  {
>> -       powerpc_debugfs_root = debugfs_create_dir("powerpc", NULL);
>> +       debugfs_root = debugfs_create_dir("powerpc", NULL);
>>  
> 
> You left the name as "powerpc", which sort of defeats the purpose of your
> patch. Files in debugfs are by definition not part of the ABI, so it's
> actually possible to change this as well. How about making this "of"
> instead of "powerpc"?
> 
> 	Arnd <><
> 
