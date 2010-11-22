From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [RFC] persistent store
Date: Mon, 22 Nov 2010 10:33:05 -0800
Message-ID: <AANLkTi=YTro_ZgsZCpznXR9aT+rV=Ukg6q1n0m9X724f@mail.gmail.com>
References: <4ce85e437577ae827@agluck-desktop.sc.intel.com>
	<1290391175.2903.132.camel@yhuang-dev>
	<AANLkTi=fNH4-VjLh1zzk-UdEQevR16_K8igdLeodw6yL@mail.gmail.com>
	<AANLkTimqn+qS5RxETz1DznsMDS4gZBGxkLkdCgTQ7qG-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33362 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756567Ab0KVSdG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Nov 2010 13:33:06 -0500
In-Reply-To: <AANLkTimqn+qS5RxETz1DznsMDS4gZBGxkLkdCgTQ7qG-@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Huang Ying <ying.huang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@elte.hu" <mingo@elte.hu>, "greg@kroah.com" <greg@kroah.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Linux Embedded <linux-embedded@vger.kernel.org>

On Mon, Nov 22, 2010 at 10:24 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Any tangents with "pramfs: persistent and protected RAM filesystem"
> on linux-embedded?

That looks nice for building on top on a sane h/w design (a
block of non-volatile RAM).  My pstore code works with
uglier things. The ACPI/ERST interface provides ways to
read/write/clear "records" from what might be some NVRAM,
but might also be a channel to a service processor ... and
ERST is what I'd like to see made usable (without subjecting
users to the implementation details).

-Tony
