From: Michal Simek <monstr@monstr.eu>
Subject: Re: [patch 08/14] microblaze: invoke oom-killer from page fault
Date: Fri, 23 Apr 2010 08:30:44 +0200
Message-ID: <4BD13E94.5020304@monstr.eu>
References: <20100422160613.723698029@suse.de> <20100422161223.984100935@suse.de> <alpine.DEB.2.00.1004221353360.25350@chino.kir.corp.google.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:57488 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629Ab0DWGa5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2010 02:30:57 -0400
Received: by bwz25 with SMTP id 25so10684961bwz.28
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 23:30:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1004221353360.25350@chino.kir.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: npiggin@suse.de, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, microblaze-uclinux@itee.uq.edu.au

David Rientjes wrote:
> On Fri, 23 Apr 2010, npiggin@suse.de wrote:
> 
>> As explained in commit 1c0fe6e3bd, we want to call the architecture independent
>> oom killer when getting an unexplained OOM from handle_mm_fault, rather than
>> simply killing current.
>>
>> Cc: microblaze-uclinux@itee.uq.edu.au
>> Cc: Michal Simek <monstr@monstr.eu>
>> Cc: linux-arch@vger.kernel.org
>> Signed-off-by: Nick Piggin <npiggin@suse.de>
> 
> Acked-by: David Rientjes <rientjes@google.com>

Applied to microblaze repository.

Thanks,
Michal



-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
