From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/9] RISC-V: Init and Halt Code
Date: Thu, 29 Jun 2017 11:44:32 +0200
Message-ID: <CAMuHMdXOOyRT5Vogi3F-x9O2R4GXazxSXQ1Q3F2VbfBEFFLEiw@mail.gmail.com>
References: <20170606230007.19101-1-palmer@dabbelt.com> <20170628185538.1804-1-palmer@dabbelt.com>
 <20170628185538.1804-2-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34498 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751725AbdF2Joe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2017 05:44:34 -0400
In-Reply-To: <20170628185538.1804-2-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Stephen Rothwell <sfr@canb.auug.org.au>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Russell King <rmk+kernel@armlinux.org.uk>, Mark Salter <msalter@redhat.com>, Tobias Klauser <tklauser@distanz.ch>, Will Deacon <will.deacon@arm.com>, James Hogan <james.hogan@imgtec.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Guenter Roeck <linux@roeck-us.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, albert@sifive.com

Hi Palmer,

On Wed, Jun 28, 2017 at 8:55 PM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> This contains the various __init C functions, the initial assembly
> kernel entry point, and the code to reset the system.  When a file was
> init-related, it contains

...?

> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>

Gr{oetje,eeting}s,

                        Geert
