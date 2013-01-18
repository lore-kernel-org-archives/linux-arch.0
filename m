From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 10/76] ARC: Fundamental ARCH data-types/defines
Date: Fri, 18 Jan 2013 14:15:24 +0000
Message-ID: <201301181415.25145.arnd@arndb.de>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-11-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57519 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab3AROPe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 09:15:34 -0500
In-Reply-To: <1358511930-7424-11-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jonas Bonn <jonas.bonn@gmail.com>

On Friday 18 January 2013, Vineet Gupta wrote:
> * L1_CACHE_SHIFT
> * PAGE_SIZE, PAGE_OFFSET
> * struct pt_regs, struct user_regs_struct
> * struct thread_struct, cpu_relax(), task_pt_regs(), start_thread(), ...
> * struct thread_info, THREAD_SIZE, INIT_THREAD_INFO(), TIF_*, ...
> * BUG()
> * ELF_*
> * Elf_*
> 
> To disallow user-space visibility into some of the core kernel data-types
> such as struct pt_regs, #ifdef __KERNEL__ which also makes the UAPI header
> spit (further patch in the series) to NOT export it to asm/uapi/ptrace.h
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> Cc: Jonas Bonn <jonas.bonn@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
