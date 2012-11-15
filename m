Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:54469 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768535Ab2KORun (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Nov 2012 12:50:43 -0500
Message-ID: <50A52B45.6030907@imgtec.com>
Date: Thu, 15 Nov 2012 17:49:57 +0000
From: James Hogan <james.hogan@imgtec.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v1 26/31] ARC: Build system: Makefiles, Kconfig, Linker
 script
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <1352281674-2186-27-git-send-email-vgupta@synopsys.com>
In-Reply-To: <1352281674-2186-27-git-send-email-vgupta@synopsys.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, arnd@arndb.de, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Message-ID: <20121115174957.ku-q2OhDk67M7OR5yTiF5MUkK4Fg_rYriQjm727L6tU@z>

Hi Vineet,

On 07/11/12 09:47, Vineet Gupta wrote:
> +config ARC

I just came across arch/mips/Kconfig which also defines ARC (and ARC32).
It's only used within arch/mips/, however it's probably more likely that
your ARC/CONFIG_ARC will find it's way into the generic bits of the
kernel which could get hit when the other ARC is defined.

Perhaps it's worth getting the other ARC renamed just in case?

Cheers
James

