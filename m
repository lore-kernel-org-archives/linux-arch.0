From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 2/2] restrict /dev/mem to idle io memory ranges
Date: Tue, 24 Nov 2015 16:50:41 -0800
Message-ID: <CAGXu5j+N2o7UvLzq3Arw3zFEz1hLPEipcKu3RWyQ1m7BG0Ku=g@mail.gmail.com>
References: <20151124000553.26360.57819.stgit@dwillia2-desk3.jf.intel.com>
	<20151124000604.26360.56945.stgit@dwillia2-desk3.jf.intel.com>
	<20151124142521.e6d23e44a8b2c24c044c2dec@linux-foundation.org>
	<CAPcyv4ijWns879DytqUa+=r5hzQ1qzmB83VV6Z16kQNtmHUtbA@mail.gmail.com>
	<20151124164711.0cb9ecdbba2fc729273f3240@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:35140 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771AbbKYAun (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Nov 2015 19:50:43 -0500
Received: by ioc74 with SMTP id 74so38636856ioc.2
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2015 16:50:43 -0800 (PST)
In-Reply-To: <20151124164711.0cb9ecdbba2fc729273f3240@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

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

I think run-time config for this should be an as-needed case. Nothing
should be fiddling with this memory from userspace anyway -- a driver
covering it should be unloaded first.

And, with my dosemu maintainer hat on, If you're using dosemu in a
mode where this will cause a problem, you are already running a custom
kernel. :)

And that said, if someone can actually produce a case where we need
this runtime configurable, I'm all for it. I just don't think we need
to design it in right now.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
