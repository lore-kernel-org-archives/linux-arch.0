From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH 7/14] m68knommu: use generic ptrace_resume code
Date: Wed, 03 Feb 2010 16:54:57 +1000
Message-ID: <4B691DC1.8040503@snapgear.com>
References: <20100202185755.GA3630@lst.de> <20100202185935.GG3630@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rex.securecomputing.com ([203.24.151.4]:49961 "EHLO
	cyberguard.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751300Ab0BCGzE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2010 01:55:04 -0500
In-Reply-To: <20100202185935.GG3630@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: roland@redhat.com, oleg@redhat.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Christoph Hellwig wrote:
> Use the generic ptrace_resume code for PTRACE_SYSCALL, PTRACE_CONT,
> PTRACE_KILL and PTRACE_SINGLESTEP.  m68knommu already defines the
> nessecary user_enable_single_step and user_disable_single_step functions
> for this.
> 
> Also the TIF_SYSCALL_TRACE thread flag is now cleared on PTRACE_KILL
> which it previously wasn't which is consistent with all architectures
> using the modern ptrace code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Greg Ungerer <gerg@uclinux.org>


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
