From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 8/9] RISC-V: User-facing API
Date: Wed, 28 Jun 2017 23:52:45 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1706282351470.1890@nanos>
References: <20170606230007.19101-1-palmer@dabbelt.com> <20170628185538.1804-1-palmer@dabbelt.com> <20170628185538.1804-9-palmer@dabbelt.com> <alpine.DEB.2.20.1706282336270.1890@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:53821 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbdF1VyN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2017 17:54:13 -0400
In-Reply-To: <alpine.DEB.2.20.1706282336270.1890@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On Wed, 28 Jun 2017, Thomas Gleixner wrote:
> On Wed, 28 Jun 2017, Palmer Dabbelt wrote:
> > +	err = __get_user(prev, ptr);
> 
> Sigh. Type safety is overrated, right?

But the comment above your __get_user() implementation says:

+ * @ptr must have pointer-to-simple-variable type, and the result of
+ * dereferencing @ptr must be assignable to @x without a cast.
