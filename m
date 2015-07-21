From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 08/10] arch: introduce strict_ioremap
Date: Tue, 21 Jul 2015 09:11:29 -0700
Message-ID: <CAPcyv4gsvLmB9QPP=C6RqXuyWeBF_JyubnLypUnoEhJiQL0hbA@mail.gmail.com>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150720001817.30857.69287.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150721133051.GB8902@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150721133051.GB8902@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Luis Rodriguez <mcgrof@suse.com>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Kani, Toshimitsu" <toshi.kani@hp.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 21, 2015 at 6:30 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Sun, Jul 19, 2015 at 08:18:17PM -0400, Dan Williams wrote:
>> In preparation for enabling memremap(), add support for strict mappings.
>> strict_ioremap_<type>() returns NULL if the arch does not implement the
>> mapping type, rather than falling back silently to ioremap().
>
> Please don't introduce another large number of ioremap variants.
>
> I think we should go straight to the ioremap_flags variant, although
> I wonder if we should even bother with ioremap_flags for this use
> case, given that we really want memremap-like semantics for anything
> that isn't plain ioremap (and maybe ioremap_nocache).
>
> Sorry or being the downer, but I really think we need to clean up this
> mess deeply insted of trying to paper over it.

No worries.  I'll rework the series around the idea that memremap() is
a replacement rather than a wrapper for ioremap_<type>().
