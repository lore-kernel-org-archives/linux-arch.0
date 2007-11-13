Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate7.de.ibm.com ([195.212.29.156]:19333 "EHLO
	mtagate7.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756109AbXKMPRy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Nov 2007 10:17:54 -0500
Subject: Re: mm snapshot broken-out-2007-11-13-04-14 Build Fails at memory.c
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <4739B81A.3050601@linux.vnet.ibm.com>
References: <200711131215.lADCFfht009739@imap1.linux-foundation.org>
	 <4739B81A.3050601@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Nov 2007 16:17:51 +0100
Message-Id: <1194967071.3767.0.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, linux-arch@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2007-11-13 at 20:13 +0530, Kamalesh Babulal wrote:
> Hi Andrew,
> 
> The kernel build fails, with following build error
> 
> mm/memory.c: In function ‘free_pte_range’:
> mm/memory.c:126: error: implicit declaration of function ‘pmd_pgtable’
> mm/memory.c:126: warning: initialization makes pointer from integer without a cast
> mm/memory.c: In function ‘apply_to_pte_range’:
> mm/memory.c:1389: warning: assignment makes pointer from integer without a cast
> make[1]: *** [mm/memory.o] Error 1
> make: *** [mm] Error 2
> 
> The patch causing this issue is config_highpte-vs-sub-page-page-tables.patch.
> Where the marco is defined #ifndef CONFIG_PPC_64K_PAGES.

Hmm, the default config for ppc compiled. Can you send me the .config
for the failed compile? I'll fix it up.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.


