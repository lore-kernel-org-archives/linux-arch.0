Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 17 Mar 2005 23:27:19 +0000
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Consolidation of asm/unaligned.h
Message-ID: <20050317232719.GA5170@linux-mips.org>
References: <20050317104744.4be7e550.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050317104744.4be7e550.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Mar 17, 2005 at 10:47:44AM -0800, David S. Miller wrote:

> 7) MIPS appears to be a copy of the original alpha/ia64 unaligned.h header,
>    so I converted it to use the new asm-generic/unaligned.h too

That's indeed the heritage of the current MIPS implementation.  We used to
use inline assembler because some older compiler (afair egcs 1.0.3a or
egcs 1.1.2 vintage) used to generate very bad code from the packed method.

> Any suggested changes or objections?

Looks good.

  Ralf
