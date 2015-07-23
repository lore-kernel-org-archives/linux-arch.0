From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 09/10] arch: introduce memremap()
Date: Wed, 22 Jul 2015 18:02:58 -0700
Message-ID: <CAPcyv4gwdNV8vbf4O8aVC87xpiwjMfnd9uRLaQ26R95SiaSosg@mail.gmail.com>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150720001822.30857.65670.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150721235848.GI30479@wotan.suse.de>
	<CAPcyv4jXyHzXUmr1LNL3vTzgced8Onrq9OZR2Ub1E85HnOru1Q@mail.gmail.com>
	<20150722225557.GJ30479@wotan.suse.de>
	<CAPcyv4hH7+Dr7NHYXcLfE_-QUwhE9b9tesjjcj4gk4pqJLajBQ@mail.gmail.com>
	<20150723005543.GK30479@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150723005543.GK30479@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Kani, Toshimitsu" <toshi.kani@hp.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 22, 2015 at 5:55 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> On Wed, Jul 22, 2015 at 04:15:41PM -0700, Dan Williams wrote:
> Anyway so why is WB and WT allowed if you are going to remove WC and not add UC?
>

Because all existing usages of WB and WT mappings are clearly free of
I/O side effect concerns.  The WC and now UC usages are a muddy mix of
"sometimes there's I/O side effects, but it depends by arch and
driver".
