Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34483 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbbGWBC7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2015 21:02:59 -0400
Received: by wibud3 with SMTP id ud3so2589208wib.1
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2015 18:02:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150723005543.GK30479@wotan.suse.de>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150720001822.30857.65670.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150721235848.GI30479@wotan.suse.de>
	<CAPcyv4jXyHzXUmr1LNL3vTzgced8Onrq9OZR2Ub1E85HnOru1Q@mail.gmail.com>
	<20150722225557.GJ30479@wotan.suse.de>
	<CAPcyv4hH7+Dr7NHYXcLfE_-QUwhE9b9tesjjcj4gk4pqJLajBQ@mail.gmail.com>
	<20150723005543.GK30479@wotan.suse.de>
Date: Wed, 22 Jul 2015 18:02:58 -0700
Message-ID: <CAPcyv4gwdNV8vbf4O8aVC87xpiwjMfnd9uRLaQ26R95SiaSosg@mail.gmail.com>
Subject: Re: [PATCH 09/10] arch: introduce memremap()
From: Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Kani, Toshimitsu" <toshi.kani@hp.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20150723010258.T8neoSf9_uEtVf1UoTv0xpNO39mXRWNGyCqNMT0HUqo@z>

On Wed, Jul 22, 2015 at 5:55 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> On Wed, Jul 22, 2015 at 04:15:41PM -0700, Dan Williams wrote:
> Anyway so why is WB and WT allowed if you are going to remove WC and not add UC?
>

Because all existing usages of WB and WT mappings are clearly free of
I/O side effect concerns.  The WC and now UC usages are a muddy mix of
"sometimes there's I/O side effects, but it depends by arch and
driver".
