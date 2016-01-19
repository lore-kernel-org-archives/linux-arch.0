Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:57176 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbcASOJa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2016 09:09:30 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/2] kbuild: Remove stale asm-generic wrappers
Date: Tue, 19 Jan 2016 15:09:14 +0100
Message-ID: <1667268.iM977TQnEK@wuerfel>
In-Reply-To: <1453210670-12596-3-git-send-email-james.hogan@imgtec.com>
References: <1453210670-12596-1-git-send-email-james.hogan@imgtec.com> <1453210670-12596-3-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org
Message-ID: <20160119140914.NFfDey-brSUdSHZ1la7VlBnTRq4364M1mtUEfsX91S8@z>

On Tuesday 19 January 2016 13:37:50 James Hogan wrote:
> When a header file is removed from generic-y (often accompanied by the
> addition of an arch specific header), the generated wrapper file will
> persist, and in some cases may still take precedence over the new arch
> header.
> 
> For example commit f1fe2d21f4e1 ("MIPS: Add definitions for extended
> context") removed ucontext.h from generic-y in arch/mips/include/asm/,
> and added an arch/mips/include/uapi/asm/ucontext.h. The continued use of
> the wrapper when reusing a dirty build tree resulted in build failures
> in arch/mips/kernel/signal.c:
> 
> arch/mips/kernel/signal.c: In function ‘sc_to_extcontext’:
> arch/mips/kernel/signal.c:142:12: error: ‘struct ucontext’ has no member named ‘uc_extcontext’
>   return &uc->uc_extcontext;
>             ^
> 
> Fix by detecting and removing wrapper headers in generated header
> directories that do not correspond to a filename in generic-y, genhdr-y,
> or the newly introduced generated-y.

Good idea.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Can you merge this through the mips tree, or do you need me to pick it
up through asm-generic?
