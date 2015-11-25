From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 2/2] restrict /dev/mem to idle io memory ranges
Date: Tue, 24 Nov 2015 17:28:54 -0800
Message-ID: <CAPcyv4jtWocaoocfzvpHgR=0mg0GPo7-nBrzkARQpTz6=oAupg@mail.gmail.com>
References: <20151124000553.26360.57819.stgit@dwillia2-desk3.jf.intel.com>
	<20151124000604.26360.56945.stgit@dwillia2-desk3.jf.intel.com>
	<20151124142521.e6d23e44a8b2c24c044c2dec@linux-foundation.org>
	<CAPcyv4ijWns879DytqUa+=r5hzQ1qzmB83VV6Z16kQNtmHUtbA@mail.gmail.com>
	<20151124164711.0cb9ecdbba2fc729273f3240@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34266 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255AbbKYB24 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Nov 2015 20:28:56 -0500
Received: by wmvv187 with SMTP id v187so235496436wmv.1
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2015 17:28:54 -0800 (PST)
In-Reply-To: <20151124164711.0cb9ecdbba2fc729273f3240@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Nov 24, 2015 at 4:47 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 24 Nov 2015 16:34:19 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
>
>> > IOW, a very good description of the problem-being-solved would help out
>> > a lot here...
>>
>> I'll fold the eventual result of this discussion into the changelog if
>> I can convince you it's worth moving forward.
>
> I'm easily convinced ;) Please let's get all the info into the right
> place, make sure it answers the thus-far-asked questions (at least) and
> we'll take it from there.
>
> And please do have a think about switching as much as possible over to
> runtime-configurability.  Because "please echo foo > /proc" is a heck
> of a lot nicer than "please reboot with iomem=" which is a heck of a lot
> nicer than "please ask vendor for a new kernel".

Actually, we already have runtime configuration.  For example, if you
want to muck with pmem via /dev/mem, just do this first:

    echo namespace0.0 > /sys/bus/nd/drivers/nd_pmem/unbind
