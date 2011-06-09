From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 13/14] PCSPKR: Cleanup Kconfig dependencies
Date: Thu, 09 Jun 2011 15:09:32 +1000
Message-ID: <1307596172.2874.268.camel@pasglop>
References: <20110601180456.801265664@duck.linux-mips.net>
	<20110601180610.984881988@duck.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20110601180610.984881988@duck.linux-mips.net>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: ralf@linux-mips.org
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-alpha@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, "H. Peter
	Anvin" <hpa@zytor.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>
List-Id: linux-arch.vger.kernel.org

On Wed, 2011-06-01 at 19:05 +0100, ralf@linux-mips.org wrote:
> plain text document attachment
> (i8253-use-aux-symbol-for-pcspkr-config.patch)
> Lenghty lists of the kind "depends on ARCH1 || ARCH2 ... || ARCH123" are
> usually either wrong or too coarse grained.  Or plain an ugly sin.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> To: linux-kernel@vger.kernel.org
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org
