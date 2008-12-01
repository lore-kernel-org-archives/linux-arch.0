From: "Hitoshi Mitake" <h.mitake@gmail.com>
Subject: Re: [PATCH 1/1] edac x38: new MC driver module
Date: Tue, 2 Dec 2008 08:58:19 +0900
Message-ID: <a6b9f31a0812011558o373edbd3r9690efe539d43ca0@mail.gmail.com>
References: <20081129192610.716a2d57.h.mitake@gmail.com>
	 <20081129222449.e341f028.h.mitake@gmail.com>
	 <20081129180144.GA15533@uranus.ravnborg.org>
	 <20081130171604.dc3c8715.h.mitake@gmail.com>
	 <20081130083700.GA31644@elte.hu> <20081130092407.GA10802@elte.hu>
	 <20081201002056.d9f9204c.h.mitake@gmail.com>
	 <20081130161504.GA25627@elte.hu>
	 <a6b9f31a0812010551h28c0841fxa2a26af4645df64@mail.gmail.com>
	 <20081201135922.GA30068@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:20605 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbYLAX6V (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Dec 2008 18:58:21 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1074837ywe.1
        for <linux-arch@vger.kernel.org>; Mon, 01 Dec 2008 15:58:19 -0800 (PST)
In-Reply-To: <20081201135922.GA30068@elte.hu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Sam Ravnborg <sam@ravnborg.org>, "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Luck, Tony" <tony.luck@intel.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>, Doug Thompson <norsk5@yahoo.com>, dougthompson@xmission.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Dec 1, 2008 at 22:59, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Hitoshi Mitake <h.mitake@gmail.com> wrote:
>
>> On Mon, Dec 1, 2008 at 01:15, Ingo Molnar <mingo@elte.hu> wrote:
>> >
>> > * Hitoshi Mitake <h.mitake@gmail.com> wrote:
>> >
>> >> On Sun, 30 Nov 2008 10:24:07 +0100
>> >> Ingo Molnar <mingo@elte.hu> wrote:
>> >>
>> >> >
>> >> > the 32-bit build broke promptly - readq/writeq is a family of APIs that
>> >> > has to be either fully provided or not provided at all. The fix is below.
>> >>
>> >> Thanks for your fix and adding!
>> >> When will this patch be added to mainline?
>> >> I want to rewrite x38_edac.c to adapt new APIs.
>> >
>> > v2.6.29 at the earliest - if there are no regressions. A number of
>> > drivers use these APIs and usage is a bit messy - so bugs could be
>> > triggered, etc.
>> >
>> Thanks. What is URL of your repository?
>> I want to look your tree and test it.
>
> you can pick up tip/master via:
>
>  http://people.redhat.com/mingo/tip.git/README
>

Thanks!
