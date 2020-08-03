Return-Path: <SRS0=OB7A=BN=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:47829 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgHCTFR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 Aug 2020 15:05:17 -0400
Date: Mon, 3 Aug 2020 12:05:06 -0700
From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 13/36] vmlinux.lds.h: add PGO and AutoFDO input
 sections
Message-ID: <20200803190506.GE1299820@tassilo.jf.intel.com>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-14-keescook@chromium.org>
 <20200801035128.GB2800311@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801035128.GB2800311@rani.riverdale.lan>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Jian Cai <jiancai@google.com>, =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>, Luis Lozano <llozano@google.com>, Manoj Gupta <manojgupta@google.com>, stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
Message-ID: <20200803190506.vYuFXy3RWfROPlh6UqnFXO4ICDDG2R6Q7Mp7HVd0Dg8@z>

> However, the history of their being together comes from
> 
>   9bebe9e5b0f3 ("kbuild: Fix .text.unlikely placement")
> 
> which seems to indicate there was some problem with having them separated out,
> although I don't quite understand what the issue was from the commit message.

Separating it out is less efficient. Gives worse packing for the hot part
if they are not aligned to 64byte boundaries, which they are usually not. 

It also improves packing of the cold part, but that probably doesn't matter.

-Andi
