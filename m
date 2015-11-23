From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] arch: consolidate CONFIG_STRICT_DEVM in lib/Kconfig.debug
Date: Mon, 23 Nov 2015 09:12:22 -0800
Message-ID: <CAPcyv4hDbi5KJ+tGJnEwQV5G=PM+ZRooQbgTNrYxyyVVPA3EwA@mail.gmail.com>
References: <20151122035702.9313.52457.stgit@dwillia2-desk3.jf.intel.com>
	<20151123081235.GA23661@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37435 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbbKWRMX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2015 12:12:23 -0500
Received: by wmww144 with SMTP id w144so113863113wmw.0
        for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2015 09:12:22 -0800 (PST)
In-Reply-To: <20151123081235.GA23661@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Nov 23, 2015 at 12:12 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Dan Williams <dan.j.williams@intel.com> wrote:
>
>> Let all the archs that implement CONFIG_STRICT_DEVM use a common
>> definition in lib/Kconfig.debug.
>
> For the x86 bit:
>
> Acked-by: Ingo Molnar <mingo@kernel.org>
>
>> Note, the 'depends on !SPARC' is due to sparc not implementing
>> devmem_is_allowed().
>
> Maybe that should be converted into a helper Kconfig switch for architectures to
> opt in to /dev/mem restrictions?

Sure, easy enough to add a ARCH_HAS_DEVMEM_IS_ALLOWED opt-in.
