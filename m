From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 16/23] make section names compatible with
 -ffunction-sections -fdata-sections: ppc
Date: Wed, 2 Jul 2008 07:54:59 -0400
Message-ID: <20080702075459.44334db9@zod.rchland.ibm.com>
References: <200807020240.03443.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <200807020240.03443.vda.linux@googlemail.com>
Sender: linux-embedded-owner@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Wed, 2 Jul 2008 02:40:03 +0200
Denys Vlasenko <vda.linux@googlemail.com> wrote:

> The purpose of this patch is to make kernel buildable
> with "gcc -ffunction-sections -fdata-sections".
> This patch fixes ppc architecture.
> 
> Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>

You can drop this one entirely.  arch/ppc won't exist in 2.6.27.  It
has been removed in the powerpc tree already.

josh
